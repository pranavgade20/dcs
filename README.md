# dcs - docker vcs

git is lame. Containers and docker are cool. So, stop using git and start using dcs, the version control system built on top of docker!

git is confusing. Who is merging what where? Too many branches? Do you often spend too long on thinking about commit messages? With dcs, you will never have to worry about these, and more again!

## Features
- `dcs init` initialises a new dcs repo in the current directory
- `dcs commit` creates a new commit. No, you can't have commit messages. You were gonna write "asdf" anyway.
- `dcs push` pushes your commits to a docker repository. Any container repo, no additional setup required!
- `dcs pull` pulls your commits from a container repository, into the current directory.

## Installation
dcs is a very lightweight bash script. You can simply download `dsc.sh` and add it to your path. For example, if the script is at `~/dcs/dcs.sh`, then you can add `alias dcs='~/dcs/dcs.sh'` to your `~/.bashrc` file.

## Dependencies
You need to have the following packages installed:
- `docker`
- `openssl`
Other requirements like tar, grep, awk, etc. are preinstalled on most linux distros.