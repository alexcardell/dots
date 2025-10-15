{ pkgs, ... }:
{

  imports = [
    ./homelab-compose.nix
  ];

  # for sonarr with nixos-25.05
  nixpkgs.config.permittedInsecurePackages = [
    "aspnetcore-runtime-6.0.36"
    "aspnetcore-runtime-wrapped-6.0.36"
    "dotnet-sdk-6.0.428"
    "dotnet-sdk-wrapped-6.0.428"
  ];

  environment.systemPackages = with pkgs; [
    chkrootkit
    jellycli
    jellyfin-web
    lynis
    recyclarr
    unstable.jellyfin-ffmpeg
  ];

  # security.acme = {
  #   acceptTerms = true;
  #
  #   certs = {
  #     "cardell.io" = {
  #       email = "acme.os1o9@slmail.me";
  #     };
  #   };
  # };

  services.nginx = {
    enable = true;
    recommendedTlsSettings = true;
    recommendedProxySettings = true;
    virtualHosts = {
      "192.168.0.20" = {
        forceSSL = false;
        enableACME = false;
        locations = {
          "/" = {
            proxyPass = "http://127.0.0.1:7575";
          };
          "/video" = {
            proxyPass = "http://127.0.0.1:8096";
          };
          "/books" = {
            proxyPass = "http://127.0.0.1:8083";
          };
          "/home-assistant" = {
            proxyPass = "http://127.0.0.1:8123";
          };
          "/502.html" = {
            return = "502 'Backend Down'";
          };
        };
        extraConfig = ''
          proxy_intercept_errors on;
          error_page 502 = /502.html;
        '';
      };
    };
  };

  services.slskd = {
    enable = true;
    user = "slskd";
    group = "slskd";
    domain = null;
    environmentFile = ./home/slskd/secrets/slskd.env;
    settings = {
      directories = {
        downloads = "/mnt/media/soulseek/downloads";
        incomplete = "/mnt/media/soulseek/incomplete";
      };
      shares = {
        directories = [ ];
      };
      web = {
        port = 5030;
        https.disabled = true;
      };
    };
  };

  # power management
  services.tlp = {
    enable = true;
    settings = {
      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

  # port 8096
  services.jellyfin = {
    enable = true;
    package = pkgs.unstable.jellyfin;
    # user = "alex";
    openFirewall = true;
  };

  # port 8989
  services.sonarr = {
    enable = true;
    openFirewall = true;
    package = pkgs.unstable.sonarr;
  };

  # port 7878
  services.radarr = {
    enable = true;
    openFirewall = true;
    package = pkgs.unstable.radarr;
  };

  # port 9696
  services.prowlarr = {
    enable = true;
    openFirewall = true;
    package = pkgs.unstable.prowlarr;
  };

  # port 6767;
  services.bazarr = {
    enable = true;
    openFirewall = true;
    package = pkgs.unstable.bazarr;
  };

  services.jellyseerr = {
    enable = true;
    port = 5055;
    openFirewall = true;
    package = pkgs.unstable.jellyseerr;
  };

  services.qbittorrent = {
    enable = true;
    webuiPort = 9009;
    openFirewall = true;
    package = pkgs.unstable.qbittorrent-nox;
  };
}
