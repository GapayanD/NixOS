{ ... }:
{
  # Carried over from the Mango setup: windows slide in over 400 ms and out
  # over 800 ms. A Bezier curve is four numbers with x values between 0 and 1;
  # springs are written "spring:<damping>,<stiffness>".
  programs.umbriel.settings.animation = {
    enabled = true;

    windows_in = {
      style = "slide";
      duration_ms = 400;
      curve = "0.46,1.0,0.29,1.0";
    };

    windows_out = {
      style = "slide";
      duration_ms = 800;
      curve = "0.08,0.92,0.0,1.0";
    };
  };
}
