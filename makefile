shapes=$(wildcard shapes/*.scad)
parts=$(wildcard parts/*.scad)

views=$(parts:parts/%.scad=views/%.scad)
images=$(views:views/%.scad=views/%.png)
pathviews=$(shapes:shapes/%.scad=paths/%.scad)
paths=$(pathviews:paths/%.scad=paths/%.dxf)
pathimages=$(pathviews:paths/%.scad=paths/%.svg)
polygons=$(views:views/%.scad=stl/%.stl)

scadopts=-D 'hq=1'

rendersize=2560,1440
imagesize=1280x720

scad=openscad $(scadopts)
scadpng=$(scad) --viewall --autocenter --imgsize $(rendersize)

.PHONY: default images paths pathimages assembly polygons

.INTERMEDIATE: views/exploded-big.png views/assembled-big.png

default: images paths assembly polygons

images: $(images)

paths: $(paths)

pathimages: $(pathimages)

polygons: $(polygons)

clean:
	@printf -- '\e[35mRemoving output files\e[0m\n'
	@rm -rf -- views paths

views/:
	@mkdir -p views

paths/:
	@mkdir -p paths

stl/:
	@mkdir -p stl

assembly: views/exploded.png views/assembled.png
	@printf -- '\e[35mRendering %s\e[0m\n' $@

views/%.scad: parts/%.scad | views/
	@printf -- '\e[35mGenerating %s\e[0m\n' $@
	@printf -- '%s\n' 'include <../$<>;' '$(shell printf -- '%s' "$*" | sed -E 's/^[0-9]+-//g; s/-([a-z])/\u\1/g;')();' > $@

views/exploded-big.png: assembly.scad | views/
	@printf -- '\e[35mRendering %s\e[0m\n' $@
	@$(scadpng) -o $@ -D 'explode=12' -D 'materials=false' --camera=-100,-100,30,0,0,0 --projection=perspective $<

views/assembled-big.png: assembly.scad | views/
	@printf -- '\e[35mRendering %s\e[0m\n' $@
	@$(scadpng) -o $@ -D 'explode=0' -D 'materials=true' --camera=-100,-100,100,0,0,0 --projection=perspective $<

views/%-big.png: views/%.scad
	@printf -- '\e[35mRendering %s\e[0m\n' $@
	@$(scadpng) -o $@ --camera=-100,-100,50,0,0,0 --projection=perspective $<

views/%.png: views/%-big.png
	@magick $< -resize $(imagesize) $@

paths/%.scad: shapes/%.scad | paths/
	@printf -- '\e[35mGenerating %s\e[0m\n' $@
	@printf -- '%s\n' "include <../$<>;" "$$(printf -- '%s' "$*" | sed -E 's/^[0-9]+-//g; s/-([a-z])/\u\1/g;')Shape();" > $@

paths/%.svg: paths/%.scad
	@printf -- '\e[35mGenerating %s\e[0m\n' $@
	@openscad -o $@ $(scadopts) $<
	@sed -i -e 's/stroke-width=\"0\.5\"/stroke-width=\"0.1\"/g' $@

paths/%.dxf: paths/%.scad
	@printf -- '\e[35mGenerating %s\e[0m\n' $@
	@$(scad) -o $@ $(scadopts) $<

stl/%.stl: views/%.scad | stl/
	@printf -- '\e[35mGenerating STL: %s\e[0m\n' $@
	@$(scad) -o $@ $(scadopts) $<
