{ pkgs, ... }:

{
  programs.fish = {
    enable = true;

    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
      update = "sudo nix flake update --flake /etc/nixos && sudo nixos-rebuild switch --flake /etc/nixos#nixos";
      gits = "git status";
      nixopt = "sudo nix store optimise";
      gc = "sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +2 && sudo nix-collect-garbage && sudo /run/current-system/bin/switch-to-configuration boot";
      loc-server = "sudo nixos-firewall-tool open tcp 8000";
      loc-server-off = "sudo nixos-firewall-tool reset";
      ssh-on = "sudo systemctl start sshd";
      ssh-off = "sudo systemctl stop sshd";

      ls = "eza";
      ll = "eza -la";
      lt = "eza --tree";
      cat = "bat";
    };

    plugins = [
      {
        name = "autopair";
        src = pkgs.fishPlugins.autopair.src;
      }
    ];

    interactiveShellInit = ''
      # Remove the default Fish greeting
      set -g fish_greeting

      # Display Fastfetch on startup
      fastfetch
    '';
  };

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    icons = "auto";
    git = true;
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      add_newline = true;

      # Two-line prompt layout
      format = "[┌─](bold #89b4fa)$os$username$hostname$directory$git_branch$git_status$time\n[└─](bold #89b4fa)$character";

      # Operating system icon
      os = {
        disabled = false;
        style = "bold #89b4fa";
        format = "[$symbol]($style)";

        symbols = {
          NixOS = "❯  ";
        };
      };

      # Username
      username = {
        show_always = true;
        style_user = "bold #a6e3a1";
        style_root = "bold #f38ba8";
        format = "[$user]($style)";
      };

      # Hostname
      hostname = {
        ssh_only = false;
        style = "bold #89b4fa";
        format = "[@$hostname]($style)";
      };

      # Current directory
      directory = {
        style = "bold #cba6f7";
        read_only = " 󰌾";
        read_only_style = "bold #f38ba8";

        truncation_length = 3;
        truncate_to_repo = true;

        format = "[ 󰉋 $path]($style)[$read_only]($read_only_style) ";
      };

      # Git branch
      git_branch = {
        symbol = "󰊢 ";
        style = "bold #f9e2af";
        format = "[$symbol$branch]($style) ";
      };

      # Git status
      git_status = {
        style = "bold #fab387";
        format = "([$all_status$ahead_behind]($style) )";
      };

      # Current time
      time = {
        disabled = false;
        time_format = "%I:%M %p";
        style = "bold #94e2d5";
        format = "[󰥔 $time]($style)";
      };

      # Prompt symbol
      character = {
        success_symbol = "[❯](bold #a6e3a1)";
        error_symbol = "[❯](bold #f38ba8)";
        vicmd_symbol = "[❮](bold #cba6f7)";
      };
    };
  };
}
