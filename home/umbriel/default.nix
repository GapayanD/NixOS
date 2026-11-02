{ inputs, ... }:
{
  imports = [
    inputs.umbriel.homeModules.default
    ./general.nix
    ./appearance.nix
    ./animation.nix
    ./input.nix
    ./layout.nix
    ./binds.nix
    ./rules.nix
  ];

  # Every file in this directory contributes to programs.umbriel.settings. The
  # module system merges them into one ~/.config/umbriel/config.toml.
  #
  # Merge rules to keep in mind when editing:
  #   - Tables (appearance, input, keybinds, ...) merge key by key across files.
  #   - Array-of-tables (window_rule, layer_rule, scratchpad, workspace) are
  #     concatenated, so each lives in exactly one file. rules.nix owns both
  #     rule lists because later rules override earlier ones.
  #   - Setting the same scalar key in two files is a conflict.
  #
  # After a rebuild:
  #   umbriel config validate   check the generated TOML (file, line, column)
  #   umbriel config schema     list every key this build accepts
  #   umbriel msg config-reload apply it without restarting the session
  programs.umbriel.enable = true;
}
