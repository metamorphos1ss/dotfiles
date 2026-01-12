# =========================
# Powerlevel10k instant prompt (should be near the top)
# =========================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# =========================
# Zinit (safe auto-install only for interactive shells)
# =========================
if [[ -o interactive ]]; then
  if [[ ! -f "$HOME/.local/share/zinit/zinit.git/zinit.zsh" ]]; then
    command -v git >/dev/null && {
      mkdir -p "$HOME/.local/share/zinit"
      # keep it quiet and reasonably fast if network is slow
      command -v timeout >/dev/null \
        && timeout 8 git clone --depth=1 https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" >/dev/null 2>&1 \
        || git clone --depth=1 https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" >/dev/null 2>&1
    }
  fi
fi

# If zinit exists, load it
if [[ -f "$HOME/.local/share/zinit/zinit.git/zinit.zsh" ]]; then
  source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
  autoload -Uz _zinit
  (( ${+_comps} )) && _comps[zinit]=_zinit
fi

# =========================
# Environment
# =========================
export EDITOR="nvim"

# Deduplicate PATH entries and prepend yours
typeset -U path PATH
path=("$HOME/bin" "$HOME/.local/bin" /usr/local/bin $path)
export PATH

# =========================
# Plugins (zinit)
# =========================
if (( ${+functions[zinit]} )); then
  # Completions should be installed before compinit
  zinit ice blockf
  zinit light zsh-users/zsh-completions

  # Load theme early
  zinit light romkatv/powerlevel10k

  # Useful plugins, some lazy to speed up startup
  zinit light rupa/z
  zinit light Aloxaf/fzf-tab

  zinit ice wait"1"
  zinit light zsh-users/zsh-autosuggestions

  zinit ice wait"1"
  zinit light djui/alias-tips

  zinit ice wait"1"
  zinit light MichaelAquilina/zsh-you-should-use

  # MUST be last
  zinit light zsh-users/zsh-syntax-highlighting
fi

# =========================
# Powerlevel10k config
# =========================
[[ -f "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"

# =========================
# Completion init (with cache)
# =========================
autoload -Uz compinit
compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump"

# =========================
# Aliases (safe: only if tools exist)
# =========================
alias ll='ls -lha'
alias gs='git status'
alias n='nvim'
alias p='python3'

command -v bat >/dev/null && {
  alias cat='bat'
  alias b='bat'
}

# =========================
# Zsh settings
# =========================
setopt autocd
setopt no_beep
setopt hist_ignore_dups

# Cursor shape (only in interactive terminals)
[[ -o interactive && -t 1 ]] && echo -ne '\e[5 q'
