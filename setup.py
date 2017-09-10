
from os import makedirs as mkdirs, system
from os.path import expanduser, join
from sys import argv
import json
import requests

setup_file = "setup.json" if len(argv[1:]) == 0 else argv[1]
with open(setup_file) as f:
    config = json.load(f)


def download_repos(username, repos_path):
    url = join(config['github_api_url'],  "users", username, "repos")
    print(url)
    repos = json.loads(requests.get(url).text)

    for repo in repos:
        git_url, name = [repo[k] for k in ['git_url', 'name']]
        path = join(repos_path, name)
        try:
            system("git clone --recursive {repo} {name}".format(repo=git_url, name))
        except Exception as e:
            print("Repo already downloaded {}".format(git_url))


def setup():
    repos_path = expanduser("~/repositories")
    try:
        mkdirs(repos_path)
    except:
        print("repo path already exists")

    download_repos(config['github_username'], repos_path)


if __name__ == "__main__":
    setup()
