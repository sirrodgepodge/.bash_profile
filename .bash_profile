# switch to Bash from Zsh
export BASH_SILENCE_DEPRECATION_WARNING=1 # kill warning for using bash
if [ -n "$ZSH_VERSION" ]; then
   chsh -s /bin/bash
fi

# Disable bracketed paste mode to fix paste issues
bind 'set enable-bracketed-paste off' 2>/dev/null || true
bind '"\C-j": "\C-v\C-j"'




# NVM Configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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
    local        CHAR="®"
    local   BLUE="\[\e[0;49;34m\]"

    # ♥ ☆ - Keeping some cool ASCII Characters for reference

    # Here is where we actually export the PS1 Variable which stores the text for your prompt
    export PS1="\[\e[32m\]\w\[\e[0m\]$RED\$(parse_git_branch) \n\[\e[0;31m\]$BLUE$RED$CHAR \[\e[0m\]"
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

    PATH=/opt/homebrew/Cellar/postgresql@17/15.4/bin:~/projects/binaryen/bin:/usr/local/Cellar/php56/5.6.4/bin:/opt/local/bin:/usr/local/bin:/usr/local/share/npm/bin:~/bin:$PATH

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
    # Tells your shell that when a program requires various editors, use VS Code.
    # The -w flag tells your shell to wait until VS Code exits
    export VISUAL="code -w"
    export SVN_EDITOR="code -w"
    export GIT_EDITOR="code -w"
    export EDITOR="code -w"

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

    # If you go into your shell and type: echo $PATH you will see the output of your current path.
    # For example, mine is:
    # /Users/CHANGE_THIS_TO_YOUR_COMPUTER_USER_NAME/.rvm/gems/ruby-1.9.3-p392/bin:/Users/CHANGE_THIS_TO_YOUR_COMPUTER_USER_NAME/.rvm/gems/ruby-1.9.3-p392@global/bin:/Users/CHANGE_THIS_TO_YOUR_COMPUTER_USER_NAME/.rvm/rubies/ruby-1.9.3-p392/bin:/Users/CHANGE_THIS_TO_YOUR_COMPUTER_USER_NAME/.rvm/bin:/usr/local:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/local/mysql/bin:/usr/local/share/python:/bin:/usr/sbin:/sbin:

# Helpful Functions
# =====================

# A function to CD into the desktop from anywhere
# so you just type desktop.
# HINT: It uses the built in USER variable to know your OS X username

# USE: desktop
#      desktop subfolder
function desktop {
  cd /Users/$USER/Desktop/$@
}

# A function to easily grep for a matching process
# USE: psg postgres
function psg {
  FIRST=`echo $1 | sed -e 's/^\(.\).*/\1/'`
  REST=`echo $1 | sed -e 's/^.\(.*\)/\1/'`
  ps aux | grep "[$FIRST]$REST"
}

# A function to extract correctly any archive based on extension
# USE: extract imazip.zip
#      extract imatar.tar
function extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)  tar xjf $1      ;;
            *.tar.gz)   tar xzf $1      ;;
            *.bz2)      bunzip2 $1      ;;
            *.rar)      rar x $1        ;;
            *.gz)       gunzip $1       ;;
            *.tar)      tar xf $1       ;;
            *.tbz2)     tar xjf $1      ;;
            *.tgz)      tar xzf $1      ;;
            *.zip)      unzip $1        ;;
            *.Z)        uncompress $1   ;;
            *)          echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Aliases
# =====================
  # LS
  alias l='ls -lah'
  # alias for quickly listing a directory
  alias l='ls -GF'
  # alias for quickly listing a directory
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
  alias la="ls -laF ${colorflag}"

  # List only directories
  alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"

  # Always use color output for `ls`
  alias ls="command ls ${colorflag}"
  export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

  # Enable aliases to be sudo'ed
  alias sudo='sudo '

  # Get week number
  alias week='date +%V'

  # Stopwatch
  alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

  # Get OS X Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
  alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm install npm -g; npm update -g; sudo gem update --system; sudo gem update'

  # Postgres
  alias pg="/opt/homebrew/opt/postgresql@17/bin/postgres -D /opt/homebrew/var/postgresql@17"

  # Postgres
  psqlx () {
    psql -x "$@"
  }

  # Brave
  alias brave="/Applications/Brave\ Browser.app/Contents/MacOS/Brave\ Browser"

  # Chrome
  alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"

  # Firefox
  alias firefox="/Applications/Firefox.app/Contents/MacOS/firefox"

  # Safari
  alias safari="/Applications/Safari.app/Contents/MacOS/Safari"

  # Git
  alias gitst="git status"
  alias gst="git status"
  alias gcl="git clone"
  alias gl="git pull"
  alias gp="git push"
  alias gd="git diff | code"
  alias gc="git commit -v"
  alias gca="git commit -v -a"
  alias gb="git branch"
  alias gba="git branch -a"
  alias gcam="git commit -am"
  alias gbb="git branch -b"

  # Claude
  alias claude="/Users/rbeaman/.local/bin/claude --dangerously-skip-permissions --continue"
  alias claudecode="/Users/rbeaman/.local/bin/claude"

# Functions
# =====================
  chmodr () {
    find . -type d -exec chmod "$@" \;
  }

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

  # Laravel
  compdump (){
    composer dump-autoload
  }
  # Laravel
  artmigrate () {
    php artisan migrate
  }
  # Laravel
  artseed (){
    php artisan db:seed
  }
  # Delete remote branch
  delremote () {
    git push origin :"$@"
  }
  # Delete local branch
  dellocal () {
    git branch -D "$@"
  }

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

# docker-osx-dev
# export DOCKER_HOST=tcp://192.168.59.103:2376
# export DOCKER_CERT_PATH=/Users/rbeaman/.boot2docker/certs/boot2docker-vm
# export DOCKER_TLS_VERIFY=1
# eval $(docker-machine env default)

##
# Your previous /Users/rbeaman/.bash_profile file was backed up as /Users/rbeaman/.bash_profile.macports-saved_2017-01-22_at_15:59:54
##

# MacPorts Installer addition on 2017-01-22_at_15:59:54: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

# Postgres
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# # added by Anaconda3 4.3.1 installer
# export PATH="/Users/rbeaman/anaconda3/bin:$PATH"

export PKG_CONFIG_PATH="/usr/local/Cellar/opencv/2.4.13.2/lib/pkgconfig:$PKG_CONFIG_PATH"

# export PATH="/usr/local/Cellar/sdl2/2.0.6/include:$PATH"

#for rust globals

#SDL2 rust https://github.com/Rust-SDL2/rust-sdl2
export LIBRARY_PATH="$LIBRARY_PATH:/usr/local/lib"

# For compilers to find zlib you may need to set:
export LDFLAGS="${LDFLAGS} -L/usr/local/opt/zlib/lib"
export CPPFLAGS="${CPPFLAGS} -I/usr/local/opt/zlib/include"

# For pkg-config to find zlib you may need to set:
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH} /usr/local/opt/zlib/lib/pkgconfig"

# Add ~/.local/bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# create emr cluster
alias emrc="EMR_EC2_SUBNET_ID=subnet-c70f8a9e emr cluster create --core-count=20 --core-type=m5d.12xlarge --auto-terminate true"

alias emrc_no_term="EMR_EC2_SUBNET_ID=subnet-c70f8a9e emr cluster create --core-count=20 --core-type=m5d.12xlarge"

# list jobs output from default cluster
alias jobs="emr cluster ssh -- hdfs dfs -ls /jobs"

# copy all jobs output from default cluster to S3
job_copy_all () {
  emr cluster ssh -- hadoop distcp -Dmapreduce.map.memory.mb=76800 -Dmapreduce.reduce.memory.mb=76800 -Dmapred.child.java.opts=-Xmx102400m /jobs/* s3a://reonomy-derived-data/bucket-rodge/
}

# copy single job's output from default cluster to S3
job_copy () {
  emr cluster ssh -- hadoop distcp /jobs/$1 s3a://reonomy-derived-data/bucket-rodge/$2
}

# start standard job
job_start () {
  emr step add job com.reonomy.spark.job.$1 --data-name $2 --snapshot $3 --ref $4 $5
}

job_publish () {
  emr step add job com.reonomy.spark.job.$1 --data-name $2 --snapshot $3 --ref $4 --publish $5 $6
}

job_start_report () {
  emr step add job com.reonomy.report.$1 --data-name $2 --snapshot $3 --ref $4 $5
}

job_publish_report () {
  emr step add job com.reonomy.report.$1 --data-name $2 --snapshot $3 --ref $4 --publish $5 $6
}

job_start_ownership () {
  emr step add job com.reonomy.preownership.$1 --data-name $2 --snapshot $3 --ref $4 $5
}

job_publish_ownership () {
  emr step add job com.reonomy.preownership.$1 --data-name $2 --snapshot $3 --ref $4 --publish $5 $6
}

alias emr='PYTHONPATH=/Users/rbeaman/projects/reonomy/emr EMR_PATH=/Users/rbeaman/projects/reonomy/emr/reonomy /Users/rbeaman/projects/reonomy/emr/venv/bin/python /Users/rbeaman/projects/reonomy/emr/scripts/emr'

function whosonport {
  OUT=$(lsof -nP -iTCP:$1 | grep LISTEN)
  echo $OUT | awk -F" " '{print $2}'
}
function getoffmyport {
  PID=$(whosonport $1)
  if [ -z $PID ]; then
    echo "No one listening"
  else
    kill $PID
    echo "Killed $PID"
  fi;
}

source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc"
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc"

eval "ssh-add --apple-use-keychain ~/.ssh/id_rsa"
eval "ssh-add --apple-use-keychain ~/.ssh/id_rsa_2"
# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

# Disable bracketed paste mode
set enable-bracketed-paste off

export CLAUDE_CODE_MAX_OUTPUT_TOKENS=1000000
. "$HOME/.cargo/env"
