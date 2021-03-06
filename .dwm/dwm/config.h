/* See LICENSE file for copyright and license details. */

/* sound control */
#include<X11/XF86keysym.h>

/* appearance */
static const unsigned int borderpx  = 3;        /* border pixel of windows */
static const unsigned int gappx     = 6;
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 0;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const int user_bh            = 29;       /* 0 means that dwm will calculate bar height, >= 1 means dwm will user_bh as bar height */
static const char *fonts[]          = { "FontAwesome:size=11", "Droid Sans Mono Nerd Font:size=11", "SpaceMono Nerd Font Mono:size=11", "Ubuntu Mono Nerd Font:size=11" };
static const char col_gray1[]       = "#282c34";
static const char col_gray2[]       = "#353b45";
static const char col_gray3[]       = "#3e4451";
static const char col_white[]       = "#abb2bf";
static const char col_blue[]        = "#61afef";
static const char col_red[]         = "#e06c75";
static const char col_yellow[]      = "#e5c07b";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_white, col_gray1, col_gray3 },
	[SchemeSel]  = { col_white, col_gray2, col_blue  },
};

/* tagging */
static const char icon_folder[]  = "";
static const char icon_firefox[] = "";
static const char icon_code[]    = "";
static const char icon_discord[] = "";
static const char icon_spotify[] = "";
static const char icon_paint[]   = "";
static const char icon_keys[]    = "";
static const char icon_branch[]  = "";
static const char icon_file[]    = "";
static const char *tags[] = { icon_file, icon_firefox, icon_branch, icon_folder, icon_discord, icon_spotify, icon_paint };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            1,           -1 },
	{ "Firefox",  NULL,       NULL,       1 << 8,       0,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[T]",      tile },    /* first entry is default */
	{ "[F]",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0";
static const char *dmenucmd[]  = { "dmenu_run", "-m", dmenumon, NULL };
static const char *roficmd[]   = { "rofi", "-show", "drun",  NULL };
static const char *rofiemoji[] = { "rofi", "-show", "emoji", NULL };
static const char *termcmd[]   = { "kitty", NULL };
static const char *flamegui[]  = { "flameshot", "gui", NULL };
/*
static const char *upvol[]     = { "pactl", "set-sink-volume", "0", "+5%",    NULL }; 
static const char *downvol[]   = { "pactl", "set-sink-volume", "0", "-5%",    NULL }; 
static const char *mutevol[]   = { "pactl", "set-sink-mute",   "0", "toggle", NULL }; 
*/

static Key keys[] = {
	/* modifier						key			function		argument */
	{ MODKEY,                       XK_p,       spawn,          {.v = roficmd   } },
	{ MODKEY,                       XK_e,       spawn,          {.v = rofiemoji } },
	{ MODKEY|ShiftMask,             XK_Return,  spawn,          {.v = termcmd   } },
	{ 0,                            XK_Print,   spawn,          {.v = flamegui  } },
	{ MODKEY,                       XK_b,       togglebar,      {0} },
	{ MODKEY,                       XK_j,       focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,       focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,       incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,       incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,       setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,       setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return,  zoom,           {0} },
	{ MODKEY,                       XK_Tab,     view,           {0} },
	{ MODKEY|ShiftMask,             XK_c,       killclient,     {0} },
	{ MODKEY,                       XK_t,       setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,       setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,       setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,   setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,   togglefloating, {0} },
	{ MODKEY,                       XK_0,       view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,       tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,   focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period,  focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,   tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period,  tagmon,         {.i = +1 } },
	{ MODKEY,						XK_KP_Add,	spawn,			SHCMD("brightnessctl set 10+; pkill -RTMIN+11 dwmblocks") },
	{ MODKEY,				   XK_KP_Subtract,	spawn,	SHCMD("brightnessctl set 10-; pkill -RTMIN+11 dwmblocks") },
	{ 0,              XF86XK_AudioLowerVolume, 	spawn,         	SHCMD("pactl set-sink-volume 0 -5%; pkill -RTMIN+10 dwmblocks") },
	{ 0,              XF86XK_AudioRaiseVolume, 	spawn,         	SHCMD("pactl set-sink-volume 0 +5%; pkill -RTMIN+10 dwmblocks") },
	{ 0,                     XF86XK_AudioMute, 	spawn,         	SHCMD("pactl set-sink-mute 0 toggle; pkill -RTMIN+10 dwmblocks") },
	{ 0,                     XF86XK_AudioPlay, 	spawn,         	SHCMD("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause") },
	{ 0,                     XF86XK_AudioStop, 	spawn,         	SHCMD("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause") },
	{ 0,                     XF86XK_AudioPrev, 	spawn,         	SHCMD("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous") },
	{ 0,                     XF86XK_AudioNext, 	spawn,         	SHCMD("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next") },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	/*{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },*/
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

