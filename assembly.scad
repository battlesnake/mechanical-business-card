include <config.scad>

include <parts/1-base.scad>
include <parts/2-drive-layer.scad>
include <parts/2-drive-gear.scad>
include <parts/2-sun-gear.scad>
include <parts/3-mid-layer.scad>
include <parts/4-planetary-layer.scad>
include <parts/4-planetary-gears.scad>
include <parts/5-info-layer.scad>

/*
 * LAYERS:
 *
 * 1. Base layer
 * 2. Drive layer - two drive gears, sun gear
 * 3. Mid layer - sun gear
 * 4. Planetary layer - sun gear, planet geats, annular gear
 * 5. Top layer - with engraved text on underside
 */

/* Calculates z-offset of layer based on number of preceding thin/thick layers */
function z(thins, thicks, layers) =
	thin * thins +
	thick * thicks +
	explode * layers;

translate([-cardSize[0]/2, -cardSize[1]/2, 0]) {

translate([0, 0, z(0, 0, 0)]) {

	color(materials ? metalColor : "darkblue", alpha)
		base();

}

translate([0, 0, z(1, 0, 1)]) {

	color(materials ? metalColor : "darkcyan", alpha)
		driveLayer();

	color(materials ? metalColor : "red", alpha)
		translate([0, 0, z(0, 0, 1/3)])
			driveGear();
	
	color(materials ? metalColor : "yellow", alpha);
		translate([0, 0, z(0, 0, 2/3)])
			sunGear();
   
}

translate([0, 0, z(2, 1, 2)]) {
	
	color(materials ? metalColor : "green", alpha)
		midLayer();
	
}

translate([0, 0, z(3, 1, 3)]) {
	
	color(materials ? metalColor : "olive", alpha)
		planetaryLayer();
	
	color(materials ? metalColor : "lime", alpha)
		translate([0, 0, z(0, 0, 1/2)])
			planetaryGears();
	
}

translate([0, 0, z(3, 2, 4)]) {
	
	color(materials ? plasticColor : "aqua", alpha * plasticAlpha)
		topLayer();	   
	
	color("white", alpha * 0.7)
		textContent(additive = true);  
	
}

}
