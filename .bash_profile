# Configuring Our Prompt
# ======================

  # if you install git via homebrew, or install the bash autocompletion via homebrew, you get __git_ps1 which you can use in the PS1
  # to display the git branch.  it's supposedly a bit faster and cleaner than manually parsing through sed. i dont' know if you care
  # enough to change it

  # This function is called in your prompt to output your active git branch.
  function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
  }

  # This function builds your prompt. It is called below
  function prompt {
    # Define some local colors
    local         RED="\[\033[0;31m\]" # This syntax is some weird bash color thing I never
    local   LIGHT_RED="\[\033[1;31m\]" # really understood
    local        BLUE="\[\e[0;49;34m\]"
    local        CHAR="®"

    # ♥ ☆ - Keeping some cool ASCII Characters for reference

    # Here is where we actually export the PS1 Variable which stores the text for your prompt
    export PS1="\[\e[32m\]\w\[\e[0m\]$RED\$(parse_git_branch) \n\[\e[0;31m\]$BLUE$CHAR \[\e[0m\]"
      PS2='> '
      PS4='+ '
    }

  # Finally call the function and our prompt is all pretty
  prompt

  # For more prompt coolness, check out Halloween Bash:
  # http://xta.github.io/HalloweenBash/

  # If you break your prompt, just delete the last thing you did.
  # And that's why it's good to keep your dotfiles in git too.

# Environment Variables
# =====================
  # Library Paths
  # These variables tell your shell where they can find certain
  # required libraries so other programs can reliably call the variable name
  # instead of a hardcoded path.

    # NODE_PATH
    # Node Path from Homebrew I believe
    export NODE_PATH="/usr/local/lib/node_modules:$NODE_PATH"
    NODE_PATH=/usr/local/lib/node

    ### Added by the Heroku Toolbelt
    export PATH="/usr/local/heroku/bin:$PATH"

    export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

    # Those NODE & Python Paths won't break anything even if you
    # don't have NODE or Python installed. Eventually you will and
    # then you don't have to update your bash_profile

  # Configurations

    # GIT_MERGE_AUTO_EDIT
    # This variable configures git to not require a message when you merge.
    export GIT_MERGE_AUTOEDIT='no'

    # Editors
    # Tells your shell that when a program requires various editors, use DEFAULT_EDITOR var.
    # The -w flag tells your shell to wait until atom exits'
    export DEFAULT_EDITOR=atom;

    export VISUAL="$DEFAULT_EDITOR -w"
    export SVN_EDITOR="$DEFAULT_EDITOR -w"
    export GIT_EDITOR="$DEFAULT_EDITOR -w"
    export EDITOR="$DEFAULT_EDITOR -w"

  # Paths

    # The USR_PATHS variable will just store all relevant /usr paths for easier usage
    # Each path is seperate via a : and we always use absolute paths.

    # A bit about the /usr directory
    # The /usr directory is a convention from linux that creates a common place to put
    # files and executables that the entire system needs access too. It tries to be user
    # independent, so whichever user is logged in should have permissions to the /usr directory.
    # We call that /usr/local. Within /usr/local, there is a bin directory for actually
    # storing the binaries (programs) that our system would want.
    # Also, Homebrew adopts this convetion so things installed via Homebrew
    # get symlinked into /usr/local
    export USR_PATHS="/usr/local:/usr/local/bin:/usr/local/sbin:/usr/bin"

    # Hint: You can interpolate a variable into a string by using the $VARIABLE notation as below.

    # We build our final PATH by combining the variables defined above
    # along with any previous values in the PATH variable.

    # Our PATH variable is special and very important. Whenever we type a command into our shell,
    # it will try to find that command within a directory that is defined in our PATH.
    # Read http://blog.seldomatt.com/blog/2012/10/08/bash-and-the-one-true-path/ for more on that.
    export PATH="$USR_PATHS:$PATH"

  # Application configs

    # NVM set up to deal with prefixes
    export NVM_DIR=~/.nvm
    source $(brew --prefix nvm)/nvm.sh

    # Chrome
    alias atskill="atsutil server -shutdown && sleep 5 && atsutil server -ping"
    alias chrome="atskill && open -a \"Google Chrome\""
    
    # Postgres
    alias pg="postgres -D /usr/local/var/postgres"

  # File system

  # edit bash profile
  alias bp="$EDITOR ~/.bash_profile"

  # edit key bindings
  alias kb="$EDITOR ~/Library/KeyBindings/DefaultKeyBinding.dict"

  # reload bash profile config
  alias rbp="source ~/.bash_profile"

  alias ll='ls -lah -GF'
  # alias for going back a directory
  alias ..='cd ..'
  # alias for going back two directory
  alias ...='cd ../..'
  alias ....='cd ../../..'
  alias .....='cd ../../../..'

  alias p="cd ~/projects"

  alias src='source ~/.bash_profile'

  # IP addresses
  alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
  alias localip="ipconfig getifaddr en0"
  alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

  # Flush Directory Service cache
  alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"

  # List all files colorized in long format
  alias l="ls -lF ${colorflag}"

  # List all files colorized in long format, including dot files
  alias la=RS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpate'


  # Git
  alias gitar="git ls-files -d -m -o -z --exclude-standard | xargs -0 git update-index --add --remove" # handles git add step
  alias gitst="git status"
  alias gitcl="git clone"
  alias gpd="git push origin develop"
  alias gpm="git push origin master"
  alias gmd="git merge origin develop"
  alias gmm="git merge origin master"
  alias gpl="git pull"
  alias gp="git push"
  alias gd="git diff | atom"
  alias gc="git commit -v"
  alias gca="git commit -v -a"
  alias gb="git branch"
  alias gba="git branch -a"
  alias gcam="git commit -am"
  alias gbb="git branch -b"
  alias gitroot="while [ ! -d .git ]; do cd ..; done" # get root of current git repo
  alias ungit="find . -name '.git' -exec rm -rf {} \;" # remove git from project

# Functions
# =====================
  c () {
     clear
  }

  status () {
     git status
  }

  add () {
     git add "$@"
  }

  commit () {
     git commit -m"$@"
  }

  pull () {
     git pull origin "$@"
  }

  push () {
     git push origin "$@"
  }

  pullall(){
    for dir in ~/PROJECTS/TBG/samsung/dependencies/*; do (cd "$dir" && git pull); done
  }

  gitresetpush () {
     git reset --hard HEAD~"$@"
     git push origin HEAD --force
  }

  gitcp () {
     git cherry-pick -n "$@"
  }

  gitreset (){
    git reset --hard "$@"
  }

  # checkout file or branch
  gitco (){
    git checkout "$@"
  }

  # Delete remote branch
  delremote () {
    git push origin :"$@"
  }
  # Delete local branch
  dellocal () {
    git branch -D "$@"
  }

  #extract from any compressed file type
  extract () {
    if [ -f $1 ] ; then
    case $1 in
    *.tar.bz2)tar xjf $1;;
    *.tar.gz)tar xzf $1;;
    *.bz2)bunzip2 $1;;
    *.rar)rar x $1;;
    *.gz)gunzip $1;;
    *.tar)tar xf $1;;
    *.tbz2)tar xjf $1;;
    *.tgz)tar xzf $1;;
    *.zip)unzip $1;;
    *.Z)uncompress $1;;
    *)echo "'$1' cannot be extracted via extract()" ;;
    esac
    else
    echo "'$1' is not a valid file"
    fi
  }

# Case-Insensitive Auto Completion
  bind "set completion-ignore-case on"

# Final Configurations and Plugins
# =====================
  # Git Bash Completion
  # Will activate bash git completion if installed
  # via homebrew
  if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
  fi

  # RVM
  # Mandatory loading of RVM into the shell
  # This must be the last line of your bash_profile always
  [[ -s "/Users/$USER/.rvm/scripts/rvm" ]] && source "/Users/$USER/.rvm/scripts/rvm"  # This loads RVM into a shell session.
