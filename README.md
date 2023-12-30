## terminal-aliases

Terminal aliases for faster and more convenient work with the terminal. Mainly focused on git and terraform work.


## Installation

### ZSH

Using [Oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh):
1. Clone this repository in oh-my-zsh's plugins directory:
```
git clone https://github.com/dvir-levy/terminal-aliases.git ~/.oh-my-zsh/custom/plugins/terminal-aliases
```

2. Activate the plugin in ~/.zshrc:
```
plugins=(
  plugin1
  plugin2
  ...
  teminal-aliases
)
```

3. Set the WORKSPACE_PATH environment variable to your own workspace directory that include your repos.
```
export WORKSPACE_PATH=<MY_WORKSPACE>
```

The following script adds it to the beginning of ~/.zshrc. Make sure to change <MY_WORKSPACE> to your workspaces path.
```
echo "export WORKSPACE_PATH=<MY_WORKSPACE>" > ~/.zshrc.tmp
echo "" >> ~/.zshrc.tmp
cat ~/.zshrc >> ~/.zshrc.tmp
mv ~/.zshrc.tmp ~/.zshrc

echo "# terminal-aliases plugin" > ~/.zshrc.tmp
echo "" >> ~/.zshrc.tmp
cat ~/.zshrc >> ~/.zshrc.tmp
mv ~/.zshrc.tmp ~/.zshrc
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

4. Run exec zsh to take changes into account:
```
exec zsh
```

Using [zplug](https://github.com/zplug/zplug):

1. Add this repo to `~/.zshrc`:
```
zplug "dvir-levy/terminal-aliases", as: plugin
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
newpr my_new_pr_name SECURITY-357
```
NOTE: the branch should be main/master and commit changes should be made locally on master. the alias will makes sure to create new branch and pull request.


4. 'git add' to all changes, 'git commit' with your custom comment and 'git push' - all together
```
gam "added debugging methods"
```

5. change directory to a repo and show its content
```
repo1
```

6. terraform apply
```
ta
```

7. terraform init + terraform plan
```
tip
```

## License

This repo is licensed under the terms of the MIT Open Source
license and is available for free.
Feel free to open pull request and help improve it
