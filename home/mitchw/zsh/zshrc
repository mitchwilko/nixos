
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Load colors
autoload -Uz colors && colors
 
# Set Prompt: Username (yellow), Path (blue), and Color Reset ($)
PROMPT='%F{yellow}%n@%m%f %F{magenta}%1~%f %# '

# Adding for Light Line and Air Line
export TERM=xterm-256color

# Configure defualt editor
export EDITOR="vim" # Or "vim"
export VISUAL="vim"

# Configuration for Yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}

# Add Vim key bindings
bindkey -v
