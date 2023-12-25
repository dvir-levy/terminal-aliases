## Usage

Terminal aliases for faster and more convenient work with the terminal. Mainly focused on git and terraform work.


## Installation

### ZSH

1. oh-my-zsh
```
git clone https://github.com/dvir-levy/terminal-aliases.git ~/.oh-my-zsh/custom/plugins/terminal-aliases
```
And add terminal-aliases to plugins in .zshrc.


2. Set the environment variable to your own workspace directory that include your repos
```
export WORKSPACE_PATH=~/Workspace/my-workspace/
```


NOTE: the folders structure should be single workspace with several repos in it.
for example:
```
.my-workspace
├──repo1
├──repo2
├──repo3
├──terraform-repo1
└──terraform-repo2

```

## Usage Examples

1. git checkout to main/master and pull
```
gcm
```


2. git status
```
gst
```


3. Create new GitHub Pull Request
```
newpr delete_temp_lc_rules_datalake_gold SECURITY-357
```
NOTE: the branch should be main/master and commit changes should be made locally on master. the alias will makes sure to create new branch and pull request.


4. 'git add' to all changes, 'git commit' with your custom comment and 'git push' - all together
```
gam "added debugging methods"
```


## License

This repo is licensed under the terms of the MIT Open Source
license and is available for free.
Feel free to open pull request and help improve it
