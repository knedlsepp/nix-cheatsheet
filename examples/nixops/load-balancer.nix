let

  backend =
    { config, pkgs, ... }:
    { services.httpd.enable = true;
      services.httpd.adminAddr = "alice@example.org";
      services.httpd.documentRoot = "${pkgs.valgrind.doc}/share/doc/valgrind/html";
      networking.firewall.allowedTCPPorts = [ 80 ];
    };

in

{
  network.description = "Load balancing network";

  proxy =
    { config, pkgs, nodes, ... }:
    { services.httpd.enable = true;
      services.httpd.adminAddr = "bob@example.org";
      services.httpd.extraModules = ["proxy_balancer" "lbmethod_byrequests"];
      services.httpd.extraConfig =
        ''
          <Proxy balancer://cluster>
            Allow from all
            BalancerMember http://backend1 retry=0
            BalancerMember http://backend2 retry=0
          </Proxy>
          ProxyPass         /    balancer://cluster/
          ProxyPassReverse  /    balancer://cluster/
        '';
      networking.firewall.allowedTCPPorts = [ 80 ];
    };

  backend1 = backend;
  backend2 = backend;
}