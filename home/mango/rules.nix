{ ... }:
{
  # Mango 0.18+ names: window_rule / layer_rule, app_id, is_floating,
  # no_animation, no_blur.
  wayland.windowManager.mango.settings = {
    window_rule = [
      "is_floating:1,app_id:pavucontrol"
      "is_floating:1,app_id:blueman-manager"
      "is_floating:1,app_id:qalculate-gtk"
      "is_floating:1,app_id:file-roller"
    ];

    layer_rule = [
      "no_animation:1,no_blur:1,layer_name:selection"
    ];
  };
}
