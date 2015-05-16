include <../config.scad>
include <../shapes/4-planetary-layer.scad>

module planetaryLayer() {
	linear_extrude(height = thick, slices = 1) {
		planetaryLayerShape();
	}
}
