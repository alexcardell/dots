set -euo pipefail

gtk_theme_key='/org/gnome/desktop/interface/gtk-theme'
color_scheme_key='/org/gnome/desktop/interface/color-scheme'
light_theme='Orchis-Purple'
dark_theme='Orchis-Purple-Dark'

set_mode() {
  case "$1" in
    light)
      dconf write "$gtk_theme_key" "'$light_theme'"
      dconf write "$color_scheme_key" "'prefer-light'"
      ;;
    dark)
      dconf write "$gtk_theme_key" "'$dark_theme'"
      dconf write "$color_scheme_key" "'prefer-dark'"
      ;;
    *)
      printf 'Unknown mode: %s\n' "$1" >&2
      exit 1
      ;;
  esac
}

current_mode() {
  case "$(dconf read "$color_scheme_key" 2>/dev/null || true)" in
    "'prefer-dark'") printf 'dark\n' ;;
    "'prefer-light'") printf 'light\n' ;;
    *) printf 'unknown\n' ;;
  esac
}

case "${1:-toggle}" in
  light|dark)
    set_mode "$1"
    ;;
  toggle)
    if [ "$(current_mode)" = "dark" ]; then
      set_mode light
    else
      set_mode dark
    fi
    ;;
  status)
    printf 'mode=%s\n' "$(current_mode)"
    printf 'gtk-theme=%s\n' "$(dconf read "$gtk_theme_key" 2>/dev/null || printf 'unset')"
    ;;
  *)
    printf 'Usage: theme-mode [light|dark|toggle|status]\n' >&2
    exit 1
    ;;
esac
