{ config, pkgs, ...}:
{
  users.users.root = {
    # hashedPassword = null;
    # mkpasswd -m sha-512
    hashedPassword = "$6$RXjSt1BIOO1FjF7T$PFQb9p3fSICeDKYSRGaK9ibnO2JKg6aklwnjUSXAI8oVzfhr5IJLczhmGPbL4KuxhCw5II2uToio/er7QMgN11";
#    hashedPassword = "$6$Mjcay1fxULouV8qQ$dXmzTvdrDYsGupNhm5df77wxEti1u.CSPxaZN.ySw54ryrvXzWvAP/BXYXylWkEhe0KYEJvSxWsgZjBkLLjZa1";
    openssh.authorizedKeys.keys = [
      "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAALvFKRgHf3usfGKb+z/CQ64yPO7qqp41mdgNGSWxqGafRTHv/bVisIOUOFoGInBT6FKdKhsK+kuwwKucIMOlpatQD3HmnjjGyI4ByAYvjKGd71ZV8Qe/ZvcvpdoLvUosWPS46IEz/07HRrjeqRy5rKkqySiJmvgCIefXGEBdyxg655IA== zach@phoenix"
    ];
  };
}
