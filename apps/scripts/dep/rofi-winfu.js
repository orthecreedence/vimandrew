#!/usr/bin/node
/**
 * Usage: rofi -modi winfu:./rofi-winfu.js -show winfu
 */

const { execSync } = require('child_process');

const HIDE_CURRENT_WINDOW = true;

const arg = process.argv[2];

function run(cmd, ...args) {
	args = args.map((x) => x.toString().replace(/[^a-z0-9_"-]/gi, ''));
	const fullcmd = `${cmd} ${args.join(' ')}`;
	return execSync(fullcmd)
		.toString('utf8');
}

if(!arg) {
	let cur_win = null;
	if(HIDE_CURRENT_WINDOW) {
		const focused = run('xdotool', 'getwindowfocus').replace(/[^0-9]/g, '');
		cur_win = '0x'+('00000000'+parseInt(focused).toString(16)).slice(-8);
	}

	const desktops = (() => {
		const wm_desktops = run('wmctrl', '-d')
			.split(/\n/g)
			.map((x) => x.replace(/^([0-9]+).*?WA: [^ ]+ +(.*)$/, '$1 $2'));
		const map = {};
		wm_desktops.forEach((line) => {
			const [desktop_id, name] = line.split(/ /);
			if(!desktop_id || !name) return;
			map[desktop_id] = name;
		});
		return map;
	})();

	const windows = run('wmctrl', '-l').split(/\n/g);
	const lines = windows
		.map((line) => {
			line = line.trim();
			if(line == '') return;
			const parts = line.split(/ +/g);
			const id = parts.shift();
			const desktop_id = parts.shift();
			const _machine = parts.shift();
			const title = parts.join(' ');
			const cls = run('xprop', '-id', id, 'WM_CLASS')
				.replace(/.*, /, '')
				.replace(/"/g, '')
				.split(/\n/g)[0];
			const desktop_name = desktops[desktop_id];
			if(HIDE_CURRENT_WINDOW) {
				if(id == cur_win) return;
			}
			return `W:${desktop_name} | ${cls} | ${title} | ${id}`;
		})
		.filter((x) => !!x);
	console.log(lines.join('\n'));
} else {
	const id = arg
		.replace(/.*0x/, '0x')
		.replace(/[^0-9a-fx]/ig, '');
	execSync(`wmctrl -i -a ${id}`);
}

