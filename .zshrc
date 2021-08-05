setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e
export VISUAL=vim
export EDITOR=vim

export LANG=en_US.UTF-8
export GPG_KEY=$(tty)

# Edit command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

[ -d ~/bin ] && export PATH="$HOME/bin:$PATH"

[[ -s /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh

# System Specific
case `uname` in 
Darwin)
    # commands for macOS
    [ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

    # ruby
    [ -d /usr/local/opt/ruby/bin ] && export PATH="/usr/local/opt/ruby/bin:$PATH"

    # java
    [ -d /usr/local/opt/openjdk/bin ] && export PATH="/usr/local/opt/openjdk/bin:$PATH"

    # Alias
    alias ls='ls -G'
    alias ll='ls -lhG'
    alias bug='brew upgrade --greedy'
    
    source ~/.macos
;;
Linux)
    # commands for Linux
;;
FreeBSD)
    # commands for FreeBSD
;;
esac

# zplug
if [ ! -d ~/.zplug ]; then
    echo 'Installing zplug ... '
    git clone https://github.com/zplug/zplug.git ~/.zplug
fi
source ~/.zplug/init.zsh 
zplug "plugins/git", from:oh-my-zsh
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "dracula/zsh", as:theme
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load

source $HOME/.aliases
[ -f $HOME/.zsh_local ] && source $HOME/.zsh_local
