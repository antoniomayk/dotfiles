{
  xdg = {
    desktopEntries = {
      neovide = {
        type = "Application";
        exec = "neovide %F";
        icon = "nvim";
        name = "Neovide";
        settings = {
          Keywords = "Text;Editor;";
        };
        categories = [
          "Utility"
          "TextEditor"
        ];
        comment = "No Nonsense Neovim Client in Rust";
        mimeType = [
          "text/english"
          "text/plain"
          "text/x-makefile"
          "text/x-c++hdr"
          "text/x-c++src"
          "text/x-chdr"
          "text/x-csrc"
          "text/x-java"
          "text/x-moc"
          "text/x-pascal"
          "text/x-tcl"
          "text/x-tex"
          "application/x-shellscript"
          "text/x-c"
          "text/x-c++"
        ];
      };
    };
  };
}
