{ ... }:
{
  # Keys use Mango 0.18+ snake_case names (old names like borderpx, gappih,
  # focuscolor and shadowscolor are rejected as unknown keywords).
  wayland.windowManager.mango.settings = {
    blur = 1;
    blur_optimized = 1;
    blur_params = {
      radius = 5;
      num_passes = 2;
    };

    border_radius = 6;
    focused_opacity = 1.0;
    unfocused_opacity = 1.0;

    animations = 1;
    animation_type_open = "slide";
    animation_type_close = "slide";
    animation_duration_open = 400;
    animation_duration_close = 800;
    animation_curve = {
      open = "0.46,1.0,0.29,1";
      close = "0.08,0.92,0,1";
    };

    border_px = 1;
    gap_inner_horizontal = 5;
    gap_inner_vertical = 5;
    gap_outer_horizontal = 4;
    gap_outer_vertical = 5;
    focus_color = "0xc9b890ff";

    blur_layer = 1;
    shadows = 1;
    layer_shadows = 1;
    shadow_only_floating = 1;
    shadows_size = 12;
    shadows_blur = 15;
    shadows_color = "0x000000ff";
  };
}
