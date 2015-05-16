include <../config.scad>
include <../shapes/2-drive-layer.scad>

module driveLayer() {
	linear_extrude(height = thick + thin, slices = 1) {
		driveLayerShape();
	}
}
