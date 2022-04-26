#! /bin/zsh

fpath=(~/.zsh $fpath)

export XDG_CONFIG_HOME="$HOME/.config"

export EDITOR="nvim"
export TEXMFHOME="$HOME/.texmf"
export TEXMFDIST="/usr/share/texmf-dist"
export HISTCONTROL=ignoreboth
export GOPATH="$HOME/.go"
export MNTPATH="/run/media/hali/"
export GPG_TTY=$(tty)

export CODEPATH="$HOME/Documents/Code"
export BLOGPATH="$HOME/Documents/Code/halivert.dev"
export WORKPATH="$HOME/Documents/Projects"
export JWPATH="$HOME/Documents/JW"

PATH="$PATH:$HOME/.bin"
PATH="$PATH:$HOME/.config/composer/vendor/bin"
PATH="$PATH:$HOME/.local/share/gem/ruby/3.0.0/bin"
PATH="$PATH:$HOME/.yarn/bin"
PATH="$PATH:$HOME/.npm/bin"
PATH="$PATH:$HOME/.local/bin"
PATH="$PATH:$HOME/.go/bin"
PATH="$PATH:$HOME/.cargo/bin"

# Prompt only last 3 directories from PWD
function min_path_prompt () {
	REPLY=%1~
}
grml_theme_add_token min-path -f min_path_prompt '%B%F{4}' '%f%b '

function virtualenv_info {
	REPLY=$([ $VIRTUAL_ENV ] && echo '('${VIRTUAL_ENV:t}')')
}
grml_theme_add_token virtualenv -f virtualenv_info '%F{3}' '%f '

# Set my own grml setup
zstyle ':prompt:grml:left:setup' items user at host min-path vcs virtualenv newline percent
zstyle ':prompt:grml:*:items:user' pre '%F{166}'
zstyle ':prompt:grml:*:items:percent' pre '%f'
zstyle ':prompt:grml:right:setup' use-rprompt false

source ~/.zsh_aliases

# Vim and mode indicator
bindkey -v

precmd() { RPROMPT="" }
function zle-line-init zle-keymap-select {
	VIM_PROMPT="%B%F{3} [% N]% %{$reset_color%}"
	RPS1="${${KEYMAP/vicmd/$VIM_PROMPT%b}/(main|viins)/}$EPS1"
	zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

export KEYTIMEOUT=1

# Bind keys
key[Home]="$terminfo[khome]"
key[End]="$terminfo[kend]"
key[Insert]="$terminfo[kich1]"
key[Backspace]="$terminfo[kbs]"
key[Delete]="$terminfo[kdch1]"
key[Up]="$terminfo[kcuu1]"
key[Down]="$terminfo[kcud1]"
key[Left]="$terminfo[kcub1]"
key[Right]="$terminfo[kcuf1]"
key[PageUp]="$terminfo[kpp]"
key[PageDown]="$terminfo[knp]"

# setup key accordingly
[[ -n "$key[Home]"			]] && bindkey -- "$key[Home]"      beginning-of-line
[[ -n "$key[End]"				]] && bindkey -- "$key[End]"       end-of-line
[[ -n "$key[Insert]"		]] && bindkey -- "$key[Insert]"    overwrite-mode
[[ -n "$key[Backspace]"	]] && bindkey -- "$key[Backspace]" backward-delete-char
[[ -n "$key[Delete]"		]] && bindkey -- "$key[Delete]"    delete-char
[[ -n "$key[Up]"				]] && bindkey -- "$key[Up]"        up-line-or-history
[[ -n "$key[Down]"			]] && bindkey -- "$key[Down]"      down-line-or-history
[[ -n "$key[Left]"			]] && bindkey -- "$key[Left]"      backward-char
[[ -n "$key[Right]"			]] && bindkey -- "$key[Right]"     forward-char

if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
	function zle-line-init () {
		echoti smkx
	}

	function zle-line-finish () {
		echoti rmkx
	}

	zle -N zle-line-init
	zle -N zle-line-finish
fi

zle -N edit-command-line
bindkey "^e" edit-command-line

# Disable <C-s> pause terminal
stty -ixon

# source /usr/share/nvm/init-nvm.sh
source /opt/local/share/nvm/init-nvm.sh
