  
{ pkgs, ...}:
{
  security.sudo.wheelNeedsPassword = false;
  security.rtkit.enable = true;
  security.pam.services.sudo.fprintAuth = true;
  security.pam.services.login.fprintAuth = true;
}