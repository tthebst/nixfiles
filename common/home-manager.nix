{ pkgs, mail, ... }:

{
  git = {
    enable = true;
    userName = "tim gretler";
    userEmail = mail;
    delta.enable = true;
    delta.options = { 
      features = "woolly-mammoth";
      whitespace-error-style = "22 reverse";
      side-by-side = true;
      pager = "never";
      light = false;
    };
    extraConfig = {
      include.path = "${builtins.fetchurl "https://raw.githubusercontent.com/dandavison/delta/738c5a141bf86d3e05aa348eb87df78c36a72337/themes.gitconfig"}";
    };
  };
  
  alacritty = {
    enable = true;
    settings = {
      cursor = {
        style = "Block";
      };

      window = {
        opacity = 1.0;
        padding = {
          x = 8;
          y = 8;
        };
      };

      dynamic_padding = true;
      decorations = "full";
      title = "Terminal";
      class = {
        instance = "Alacritty";
        general = "Alacritty";
      };
      font = {
        normal = {
          family = "Mononoki Nerd Font";
          style = "Regular";
        };

        size = 14;

      };
      colors = {
        primary = {
          background = "0x292d3e";
          foreground = "0xd0d0d0";
        };

        normal = {
          black = "0x292d3e";
          red   = "0xf07178";
          green = "0xc3e88d";
          yellow= "0xffcb6b";
          blue  = "0x82aaff";
          magenta = "0xc792ea";
          cyan  = "0x89ddff";
          white = "0xd0d0d0";
        };

        bright = {
          black =   "0x434758";
          red =     "0xff8b92";
          green =   "0xddffa7";
          yellow =  "0xffe585";
          blue =    "0x9cc4ff";
          magenta = "0xe1acff";
          cyan =    "0xa3f7ff";
          white =   "0xffffff";
        };
      };
    };
  };
  
  fish = { 
    enable = true; 
    plugins = [{
     name="foreign-env";
     src = pkgs.fetchFromGitHub {
         owner = "oh-my-fish";
         repo = "plugin-foreign-env";
         rev = "dddd9213272a0ab848d474d0cbde12ad034e65bc";
         sha256 = "00xqlyl3lffc5l0viin1nyp819wf81fncqyz87jx8ljjdhilmgbs";
       };
     }];
    loginShellInit = ''
      if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        fenv source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
      end

      if test -e /nix/var/nix/profiles/default/etc/profile.d/nix.sh
        fenv source /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      end
      '';
  };
  
  starship.enable = true;
  starship.enableFishIntegration = true;
  starship.settings = {
    aws.style = "bold #ffb86c";
    cmd_duration.style = "bold #f1fa8c";
    directory.style = "bold #50fa7b";
    hostname.style = "bold #ff5555";
    git_branch.style = "bold #ff79c6";
    git_status.style = "bold #ff5555";
    username = {
      format = "[$user]($style) on ";
      style_user = "bold #bd93f9";
    };
    character = {
      success_symbol = "[λ](bold #f8f8f2)";
      error_symbol = "[λ](bold #ff5555)";
    };
  };
  
  helix.enable = true;
  helix.languages = [{
    name = "rust";
  }];
  helix.settings = {
    theme = "gruvbox";
    editor.true-color = true;
    editor.lsp.display-messages = true;
  };
  
  zellij.enable = true;
}
