{ lib, ... }:
let
  # CTRL+n view / ALT+n tag (stock mango) plus SUPER+n / SUPER+SHIFT+n so the
  # workspace keys match the rest of your SUPER-based binds (and Umbriel).
  tagBinds = lib.flatten (
    map (
      n:
      let
        s = toString n;
      in
      [
        "SUPER,${s},view,${s}"
        "SUPER+AlT,${s},tag,${s}"
      ]
    ) (lib.range 1 9)
  );
in
{
  wayland.windowManager.mango.settings = {
    bind = [
      # --- apps ---
      "SUPER,Return,spawn,wezterm"
      "SUPER,B,spawn,brave"
      "SUPER,E,spawn,krusader"

      # --- session ---
      "SUPER,Q,killclient"
      "SUPER+SHIFT,Q,killclient,force"
      "SUPER+SHIFT,R,reload_config"
      "SUPER+SHIFT,E,quit"
      "CTRL+ALT,n,switch_layout"

      # --- window state ---
      "SUPER,F,togglefullscreen"
      "SUPER,T,togglefloating"
      "SUPER,M,togglemaximizescreen"
      "SUPER,P,toggleglobal"
      "SUPER,C,centerwin"
      "SUPER,minus,minimized"
      "SUPER+SHIFT,minus,restore_minimized"
      "SUPER,Tab,toggleoverview"
      "ALT,Tab,spawn,noctalia msg window-switcher"

      # --- focus / move ---
      "SUPER,Left,focusdir,left"
      "SUPER,Right,focusdir,right"
      "SUPER,Up,focusdir,up"
      "SUPER,Down,focusdir,down"
      "SUPER,J,focusstack,next"
      "SUPER,K,focusstack,prev"
      "SUPER,grave,focuslast"
      "SUPER+SHIFT,Left,exchange_client,left"
      "SUPER+SHIFT,Right,exchange_client,right"
      "SUPER+SHIFT,Up,exchange_client,up"
      "SUPER+SHIFT,Down,exchange_client,down"

      # --- layout (scroller / tile) ---
      "SUPER,R,switch_proportion_preset"
      "SUPER,Z,zoom"
      "SUPER,G,togglegaps"
      "SUPER,bracketleft,scroller_stack,left"
      "SUPER,bracketright,scroller_stack,right"
      "SUPER,comma,incnmaster,-1"
      "SUPER,period,incnmaster,+1"
      "SUPER+ALT,Left,setmfact,-0.05"
      "SUPER+ALT,Right,setmfact,+0.05"

      # --- tags ---
      "SUPER+CTRL,Left,viewtoleft"
      "SUPER+CTRL,Right,viewtoright"
      "SUPER+CTRL+SHIFT,Left,tagtoleft"
      "SUPER+CTRL+SHIFT,Right,tagtoright"

      # --- monitors (no-ops on a single display) ---
      "SUPER+ALT,comma,focusmon,left"
      "SUPER+ALT,period,focusmon,right"
      "SUPER+SHIFT,comma,tagmon,left"
      "SUPER+SHIFT,period,tagmon,right"

      # --- floating windows (mouse: SUPER+drag also works) ---
      "ALT+SHIFT,Left,smartresizewin,left"
      "ALT+SHIFT,Right,smartresizewin,right"
      "ALT+SHIFT,Up,smartresizewin,up"
      "ALT+SHIFT,Down,smartresizewin,down"
      "SUPER+ALT+SHIFT,Left,smartmovewin,left"
      "SUPER+ALT+SHIFT,Right,smartmovewin,right"
      "SUPER+ALT+SHIFT,Up,smartmovewin,up"
      "SUPER+ALT+SHIFT,Down,smartmovewin,down"

      # --- screenshots ---
      "NONE,Print,spawn,noctalia msg screenshot-region"
      "SUPER,Print,spawn,noctalia msg screenshot-fullscreen"

      # --- Noctalia panels ---
      "SUPER,Space,spawn,noctalia msg panel-toggle launcher"
      "SUPER,Escape,spawn,noctalia msg panel-toggle session"
      "SUPER,I,spawn,noctalia msg settings-toggle"
      "SUPER,S,spawn,noctalia msg panel-toggle control-center"
      "SUPER,V,spawn,noctalia msg panel-toggle clipboard"
      "SUPER,N,spawn,noctalia msg notification-dnd-toggle"
      "SUPER+SHIFT,N,spawn,noctalia msg nightlight-toggle"
      "SUPER,L,spawn,noctalia msg session lock"
      "SUPER+ALT,N,spawn,noctalia msg panel-toggle ezequiel/mango_layouts:panel"
    ]
    ++ tagBinds;

    # `bindl` = also works while the session is locked (volume/brightness/media).
    bindl = [
      "NONE,XF86MonBrightnessUp,spawn,noctalia msg brightness-up"
      "NONE,XF86MonBrightnessDown,spawn,noctalia msg brightness-down"
      "NONE,XF86AudioRaiseVolume,spawn,noctalia msg volume-up"
      "NONE,XF86AudioLowerVolume,spawn,noctalia msg volume-down"
      "NONE,XF86AudioMute,spawn,noctalia msg volume-mute"
      "NONE,XF86AudioPlay,spawn,noctalia msg media toggle"
      "NONE,XF86AudioNext,spawn,noctalia msg media next"
      "NONE,XF86AudioPrev,spawn,noctalia msg media previous"
    ];

    # Stock mango mouse binds: SUPER+drag to move/resize floating windows,
    # SUPER+scroll to step through tags.
    mousebind = [
      "SUPER,btn_left,moveresize,curmove"
      "SUPER,btn_right,moveresize,curresize"
    ];
    axisbind = [
      "SUPER,UP,viewtoleft_have_client"
      "SUPER,DOWN,viewtoright_have_client"
    ];

  };
}
