{ pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ollie = {
    isNormalUser = true;
    description = "ollie";
    extraGroups = [ "networkmanager" "input" "wheel" "video" "audio" "tss" "docker" ];
    packages = with pkgs; [
      spotify
      discord
    ];
  };

  # Change runtime directory size
  services.logind.extraConfig = "RuntimeDirectorySize=8G";
}