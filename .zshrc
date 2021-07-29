export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completionΩ

# directories
alias p="cd /Volumes/Store/projects;"
alias py="cd /Volumes/Store/projects/youty;s;"

#npm
alias n="npm install"
alias s="npm start"
alias b="npm run build"
alias sb="serve -s build"

#clear
alias rmn="rm -rf node_modules package-lock.json"

#updates
alias ur="npm install react-scripts react react-dom"
alias un="npm update"

#git
alias g="git branch"
alias gs="git status"