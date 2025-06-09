{ pkgs, ... }:

{
  programs.awscli = {
    enable = true;
    credentials = {
      "default" = {
        "credential_process" = "${pkgs.pass}/bin/pass show aws";
      };
    };
    settings = {
      "default" = {
        region = "us-east-1";
        output = "json";
      };
    };
  };
}
