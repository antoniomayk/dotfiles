{ pkgs, ... }:

{
  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock-effects}/bin/swaylock -fF";
      }
      {
        event = "lock";
        command = "lock";
      }
    ];
    timeouts = [
      {
        timeout = 60 * 60;
        command = "${pkgs.swaylock-effects}/bin/swaylock -fF";
      }
    ];
  };
}
