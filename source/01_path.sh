paths=(
  ~/.local/bin
  $DOTFILES/bin
  /Users/chrisbailey/Library/Python/2.7/bin
  /Users/chrisbailey/.rbenv/bin
)

export PATH
for p in "${paths[@]}"; do
  [[ -d "$p" ]] && PATH="$p:$(path_remove "$p")"
done
unset p paths
