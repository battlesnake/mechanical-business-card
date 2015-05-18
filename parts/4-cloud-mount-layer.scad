include <../config.scad>
include <../shapes/4-cloud-mount-layer.scad>

module cloudMountLayer() {
	linear_extrude(height = thick, slices = 1) {
		cloudMountLayerShape();
	}
}
