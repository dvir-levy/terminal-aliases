## Usage

This folder have .aliases file which includes terminal aliases for faster and more convenient work with the terminal. Mainly focused on git and terraform work.


## Configuration

### ZSH

1. Copy the file to your home folder 
```
cp .aliases ~
```

2. Add the following line anywhere in your `~/.zshrc` file:
```
source ~/.aliases
```

3. change the workspace variable according to your folders structure:
```
workspace_path=~/my-workspace
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

3. re-open your terminal or run the following:
```
source ~/.zshrc
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
