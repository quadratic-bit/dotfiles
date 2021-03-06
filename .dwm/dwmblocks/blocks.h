//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
    /*Icon*/        					/*Command*/             		  /*Update Interval*/   /*Update Signal*/
	{"^c#282c34^^b#e5c07b^  ",		"/home/ashooww/.dwm/dwmblocks/scripts/sb-cpu",		3,	0},

    {"^c#e5c07b^^b#282c34^  🧠 ",		"free -h | awk '/^Mem/ { print $3 }' | sed s/i//g",	3,	0},

	{"^c#282c34^^b#98c379^  ",			"/home/ashooww/.dwm/dwmblocks/scripts/sb-layout",	0,	6},

	{"^c#98c379^^b#282c34^    ",		"echo \"$(uname -r)\"",								0,	0},

	{"^c#282c34^^b#e06c75^   ",			"/home/ashooww/.dwm/dwmblocks/scripts/sb-battery",	30,	0},
	
	{"^c#e06c75^^b#282c34^   ",			"/home/ashooww/.dwm/dwmblocks/scripts/sb-bright",	0,	11},

	{"^c#282c34^^b#c678dd^  ",			"/home/ashooww/.dwm/dwmblocks/scripts/sb-volume",	0,	10},

	{"^c#c678dd^^b#282c34^ ",			"/home/ashooww/.dwm/dwmblocks/scripts/sb-clock",	5,	0},
};
//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = "  ";
static unsigned int delimLen = 5;
