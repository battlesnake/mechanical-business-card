include <config.scad>

include <parts/1-base.scad>
include <parts/2-drive-layer.scad>
include <parts/2-drive-gear.scad>
include <parts/2-cloud-gear.scad>
include <parts/3-mid-layer.scad>
include <parts/3-reciprocator.scad>
include <parts/4-cloud-mount-layer.scad>
include <parts/4-cloud.scad>
include <parts/5-info-layer.scad>
include <parts/5-text-content.scad>

$fn = 20;

/*
 * LAYERS:
 *
 * 1. Base layer
 * 2. Drive layer - drive gear, cloud gears
 * 3. Mid layer - cloud reciprocator
 * 4. Planetary layer - holes for cloud mount pins
 * 5. Top layer - with engraved text on underside and cavity for clouds
 */

/* Calculates z-offset of layer based on number of preceding thin/thick layers */
function z(thins, thicks, layers) =
	thin * thins +
	thick * thicks +
	explode * layers;

translate([-cardSize[0]/2, -cardSize[1]/2, 0]) {

translate([0, 0, z(0, 0, 0)]) {

	color(materials ? metalColor : "darkviolet", alpha)
		base();

}

translate([0, 0, z(1, 0, 1)]) {

	color(materials ? metalColor : "darkblue", alpha)
		driveLayer();

	color(materials ? metalColor : "red", alpha)
		translate([0, 0, z(0, 0, 1/5)])
			driveGear();
	
	for (i = [0:2]) {
		color(materials ? metalColor : ["orange", "yellow", "lime"][i], alpha)
			translate([0, 0, z(0, 0, (i + 2) / 5)])
				cloudGear(i);
	}
   
}

translate([0, 0, z(2, 1, 2)]) {
	
	color(materials ? metalColor : "cyan", alpha)
		midLayer();

	spacing = z(0, 0, 1/4);
	
	translate([0, 0, spacing / 2]) {

		for (i = [0:2]) {
			color(materials ? metalColor : ["orange", "yellow", "lime"][i], alpha)
				translate([0, 0, z(0, 0, (4 * i + 5) / 18)])
					reciprocator(i, spacing);
		}
		
	}

}

translate([0, 0, z(3, 1, 3)]) {
	
	color(materials ? metalColor : "green", alpha)
		cloudMountLayer();

	color("lightcyan", alpha)
		for (i = [0:2]) {
			translate([0, 0, z(0, 0, (i + 2) / 5)])
				cloud(i);
		}
	
}

translate([0, 0, z(3, 2, 4)]) {
	
	color(materials ? plasticColor : "aqua", alpha * plasticAlpha)
		infoLayer();	   
	
	color([1,1,1,0] * 0.25 + [0,0,0,1] * alpha * 0.7)
		textContent(visible = true);	   
	
}

}
