# -*- mode: shell-script; -*-

# The following lines were added by compinstall

zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Lines configured by zsh-newuser-install
setopt appendhistory
bindkey -e
zstyle ':completion:*::::' completer _expand _complete _ignored # list of completers to use
zstyle ':completion:*' menu select list-colors ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}       # colorz !
setopt hash_list_all            # hash everything before completion
# setopt completealiases          # complete alisases
setopt always_to_end            # when completing from the middle of a word, move the cursor to the end of the word
setopt complete_in_word         # allow completion from within a word/phrase
setopt correct                  # spelling correction for commands
setopt list_ambiguous           # complete as much of a completion until it gets ambiguous.


# sections completion !
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format $'\e[00;34m%d'
zstyle ':completion:*:messages' format $'\e[00;31m%d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:manuals' separate-sections true

zstyle ':completion:*:processes' command 'ps -au$USER'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=29=34"
zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*' force-list always

zmodload zsh/complist
#bindkey -M menuselect '^M' .accept-line

# End of lines configured by zsh-newuser-install



cdUndoKey() {
    popd      > /dev/null
    zle       reset-prompt
    echo
    ls
    echo
}

cdParentKey() {
    pushd .. > /dev/null
    zle      reset-prompt
    echo
    ls
    echo
}

zle -N                 cdParentKey
zle -N                 cdUndoKey
bindkey '^[[1;3A'      cdParentKey
bindkey '^[[1;3D'      cdUndoKey


## HISTORY

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

setopt hist_verify              # show before executing history commands
setopt inc_append_history       # add commands as they are typed, don't wait until shell exit
setopt share_history            # share hist between sessions
setopt hist_ignore_dups         # Do not write events ho history that are duplicates of previous events
setopt hist_expire_dups_first   # when trimming history, lose oldest duplicates first

test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'


autoload -U colors && colors
PROMPT="%{$fg_bold[green]%}%n@%m %{$fg_bold[blue]%}%1~ %{$reset_color%}%# "
RPROMPT="[%{$fg_no_bold[yellow]%}%?%{$reset_color%}]"

###
### Start zplug section ###
###

source ~/.zplug/init.zsh


# Make sure to use double quotes
zplug "zsh-users/zsh-history-substring-search"

zplug 'mollifier/cd-gitroot'
alias cdu='cd-gitroot'
    
# Use the package as a command
# And accept glob patterns (e.g., brace, wildcard, ...)
# zplug "Jxck/dotfiles", as:command, use:"bin/{histuniq,color}"

# zplug 'nojhan/liquidprompt'
zplug mafredri/zsh-async, from:github
# zplug intelfx/pure, use:pure.zsh, from:github, as:theme
# zplug therealklanni/purity, use:purity.zsh, from:github, as:theme, hook-build:"sed -i 's/%c/%~/g' purity.zsh"
DEFAULT_USER=asartori
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir virtualenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs)
POWERLEVEL9K_VIRTUALENV_BACKGROUND='201'
zplug dritter/powerlevel9k, use:powerlevel9k.zsh-theme, from:github, as:theme, at:async_all_the_segments, if:"[ $TERM != linux ]"

# Can manage everything e.g., other person's zshrc
#zplug "tcnksm/docker-alias", use:zshrc

# Disable updates using the "frozen" tag
#zplug "k4rthik/git-cal", as:command, frozen:1

# Grab binaries from GitHub Releases
# and rename with the "rename-to:" tag
zplug "junegunn/fzf-bin", \
    from:gh-r, \
    as:command, \
    rename-to:fzf, \
    use:"*linux*amd64*"

zplug "junegunn/fzf", \
      as:command, \
      use:"bin/fzf-tmux", \
      rename-to:"fzf-tmux"

zplug "junegunn/fzf", \
      as:plugin, \
      use:"shell/*.zsh"

# Supports oh-my-zsh plugins and the like
#zplug "plugins/git",   from:oh-my-zsh

zplug "zsh-users/zsh-autosuggestions"
export ZSH_AUTOSUGGEST_USE_ASYNC=true

zplug "plugins/emacs", from:oh-my-zsh, if:"[ ! -n \"$SSH_CLIENT\" ] && [ ! -n \"$SSH_TTY\" ]"

zplug "plugins/golang", from:oh-my-zsh, defer:3
zplug "jplitza/zsh-virsh-autocomplete", use:.

zplug "so-fancy/diff-so-fancy", as:command

zplug "agkozak/zsh-z"

# Also prezto
#zplug "modules/prompt", from:prezto

# Load if "if" tag returns true
#zplug "lib/clipboard", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"

# Run a command after a plugin is installed/updated
# Provided, it requires to set the variable like the following:
# ZPLUG_SUDO_PASSWORD="********"
#zplug "jhawthorn/fzy", \
#    as:command, \
#    rename-to:fzy, \
#    hook-build:"make && sudo make install"

# Supports checking out a specific branch/tag/commit
#zplug "b4b4r07/enhancd", at:v1
#zplug "mollifier/anyframe", at:4c23cb60

# Can manage gist file just like other packages
# zplug "b4b4r07/79ee61f7c140c63d2786", \
#     from:gist, \
#     as:command, \
#     use:get_last_pane_path.sh

# Support bitbucket
# zplug "b4b4r07/hello_bitbucket", \
#     from:bitbucket, \
#     as:command, \
#     use:"*.sh"

# Rename a command with the string captured with `use` tag
# zplug "b4b4r07/httpstat", \
#     as:command, \
#     use:'(*).sh', \
#     rename-to:'$1'

# Group dependencies
# Load "emoji-cli" if "jq" is installed in this example
# zplug "stedolan/jq", \
#     from:gh-r, \
#     as:command, \
#     rename-to:jq
# zplug "b4b4r07/emoji-cli", \
#     on:"stedolan/jq"
# Note: To specify the order in which packages should be loaded, use the defer
#       tag described in the next section

# Set the priority when loading
# e.g., zsh-syntax-highlighting must be loaded
# after executing compinit command and sourcing other plugins
# (If the defer tag is given 2 or above, run after compinit command)
zplug "zsh-users/zsh-syntax-highlighting", defer:2

export ZSH_HIGHLIGHT_MAXLENGTH=300

# Can manage local plugins
# zplug "~/.zsh", from:local

# Load theme file
# zplug 'dracula/zsh', as:theme

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Let zplug manage itself
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Then, source plugins and add commands to $PATH
zplug load --verbose

export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=' -R '

export PATH="$HOME/go/bin:$HOME/bin:$HOME/.local/bin:$PATH"



# NPM packages in homedir
NPM_PACKAGES="$HOME/.npm-packages"

# Tell our environment about user-installed node tools
PATH="$NPM_PACKAGES/bin:$PATH"
# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
unset MANPATH  # delete if you already modified MANPATH elsewhere in your configuration
MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

# Tell Node about these packages
NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
