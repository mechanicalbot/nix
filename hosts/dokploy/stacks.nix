{
  pkgs,
  inputs,
  ...
}:
let
  mkDockerComposeService = stackName: {
    description = "Docker Compose stack: ${stackName}";
    wantedBy = [ "multi-user.target" ];
    requires = [ "docker.service" ];
    path = with pkgs; [ docker-compose ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      User = "root";
      WorkingDirectory = "${inputs.iac-stacks}/stacks/${stackName}";
    };

    script = ''
      echo "Deploying ${stackName} stack from ${inputs.iac-stacks}/stacks/${stackName}"
      ${pkgs.docker-compose}/bin/docker-compose up -d --remove-orphans
    '';

    preStop = ''
      echo "Stopping ${stackName} stack"
      ${pkgs.docker-compose}/bin/docker-compose down
    '';

    reload = ''
      echo "Reloading ${stackName} stack"
      ${pkgs.docker-compose}/bin/docker-compose up -d --force-recreate
    '';
  };
in
{
  systemd.services = {
    # "stack-uptime-kuma" = mkDockerComposeService "uptime-kuma";
    # docker-compose-immich = mkDockerComposeService "immich";
    # docker-compose-netbird = mkDockerComposeService "netbird";
    # docker-compose-open-webui = mkDockerComposeService "open-webui";
    # docker-compose-traefik = mkDockerComposeService "traefik";
    # docker-compose-vaultwarden = mkDockerComposeService "vaultwarden";
  };
}
