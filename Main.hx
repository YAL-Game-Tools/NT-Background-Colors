package;
import haxe.io.Bytes;
import sys.io.File;
using StringTools;

/**
 * ...
 * @author YellowAfterlife
 */
class Main {
	static function main() {
		var args = Sys.args();
		function error(text:String) {
			Sys.println("Error: " + text);
			Sys.exit(0);
			throw text;
		}
		//
		var dwPath:String = "", bytes:Bytes = null;
		var info = if (args.length > 0) {
			dwPath = args.shift();
			if (!sys.FileSystem.exists(dwPath)) {
				error('$dwPath does not exist.');
			}
			Sys.println('Reading $dwPath...');
			bytes = File.getBytes(dwPath);
			false;
		} else true;
		//
		var changed = 0;
		function proc(id:String, offset:Int, defColor:Int) {
			if (info) {
				Sys.print(" " + id);
				return;
			}
			// validate const.i;conv.i.v:
			for (i in 0 ... 3) {
				if(bytes.getUInt16(offset + i * 8 + 2) != 0x840F
				|| bytes.getInt32(offset + i * 8 + 4) != 0x07520000) {
					error("No valid RGB constant at offset for " + id);
				}
			}
			// validate call.i;set.v:
			if(bytes.getInt32(offset + 24) != 0xD9020003) {
				error("No valid conversion at offset for " + id);
			}
			// get color:
			var sw:String = id + "=";
			var argColor:Null<Int> = null;
			for (arg in args) if (arg.startsWith(sw)) {
				argColor = Std.parseInt("0x" + arg.substring(3));
				break;
			}
			var color:Int = argColor != null ? argColor : defColor;
			//
			Sys.print('Setting $id to ${color.hex(6)}');
			if (color == defColor) Sys.print(" (default)");
			Sys.println("");
			for (i in 0 ... 3) {
				var p = offset + i * 8;
				var b = (color >> (8 * i)) & 255;
				if (bytes.get(p) != b) {
					bytes.set(p, b);
					changed += 1;
				}
			}
		}
		if (info) {
			Sys.println("Use: ntbc \".../steamapps/common/Nuclear Throne/data.win\" c1=FFFFFF s2=0000FF");
			Sys.print("Supported colors:");
		}
		// offset of
		// AF000F84000052077A000F84000052076A000F8400005207030002D9
		// , which is the first color modification and relative point.
		var p = 0x1CDB00;
		//
		proc("c0", p, 0x6A7AAF);
		p += 60; proc("c1", p, 0xAF8F6A);
		p += 60; proc("c2", p, 0x4C5946);
		p += 40; proc("s2", p, 0x080D01);
		p += 60; proc("c3", p, 0x8A969E);
		p += 60; proc("c4", p, 0x8152BC);
		p += 40; proc("s4", p, 0x06020C);
		p += 60; proc("c5", p, 0xB4BDC5);
		p += 40; proc("s5", p, 0x0E1344);
		p += 60; proc("c6", p, 0x091C20);
		p += 60; proc("c7", p, 0x611D24);
		p += 40; proc("s7", p, 0x0D0101);
		p += 60; proc("c100", p, 0x433523);
		p += 40; proc("s100", p, 0x00030E);
		p += 60; proc("c101", p, 0x51D1C8);
		p += 40; proc("s101", p, 0x012B43);
		p += 60; proc("c102", p, 0xA04B63);
		p += 40; proc("s102", p, 0x090012);
		p += 60; proc("c103", p, 0xEEF0F2);
		p += 40; proc("s103", p, 0x120014);
		p += 60; proc("c104", p, 0xFF9C23);
		p += 40; proc("s104", p, 0x420000);
		p += 60; proc("c105", p, 0x2A900C);
		p += 40; proc("s105", p, 0x140001);
		p += 60; proc("c106", p, 0xF5FAFB);
		p += 40; proc("s106", p, 0x00248C);
		p += 60; proc("c107", p, 0xEEF0F2);
		p += 40; proc("s107", p, 0x120014);
		if (!info) { // 0-1 for the menu
			p += 44; proc("c0", p, 0x6A7AAF);
		}
		if (!info) {
			Sys.println('$changed bytes changed.');
			if (changed > 0) {
				Sys.println('Saving $dwPath...');
				File.saveBytes(dwPath, bytes);
				Sys.println("Done.");
			}
		} else Sys.println("");
	}
	
}
