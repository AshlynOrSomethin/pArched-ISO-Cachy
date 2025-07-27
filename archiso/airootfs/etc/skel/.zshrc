# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

autoload -Uz compinit promptinit
compinit
promptinit

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
export EDITOR='/usr/bin/nano'

#Ash's cutom aliases
##repo aliases
alias cachy="curl https://mirror.cachyos.org/cachyos-repo.tar.xz -o cachyos-repo.tar.xz && tar xvf cachyos-repo.tar.xz && cd cachyos-repo && sudo ./cachyos-repo.sh"
alias chaotic="sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com && sudo pacman-key --lsign-key 3056513887B78AEB && sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' && sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' && echo '' | sudo tee -a /etc/pacman.conf && sudo echo '[chaotic-aur]' | sudo tee -a /etc/pacman.conf && sudo echo 'Include = /etc/pacman.d/chaotic-mirrorlist' | sudo tee -a /etc/pacman.conf"

##general qol alias
alias fixkey2="pacman -Sy --needed archlinux-keyring && pacman -Su"
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias fucking=sudo
alias yay="paru --noconfirm"
alias add="paru -Syyu --noconfirm"
alias install="paru -Syyu --noconfirm"
alias remove="yay -R"
alias uninstall="yay -R"
alias update=topgrade
alias mirrors="sudo reflector --verbose --country US --protocol https --age 12 --sort rate --save /etc/pacman.d/mirrorlist"
alias edit=nano
alias ff=fastfetch
alias kf=fastfetch
alias tf=hyfetch
alias ls=lsd
alias cat=bat
alias less='bat --paging=always'
alias menu="~/.config/rofi/launchers/type-6/launcher.sh"
alias sudo="/usr/bin/sudo-rs"
bindkey "^[[3~" delete-char

