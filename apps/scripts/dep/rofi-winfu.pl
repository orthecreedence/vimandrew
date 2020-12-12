#!/usr/bin/perl
#
# Usage: rofi -modi winfu:./rofi-winfu.pl -show winfu

$EXCLUDE_NON_WINTYPES = false;
$SHOW_ONLY_CUR_DESKTOP = false;
$HIDE_CURRENT_WINDOW = true;


# Note this separator is actually a wonky unicode char that looks like a space
# but doesn't trigger rofi's tokenizing heh heh
$SEP = ' ';
$WIN = $ARGV[0];

if($WIN eq "") {
	if($HIDE_CURRENT_WINDOW eq true) {
		$winid = `xdotool getwindowfocus`;
		$cur_win = `printf "0x%08X" $winid`;
	}
	$cur_desktop = "<nope>";
	my %desktops;
	@desktops_pieces = split /\n/, `wmctrl -d`;
	$length = length @desktop_pieces;
	print "len: @desktop_pieces\n";
	for $piece (@desktop_pieces) {
		print "piece is $piece\n"
	}
} else {
	$id = $WIN =~ s/.*0x/0x/r;
	system('wmctrl', '-i', '-a', $id);
}

