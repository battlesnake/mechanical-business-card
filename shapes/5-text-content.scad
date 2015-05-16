include <../config.scad>

module textContentShape() {
	translate([0, 40]) {
		text(myName, size = 3, font = "Liberation Serif:style=Bold", valign = "top");
	}
	translate([0, 14.5]) {
		square([0.25, 18]);
	}
	translate([1, 0]) {
		translate([0, 30]) {
			text(myPerk1, size = 2, font = "Liberation Mono:style=Bold", valign="baseline");
		}
		translate([0, 25]) {
			text(myPerk2, size = 2, font = "Liberation Mono:style=Bold", valign="baseline");
		}
		translate([0, 20]) {
			text(myPerk3, size = 2, font = "Liberation Mono:style=Bold", valign="baseline");
		}
		translate([0, 15]) {
			text(myPerk4, size = 2, font = "Liberation Mono:style=Bold", valign="baseline");
		}
	}
	translate([0, 5]) {
		text(myPhone, size = 2, font = "Liberation Sans Mono", valign = "bottom");
	}
	translate([0, 0]) {
		text(myEmail, size = 2, font = "Liberation Sans Mono", valign = "bottom");
	}
}
