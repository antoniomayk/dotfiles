let
  palette = {
    gruvbox = {
      _00 = "#000000";
      _0 = "#1d2021";
      _1 = "#cc241d";
      _2 = "#98971a";
      _3 = "#d79921";
      _4 = "#458588";
      _5 = "#b16286";
      _6 = "#689d6a";
      _7 = "#a89984";
      _8 = "#928374";
      _9 = "#fb4934";
      _10 = "#b8bb26";
      _11 = "#fabd2f";
      _12 = "#83a598";
      _13 = "#d3869b";
      _14 = "#8ec07c";
      _15 = "#ebdbb2";
    };
    mint = {
      _00 = "#000000";
      _0 = "#000000";
      _8 = "#ACACAC";
      _9 = "#EB4138";
      _10 = "#E5E5E5";
      _11 = "#F27835";
      _12 = "#35A854";
      _15 = "#E5E5E5";
    };
  };

  colors = {
    gruvbox = {
      bg = palette.gruvbox._00;
      fg = palette.gruvbox._15;
      inn = palette.gruvbox._12;
      afoc = palette.gruvbox._10;
      ifoc = palette.gruvbox._8;
      ufoc = palette.gruvbox._0;
      urgt = palette.gruvbox._9;
      warn = palette.gruvbox._11;
      phol = palette.gruvbox._00;
    };
    mint = {
      bg = palette.mint._00;
      fg = palette.mint._15;
      inn = palette.mint._12;
      afoc = palette.mint._10;
      ifoc = palette.mint._8;
      ufoc = palette.mint._0;
      urgt = palette.mint._9;
      warn = palette.mint._11;
      phol = palette.mint._00;
    };
  };
in
{
  palette = palette;
  colors = colors.mint;
  margin = 0;
  padding = 4;
  border-size = 1;
  border-radius = 0;
  font = "JetBrainsMono Nerd Font";
  font-size = "10";
}
