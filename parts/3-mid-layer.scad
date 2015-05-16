include <../config.scad>
include <../shapes/3-mid-layer.scad>

module midLayer() {
	linear_extrude(height = thin, slices = 1) {
		midLayerShape();
	}
}
