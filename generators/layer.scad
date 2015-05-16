include <../config.scad>

module layer() {
	difference() {
		hull() {
			for (x = [cornerRadius, cardSize[0] - cornerRadius]) {
				for (y = [cornerRadius, cardSize[1] - cornerRadius]) {
					translate([x, y]) {
						circle(r = cornerRadius);
					}
				}
			}
		}
		/* Fixing holes */
		for (x = [cornerRadius, cardSize[0] - cornerRadius]) {
			for (y = [cornerRadius, cardSize[1] - cornerRadius]) {
				translate([x, y]) {
					circle(r = cornerHoleRadius);
				}
			}
		}
	}
}
