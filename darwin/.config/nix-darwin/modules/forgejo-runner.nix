{ pkgs, ... }:
let
  user = "forgejo-runner";
  stateDir = "/var/lib/forgejo-runner";
  id = 510;
in
{
  environment.systemPackages = [ pkgs.forgejo-runner ];

  users.knownUsers = [ user ];
  users.knownGroups = [ user ];
  users.groups.${user}.gid = id;
  users.users.${user} = {
    uid = id;
    gid = id;
    home = stateDir;
    isHidden = true;
    description = "Forgejo Actions runner";
  };

  system.activationScripts.postActivation.text = ''
    mkdir -p ${stateDir}
    chown ${user}:${user} ${stateDir}
    chmod 750 ${stateDir}
  '';

  environment.etc."forgejo-runner/config.yaml".text = ''
    log:
      level: info
    runner:
      file: ${stateDir}/.runner
      capacity: 1
      labels:
        - "mini:host"
    cache:
      enabled: false
    container:
      docker_host: "-"
    host:
      workdir_parent: ${stateDir}/work
  '';

  launchd.daemons.forgejo-runner = {
    path = [
      pkgs.forgejo-runner
      pkgs.bash
      pkgs.coreutils
      pkgs.git
      pkgs.curl
      pkgs.jq
      pkgs.nodejs_22
      pkgs.gnutar
      pkgs.gzip
      "/usr/bin"
      "/bin"
    ];
    script = ''
      if [ ! -f ${stateDir}/.runner ]; then
        echo "not registered yet: ${stateDir}/.runner is missing"
        sleep 300
        exit 0
      fi
      exec forgejo-runner daemon --config /etc/forgejo-runner/config.yaml
    '';
    serviceConfig = {
      UserName = user;
      GroupName = user;
      WorkingDirectory = stateDir;
      KeepAlive = true;
      RunAtLoad = true;
      StandardOutPath = "${stateDir}/runner.log";
      StandardErrorPath = "${stateDir}/runner.log";
      EnvironmentVariables = {
        HOME = stateDir;
        SSL_CERT_FILE = "/etc/ssl/cert.pem";
        NIX_SSL_CERT_FILE = "/etc/ssl/cert.pem";
        NODE_EXTRA_CA_CERTS = "/etc/ssl/cert.pem";
      };
    };
  };
}
