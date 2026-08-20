{ pkgs, ... }: 

{
  services.ollama = {
    enable = true;
    package = pkgs.ollama-rocm;
    rocmOverrideGfx = "11.5.0";
  };

  services.open-webui = {
    enable = true;
    port = 8080;
  }

  users.users.ollie.extraGroups = [ "video", "render" ];
}