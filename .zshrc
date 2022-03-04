#! /bin/zsh

fpath=(~/.zsh $fpath)

export XDG_CONFIG_HOME="$HOME/.config"

export EDITOR="nvim"
export TEXMFHOME="/home/hali/.texmf"
export TEXMFDIST="/usr/share/texmf-dist"
export TERM="alacritty"
export TERMINAL=$TERM
export HISTCONTROL=ignoreboth
export GOPATH="/home/hali/.go"
export MNTPATH="/run/media/hali/"
export GPG_TTY=$(tty)

export CODEPATH="$HOME/Documents/Code"
export BLOGPATH="$HOME/Documents/Code/halivert.dev"
export WORKPATH="$HOME/Documents/Projects"
export JWPATH="$HOME/Documents/JW"

PATH="$PATH:/home/hali/.bin"
PATH="$PATH:/home/hali/.config/composer/vendor/bin"
PATH="$PATH:/home/hali/.local/share/gem/ruby/3.0.0/bin"
PATH="$PATH:/home/hali/.yarn/bin"
PATH="$PATH:/home/hali/.npm/bin"
PATH="$PATH:/home/hali/.local/bin"
PATH="$PATH:/home/hali/.go/bin"
PATH="$PATH:/home/hali/.cargo/bin"

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

# Change current directory when open new terminal
_Tp="$(cat /proc/$(echo $$)/stat | cut -d \  -f 4)"
_Tn="$(ps -f -p $_Tp | tail -1 | sed 's/^.* //')"
_Tx="$(basename '/'$_Tn)"

if [[ i3-msg ]]; then
	_DirNum="dir"
else
	_DirNum="$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).num' -r)"
fi

_CurrentDirFile="$HOME/.currentDirs/$_DirNum"
unset _Tp _Tn _DirNum
if [ $_Tx = "alacritty" ] || [ $_Tx = "konsole" ]; then
	alias cd=changeDir;

	changeDir() {
		\cd $1;
		pwd > "$_CurrentDirFile"
	}

	if [ -e $_CurrentDirFile ]; then
		cd "$(cat $_CurrentDirFile)"
	fi
fi

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

source /usr/share/nvm/init-nvm.sh
