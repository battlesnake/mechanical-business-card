shapes=$(wildcard shapes/*.scad)
parts=$(wildcard parts/*.scad)

views=$(parts:parts/%.scad=views/%.scad)
images=$(views:views/%.scad=views/%.png)
pathviews=$(shapes:shapes/%.scad=paths/%.scad)
paths=$(pathviews:paths/%.scad=paths/%.dxf)
pathimages=$(pathviews:paths/%.scad=paths/%.svg)

scadopts=-D '$$fn=200'

.PHONY: default assembly

default: $(images) $(paths) $(pathimages) assembly

clean:
	@printf -- '\e[35mRemoving output files\e[0m\n'
	@rm -rf -- views paths

views/:
	@mkdir -p views

paths/:
	@mkdir -p paths

assembly: assembly.scad | views/
	@printf -- '\e[35mRendering %s\e[0m\n' $@
	@openscad -o views/exploded.png $(scadopts) -D 'explode=12' -D 'materials=false' --camera=-100,-100,30,0,0,0 --viewall --autocenter --imgsize 1280,720 --projection=perspective $<
	@openscad -o views/assembled.png $(scadopts) -D 'explode=0' -D 'materials=true' --camera=-100,-100,100,0,0,0 --viewall --autocenter --imgsize 1280,720 --projection=perspective $<

views/%.scad: parts/%.scad | views/
	@printf -- '\e[35mGenerating %s\e[0m\n' $@
	@printf -- '%s\n' 'include <../$<>;' '$(shell printf -- '%s' "$*" | sed -E 's/^[0-9]+-//g; s/-([a-z])/\u\1/g;')();' > $@

views/%.png: views/%.scad
	@printf -- '\e[35mRendering %s\e[0m\n' $@
	@openscad -o $@ $(scadopts) --camera=-100,-100,100,0,0,0 --viewall --autocenter --imgsize 1280,720 --projection=perspective $<

paths/%.scad: shapes/%.scad | paths/
	@printf -- '\e[35mGenerating %s\e[0m\n' $@
	@printf -- '%s\n' "include <../$<>;" "$$(printf -- '%s' "$*" | sed -E 's/^[0-9]+-//g; s/-([a-z])/\u\1/g;')Shape();" > $@

paths/%.svg: paths/%.scad
	@printf -- '\e[35mGenerating %s\e[0m\n' $@
	@openscad -o $@ $(scadopts) $<
	@sed -i -e 's/stroke-width=\"0\.5\"/stroke-width=\"0.1\"/g' $@

paths/%.dxf: paths/%.scad
	@printf -- '\e[35mGenerating %s\e[0m\n' $@
	@openscad -o $@ $(scadopts) $<
