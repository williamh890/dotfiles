# setup.py
# William Horn

# Script used to setup a linux box with all of my settings

from os import makedirs as mkdirs, system
from os.path import expanduser, join
from sys import argv
from shutil import copyfile
import json
import requests

# Load in settings from json file
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


# Install youCompleteMe and all of its dependencies
def ycm_setup():
    print("INSTALLING YOUCOMPLETEME DEPENDENCIES")
    packages = ['build-essential', 'python-pip',
                'cmake', 'python-dev', 'python3-dev']

    for p in packages:
        install_pkg = "sudo apt-get install {p} -y".format(p=p)
        try:
            system(install_pkg)
        except Exception as e:
            print(e)
            print("ERROR installing package {}".format(p))

    system('sudo pip install --upgrade autopep8')
    # Run the ycm install script
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


def setup_vim():
    print("SETTING UP VIM")
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


def move_dotfiles():
    dotfiles_path = expanduser('~/repositories/dotfiles/')

    # Copy dotfiles into home directory
    for dotfile in ['.bashrc', '.vimrc']:
        path = join(dotfiles_path, dotfile)
        system("cp {} ~".format(path))


def install_chrome():
    cmds = [
        "sudo apt -y install libxss1 libappindicator1 libindicator7",
        "wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb",
        "sudo dpkg -i google-chrome-stable_current_amd64.deb",
        "sudo apt-get install -f"
    ]

    for cmd in cmds:
        system(cmd)


def setup():
    install_chrome()
    repos_path = expanduser("~/repositories")

    try:
        mkdirs(repos_path)
    except Exception:
        print("repo path already exists")

    download_repos(config['github_username'], repos_path)
    move_dotfiles()

    setup_vim()

    print()
    print(config['font_reminder'])


if __name__ == "__main__":
    setup()
