#Java
export PATH="/usr/local/opt/openjdk/bin:$PATH"

#Nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm 


#git
alias g="git branch"
alias gs="git status"

#npm
alias i="npm install"
alias s="npm start"
alias d="npm run dev"
alias b="npm run build"
alias sb="serve -s build"

# directories
alias p="cd /Volumes/Store/projects;"
alias prb="cd /Volumes/Store/projects/raildata/backend;d;"

#pnpm
alias pi="pnpm install"

#clear
alias rmn="rm -rf node_modules package-lock.json"

# pnpm
export PNPM_HOME="/Users/psb/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
