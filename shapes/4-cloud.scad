include <../config.scad>

module cloudShape() {
	r2 = 5;
	r = r2/2;
	k = 1;
	y = cloudSize[1] / 2 - r;
	x = cloudSize[0] / 2 - r;
	offset(r = k) {
		union() {
			translate([0, y])
				circle(r - k, center = true);
			translate([-x, -y])
				circle(r - k, center = true);
			translate([x, -y])
				circle(r - k, center = true);
			hull() {
				translate([0, -y]) {
					intersection() {
						translate([0, -(r - k) / 2]) {
							square([2 * x, r - k], center = true);
						}
						union() {
							translate([-x, 0])
								circle(r - k, center = true);
							translate([x, 0])
								circle(r - k, center = true);
						}
					}
				}
			}
		}
	}
}

module cloudWindowShape() {
	offset(r = cloudSize[1] / 4)
		offset(r = -cloudSize[1] / 4)
			square(cloudSize, center = true);
}
