{ palette, theme, ... }:

{
  programs.zathura = {
    enable = true;
    extraConfig = ''
      set window-title-basename "true"
      set selection-clipboard "clipboard"
      set adjust-open "best-fit"
      set pages-per-row 1
      set scroll-page-aware "true"
      set smooth-scroll "true"
      set scroll-full-overlap 0.01
      set scroll-step 100
      set zoom-min 10
      set guioptions ""
      set adjust-open width
      set recolor true
      set font "${theme.font} ${theme.font-size}"
      set render-loading "false"
      set scroll-step 50

      unmap i
      map i recolor

      unmap f
      map f toggle_fullscreen
      map [fullscreen] f toggle_fullscreen

      set notification-error-bg       "${palette.gruvbox._9}"   # Red
      set notification-error-fg       "${palette.gruvbox._15}"     # Foreground
      set notification-warning-bg     "${palette.gruvbox._11}"   # Orange
      set notification-warning-fg     "${palette.gruvbox._00}"     # Selection
      set notification-bg             "${palette.gruvbox._00}"     # Background
      set notification-fg             "${palette.gruvbox._15}"     # Foreground

      set completion-bg               "${palette.gruvbox._00}"     # Background
      set completion-fg               "${palette.gruvbox._15}"     # Comment
      set completion-group-bg         "${palette.gruvbox._00}"     # Background
      set completion-group-fg         "${palette.gruvbox._12}"     # Comment
      set completion-highlight-bg     "${palette.gruvbox._00}"     # Selection
      set completion-highlight-fg     "${palette.gruvbox._10}"     # Foreground

      set index-bg                    "${palette.gruvbox._00}"     # Background
      set index-fg                    "${palette.gruvbox._15}"     # Foreground
      set index-active-bg             "${palette.gruvbox._10}"     # Current Line
      set index-active-fg             "${palette.gruvbox._00}"     # Foreground

      set inputbar-bg                 "${palette.gruvbox._00}"     # Background
      set inputbar-fg                 "${palette.gruvbox._15}"     # Foreground
      set statusbar-bg                "${palette.gruvbox._00}"     # Background
      set statusbar-fg                "${palette.gruvbox._15}"     # Foreground

      set highlight-fg                "rgba(131, 165, 152, 0.5)"
      set highlight-color             "rgba(250, 189, 47, 0.5)"
      set highlight-active-color      "rgba(184, 187, 38, 0.5)"

      set default-bg                  "${palette.gruvbox._00}"     # Background
      set default-fg                  "${palette.gruvbox._15}"     # Foreground

      set render-loading              true
      set render-loading-fg           ${palette.gruvbox._00}"    # Background
      set render-loading-bg           ${palette.gruvbox._15}"    # Foreground

      set recolor-lightcolor          ${palette.gruvbox._00}"
      set recolor-darkcolor           ${palette.gruvbox._15}"
    '';
  };
}
