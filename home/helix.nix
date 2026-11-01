{ ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      theme = "obsidian-glass";

      editor = {
        line-number = "relative";
        cursorline = true;
        color-modes = true;
        true-color = true;
        bufferline = "multiple";
        mouse = true;
        rulers = [ 100 ];
        scrolloff = 8;

        indent-guides = {
          render = true;
          character = "┊";
          skip-levels = 1;
        };

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        statusline = {
          left = [
            "mode"
            "spinner"
            "file-name"
            "file-modification-indicator"
          ];
          center = [ "version-control" ];
          right = [
            "diagnostics"
            "selections"
            "position"
            "file-encoding"
            "file-line-ending"
            "file-type"
          ];
          separator = "│";
          mode.normal = "NORMAL";
          mode.insert = "INSERT";
          mode.select = "SELECT";
        };

        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
      };
    };

    themes.obsidian-glass = {
      "ui.background" = {
        fg = "text";
      };

      "ui.text" = "text";
      "ui.text.focus" = "white";
      "ui.text.inactive" = "muted";

      "ui.cursor" = {
        fg = "background";
        bg = "lavender";
      };

      "ui.cursor.primary" = {
        fg = "background";
        bg = "accent";
      };

      "ui.cursor.match" = {
        fg = "accent";
        modifiers = [ "bold" ];
      };

      "ui.selection" = {
        bg = "selection";
      };

      "ui.selection.primary" = {
        bg = "selection-active";
      };

      "ui.linenr" = "subtle";
      "ui.linenr.selected" = {
        fg = "lavender";
        modifiers = [ "bold" ];
      };

      "ui.statusline" = {
        fg = "text";
        bg = "surface";
      };

      "ui.statusline.inactive" = {
        fg = "muted";
        bg = "surface";
      };

      "ui.statusline.normal" = {
        fg = "background";
        bg = "lavender";
        modifiers = [ "bold" ];
      };

      "ui.statusline.insert" = {
        fg = "background";
        bg = "mint";
        modifiers = [ "bold" ];
      };

      "ui.statusline.select" = {
        fg = "background";
        bg = "pink";
        modifiers = [ "bold" ];
      };

      "ui.popup" = {
        fg = "text";
        bg = "surface";
      };

      "ui.window" = {
        fg = "border";
      };

      "ui.help" = {
        fg = "text";
        bg = "surface";
      };

      "ui.menu" = {
        fg = "text";
        bg = "surface";
      };

      "ui.menu.selected" = {
        fg = "white";
        bg = "selection";
        modifiers = [ "bold" ];
      };

      "ui.virtual" = "subtle";
      "ui.virtual.inlay-hint" = "muted";
      "ui.virtual.indent-guide" = "border";

      "ui.gutter" = {
        fg = "subtle";
      };

      "ui.bufferline" = {
        fg = "muted";
        bg = "background";
      };

      "ui.bufferline.active" = {
        fg = "lavender";
        bg = "surface";
        modifiers = [ "bold" ];
      };

      "ui.bufferline.background" = {
        bg = "background";
      };

      "diagnostic.error" = {
        underline = {
          color = "red";
          style = "curl";
        };
      };

      "diagnostic.warning" = {
        underline = {
          color = "yellow";
          style = "curl";
        };
      };

      "diagnostic.info" = {
        underline = {
          color = "blue";
          style = "curl";
        };
      };

      "diagnostic.hint" = {
        underline = {
          color = "mint";
          style = "curl";
        };
      };

      "error" = "red";
      "warning" = "yellow";
      "info" = "blue";
      "hint" = "mint";
      "debug" = "muted";

      "comment" = {
        fg = "muted";
        modifiers = [ "italic" ];
      };

      "keyword" = {
        fg = "lavender";
        modifiers = [ "bold" ];
      };

      "keyword.control" = "pink";
      "operator" = "subtle";
      "punctuation" = "subtle";

      "string" = "mint";
      "string.special" = "cyan";

      "constant" = "peach";
      "constant.numeric" = "peach";
      "constant.builtin" = "pink";

      "function" = "blue";
      "function.builtin" = "cyan";
      "constructor" = "lavender";

      "type" = "cyan";
      "type.builtin" = "cyan";
      "namespace" = "lavender";

      "variable" = "text";
      "variable.builtin" = "pink";
      "variable.parameter" = "peach";

      "attribute" = "yellow";
      "tag" = "pink";
      "label" = "lavender";

      "markup.heading" = {
        fg = "lavender";
        modifiers = [ "bold" ];
      };

      "markup.bold" = {
        fg = "white";
        modifiers = [ "bold" ];
      };

      "markup.italic" = {
        fg = "pink";
        modifiers = [ "italic" ];
      };

      "markup.link.url" = {
        fg = "blue";
        modifiers = [ "underlined" ];
      };

      "markup.link.text" = "cyan";
      "markup.quote" = "muted";
      "markup.raw" = "mint";
      "markup.list" = "pink";

      "diff.plus" = "mint";
      "diff.minus" = "red";
      "diff.delta" = "yellow";

      palette = {
        background = "#171720";
        surface = "#222230";
        selection = "#343449";
        selection-active = "#46435F";

        text = "#E5E3EF";
        white = "#F8F7FF";
        muted = "#9694A8";
        subtle = "#777589";
        border = "#454458";

        lavender = "#B9A7F5";
        accent = "#C7B5FF";
        pink = "#E5A6CC";
        mint = "#A6D9C3";
        cyan = "#91D5E8";
        blue = "#91B9F4";
        peach = "#E9B58F";

        red = "#F28B91";
        yellow = "#E8CE91";
      };
    };
  };
}
