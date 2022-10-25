from os import makedirs as mkdirs, system
from os.path import expanduser, join
from sys import argv
from shutil import copyfile
import json
import requests
import tarfile

setup_file = "setup.json" if len(argv[1:]) == 0 else argv[1]
with open(setup_file) as f:
    config = json.load(f)


def git_clone(git_url, path=''):
    try:
        cmd = "git clone --recursive {repo} {name}".format(
            repo=git_url, name=path)
        system(cmd)
    except Exception:
        print("Repo already downloaded {}".format(git_url))


def download_repos(username, repos_path):
    print("DOWNLOADING REPOS")
    url = join(config['github_api_url'],  "users", username, "repos")
    print(url)
    repos = json.loads(requests.get(url).text)
    for repo in repos:
        git_url, name = [repo[k] for k in ['git_url', 'name']]
        path = join(repos_path, name)

        git_clone(git_url, path)


def install_processing():
    url = config['processing_url']
    name = config['processing_name']
    path = expanduser("~/Programs")
    tar_path = join(path, "{name}.tgz".format(name=name))

    try:
        mkdirs(path)
    except Exception:
        print("Programs dir already exists")

    cmd = "curl -L {url} > {path}".format(url=url, path=tar_path)
    print(cmd)
    system(cmd)

    with tarfile.open(tar_path) as ptar:
        
        import os
        
        def is_within_directory(directory, target):
            
            abs_directory = os.path.abspath(directory)
            abs_target = os.path.abspath(target)
        
            prefix = os.path.commonprefix([abs_directory, abs_target])
            
            return prefix == abs_directory
        
        def safe_extract(tar, path=".", members=None, *, numeric_owner=False):
        
            for member in tar.getmembers():
                member_path = os.path.join(path, member.name)
                if not is_within_directory(path, member_path):
                    raise Exception("Attempted Path Traversal in Tar File")
        
            tar.extractall(path, members, numeric_owner=numeric_owner) 
            
        
        safe_extract(ptar)

    # Run the install script
    system(join(path, name, "install.sh"))


# Install youCompleteMe and all of its dependencies
def ycm_setup():
    print("INSTALLING YOUCOMPLETEME DEPENDENCIES")

    system('sudo pip install --upgrade autopep8')
    system("cd ~/.vim/bundle/YouCompleteMe  && ./install.py --clang-completer")


# Download the colorscheme and move it into .vim/colors
def vim_colorscheme():
    print("GETTING COLOR SCHEME")
    keys = ['scheme_repo_url', 'scheme_repo_name', 'scheme_name']
    url, repo, file_name = [config[k] for k in keys]

    git_clone(url)

    src = join(repo, 'colors', file_name)
    dest = expanduser('~/.vim/colors/')
    try:
        print("making dirs '{}'".format(dest))
        system('mkdir -p {dirs}'.format(dirs=dest))
    except Exception:
        print("vim color directory already exists")

    copyfile(src, join(dest, file_name))

    # Remove colorscheme repository
    system("rm -rf {}".format(repo))


def powerline_fonts():
    url = 'https://github.com/powerline/fonts.git'
    git_clone(url)

    system('./fonts/install.sh')
    system('rm -rf fonts')


def install_vim8():
    print("INSTALLING VIM8")

    cmds = [
        'sudo add-apt-repository ppa:jonathonf/vim',
        'sudo apt update',
        'sudo apt install vim'
    ]

    for cmd in cmds:
        print(cmd)
        system(cmd)


def setup_vim():
    print("SETTING UP VIM")

    install_vim8()

    # installing vundle
    git_clone("https://github.com/VundleVim/Vundle.vim.git",
              expanduser("~/.vim/bundle/Vundle.vim"))

    # To not give error when color scheme cannot be found
    vim_colorscheme()
    try:
        system('vim -c "PluginInstall" -c "qa!"')
    except Exception:
        print("Error installing plugins...")

    ycm_setup()
    powerline_fonts()


def install_npm():
    cmds = [
        "curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -",
        "sudo apt-get install -y nodejs"
    ]

    for cmd in cmds:
        system(cmd)


def install_linters():
    cmds = [
        'luarocks install luacheck',
        'npm install -g sass-lint',
        'npm install -g csslint',
        'sudo apt install shellcheck',
        'sudo npm install -g htmlhint',
        'npm install -g csslint'
    ]

    for cmd in cmds:
        system(cmd)


def link_dotfiles():
    dotfiles_path = expanduser('~/repositories/dotfiles/')

    for dotfile in ['.bashrc', '.vimrc', '~/.vim/plugins.vim', '.tmux.conf', '.inputrc', '.gitconfig']:
        path = join(dotfiles_path, dotfile)
        system("ln {} ~".format(path))


def install_programs():
    for prog in config['programs']:
        url, deb = prog['url'], f"{prog['name']}.deb"
        print(f"installing {deb}")
        cmds = [
            f"curl {url} -L > {deb}",
            f"sudo apt install ./{deb} -y"
        ]

        for cmd in cmds:
            print(cmd)
            system(cmd)


def setup_capslock():
    cmds = [
        'dconf write /org/gnome/desktop/input-sources/xkb-options '
        '"[\'caps:escape\']"'
    ]

    for cmd in cmds:
        print(cmd)
        system(cmd)

    with open(expanduser("~/.xinitrc"), "w") as f:
        f.write("xmodmap .xmodmap")


def install_packages():
    pkgs = ""
    for pkg in open('packages.txt'):
        pkgs += pkg.strip() + " "
    print(pkgs)
    system('sudo apt install -y {}'.format(pkgs))


def install_fingerprint_reader():
    cmds = [
        "sudo add-apt-repository ppa:fingerprint/fingerprint-gui -y",
        "sudo apt update -y",
        "sudo apt install libbsapi policykit-1-fingerprint-gui fingerprint-gui -y"
    ]

    for cmd in cmds:
        system(cmd)


def setup():
    install_packages()

    install_chrome()
    repos_path = expanduser("~/repositories")

    try:
        mkdirs(repos_path)
    except Exception:
        print("repo path already exists")

    setup_capslock()
    download_repos(config['github_username'], repos_path)
    link_dotfiles()

    setup_vim()

    install_npm()
    install_linters()

    print()
    print(config['font_reminder'])


def install_docker():
    cmds = [
        "sudo apt update",
        "sudo apt install " +
        "apt-transport-https " +
        "ca-certificates " +
        "curl " +
        "software-properties-common -y",

        "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",

        'sudo add-apt-repository' +
        '"deb [arch=amd64] https://download.docker.com/linux/ubuntu ' +
        '$(lsb_release - cs) ' +
        'stable',

        'sudo apt update',

        'sudo apt install docker-ce -y'
    ]

    for cmd in cmds:
        print(cmd)
        system(cmd)


if __name__ == "__main__":
    install_docker()
