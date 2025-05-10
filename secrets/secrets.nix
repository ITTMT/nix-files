let 
  user1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICDbG5TX/DBDCZM1PNsQ/wxaUuS9ckiDOYj0A5LBWmoI";
  users = [ user1 ];
in 
{
  "secret1.age".publicKeys = [ user1 ];
}
