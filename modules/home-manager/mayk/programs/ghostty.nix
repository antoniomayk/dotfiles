{ palette, theme, ... }:

{
  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    installBatSyntax = true;
    installVimSyntax = true;
    settings = {
      gtk-adwaita = false;
      font-family = "${theme.font}";
      font-size = 14;
      window-padding-x = 4;
      window-padding-y = 4;
      window-padding-balance = true;
      window-padding-color = "extend-always";
      window-height = 30;
      window-width = 120;
      palette = [
        "0=${palette.gruvbox._0}"
        "1=${palette.gruvbox._1}"
        "2=${palette.gruvbox._2}"
        "3=${palette.gruvbox._3}"
        "4=${palette.gruvbox._4}"
        "5=${palette.gruvbox._5}"
        "6=${palette.gruvbox._6}"
        "7=${palette.gruvbox._7}"
        "8=${palette.gruvbox._8}"
        "9=${palette.gruvbox._9}"
        "10=${palette.gruvbox._10}"
        "11=${palette.gruvbox._11}"
        "12=${palette.gruvbox._12}"
        "13=${palette.gruvbox._13}"
        "14=${palette.gruvbox._14}"
        "15=${palette.gruvbox._15}"
      ];
      background = "#000000";
      foreground = "${palette.gruvbox._15}";
      cursor-color = "${palette.gruvbox._15}";
      cursor-text = "${palette.gruvbox._0}";
      selection-background = "${palette.gruvbox._7}";
      selection-foreground = "${palette.gruvbox._15}";
    };
  };
}
