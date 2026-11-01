{
  programs.fastfetch = {
    enable = true;

    settings = builtins.fromJSON ''
      {
        "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",

        "logo": {
          "type": "auto",
          "source": "nixos_old",
          "padding": {
          "left": 1
          }
        },

        "display": {
          "color": {
            "keys": ""
          },
          "separator": " \uf061\u001b[2C",
          "constants": [
            "\u001b[s",
            "\u001b[u\u001b[14C",
            "\u001b[38;2;230;138;66m",
            "\u001b[38;2;214;93;14m",
            "\u001b[38;2;240;192;64m",
            "\u001b[38;2;215;153;33m",
            "\u001b[38;2;106;181;184m",
            "\u001b[38;2;69;133;136m",
            "\u001b[38;2;208;112;160m",
            "\u001b[38;2;177;98;134m",
            "\u001b[38;2;196;195;48m",
            "\u001b[38;2;152;151;26m",
            "\u001b[38;2;139;192;140m",
            "\u001b[38;2;104;157;106m"
          ],
          "brightColor": false
        },

        "modules": [
          {
            "type": "break"
          },
          {
            "type": "custom",
            "key": " ",
            "format": "\ud83d\udcbb {$3}System "
          },
          {
            "type": "title",
            "keyIcon": "\uf007",
            "key": "{$4}├─ {icon}  {$1}Login{$2}"
          },
          {
            "type": "os",
            "key": "{$4}├─ {icon}  {$1}{sysname}{$2}"
          },
          {
            "type": "shell",
            "key": "{$4}├─ {icon}  {$1}Shell{$2}"
          },
          {
            "type": "terminal",
            "key": "{$4}├─ {icon}  {$1}Terminal{$2}"
          },
          {
            "type": "packages",
            "key": "{$4}╰─ {icon}  {$1}Packages{$2}"
          },

          {
            "type": "break"
          },
          {
            "type": "custom",
            "key": " ",
            "format": "\ud83d\udd27\ufe0f {$5}Hardware "
          },
          {
            "type": "host",
            "key": "{$6}├─ {icon}  {$1}Chassis{$2}"
          },
          {
            "type": "cpu",
            "key": "{$6}├─ {icon}  {$1}CPU{$2}",
            "keyIcon": "\uf4bc"
          },
          {
            "type": "gpu",
            "key": "{$6}├─ {icon}  {$1}GPU{$2}",
            "keyIcon": "\uf4ca"
          },
          {
            "type": "display",
            "key": "{$6}├─ {icon}  {$1}Display{$2}"
          },
          {
            "type": "memory",
            "key": "{$6}├─ {icon}  {$1}RAM{$2}",
            "format": "{percentage-bar} {used} / {total}",
            "percent": {
              "type": ["bar"]
            }
          },
          {
            "type": "disk",
            "key": "{$6}╰─ {icon}  {$1}Disk{$2}",
            "keyIcon": "\udb80\ude49",
            "format": "{size-percentage-bar} {size-used} / {size-total} [{filesystem}] ({mountpoint})",
            "percent": {
              "type": ["bar"]
            }
          },

          {
            "type": "break"
          },
          {
            "type": "custom",
            "key": " ",
            "format": "\ud83c\udf0d {$7}Network "
          },
          {
            "type": "wifi",
            "key": "{$8}├─ {icon}  {$1}Wifi{$2}"
          },
          {
            "type": "localip",
            "key": "{$8}├─ {icon}  {$1}IP Addr{$2}",
            "keyIcon": "\udb82\ude60",
            "format": "[{4}] {1}"
          },
          {
            "type": "localip",
            "key": "{$8}├─ {icon}  {$1}IP Addr{$2}",
            "keyIcon": "\udb82\ude60",
            "format": "{ipv4}"
          },
          {
            "type": "dns",
            "key": "{$8}╰─ {icon}  {$1}DNS{$2}",
            "keyIcon": "\udb80\uddd6"
          },

          {
            "type": "break"
          },
          {
            "type": "custom",
            "key": " ",
            "format": "\ud83d\udd54 {$13}Date/Time "
          },
          {
            "type": "datetime",
            "key": "{$14}├─ {icon}  {$1}Date/Time{$2}",
            "format": "{day-pretty}-{month-name-short}-{year} / {hour-pretty}:{minute-pretty}:{second-pretty} {timezone-name}"
          },
          {
            "type": "uptime",
            "key": "{$14}╰─ {icon}  {$1}Uptime{$2}"
          },
          {
          "type": "colors",
          "symbol": "circle",
          "paddingLeft": 0
          },
          {
            "type": "break"
          }
        ]
      }
    '';
  };
}
