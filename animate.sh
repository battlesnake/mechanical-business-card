#!/bin/bash

set -euo pipefail

# Quality
declare HQ="${HQ:-0}"

# Render resolution (higher than video resolution to give supersampling / AA
declare resX="$(( HQ ? 3840 : 800 ))"
declare resY="$(( HQ ? 2160 : 450))"

# Video resolution
declare crf=14
declare vidres
if (( HQ )); then
	vidres=hd1080
else
	vidres="${resX}x${resY}"
fi

# 3D resolution
declare fn="$(( HQ ? 400 : 10 ))"

# Number of frames
declare frames="$(( HQ ? 200 : 80 ))"
declare framesAfter="$(( HQ ? 200 : 20 ))"
declare totalFrames="$(( frames + framesAfter ))"

# Frame rate
declare rate="$(( HQ ? 24 : 8 ))"

# Temp folder

declare tmp="$(mktemp -d)"

function rmtmp {
	rm -rf -- "${tmp}"
}

mkdir -p -- "${tmp}"

trap rmtmp EXIT

# Output

declare out="animation"

mkdir -p -- "${out}"

# Floating point arithmetic

function fdiv {
	printf -- '%s / %s\n' "$1" "$2" | bc -l
}

function fmul {
	printf -- '%s * %s\n' "$1" "$2" | bc -l
}

function fadd {
	printf -- '%s + %s\n' "$1" "$2" | bc -l
}

function fsub {
	printf -- '%s - %s\n' "$1" "$2" | bc -l
}

function fint {
	declare n0="$1" n1="$2" t="$3" fn="${4:-}"
	shift 4
	if [ "${fn}" ]; then
		t="$("${fn}" "$t" "$@")"
	fi
	printf -- '%s + %s * (%s - %s)\n' "$n0" "$t" "$n1" "$n0" | bc -l
}

function ease {
	declare x="$1" scale="${2:-3}"
	printf -- 'x = (%s - 0.5) * 2 * %s; (1 + e(-%s)) / (1 + e(-x)); \n' "$x" "$scale" "$scale" | bc -l
}

function easeIn {
	declare x="$1" scale="${2:-3}"
	printf -- 'x = %s * %s; 2 * (1 + e(-%s)) / (1 + e(-x)) - 1; \n' "$x" "$scale" "$scale" | bc -l
}

function easeOut {
	declare x="$1" scale="${2:-3}"
	printf -- 'x = (%s - 1) * %s; 2 * (1 + e(-%s)) / (1 + e(-x)); \n' "$x" "$scale" "$scale" | bc -l
}

function linear {
	declare x="$1"
	printf -- '%s\n' "$x"
}

# Delete output

function clean {
	rm -rf -- "${out}"
}

# Render frames

function frameName {
	printf -- 'frame%04d.png' "$1"
}

function renderFrames {
	seq 0 $((totalFrames - 1)) | xargs -P 8 -I{} "$0" frame {}
}

function renderFrame {
	local actualFrame="$1"
	printf -- "\e[1mRendering frame %d of %d...\e[0m\n" "$actualFrame" "$totalFrames"
	if (( actualFrame >= frames )); then
		local frame="$((frames - 1))"
	else
		local frame="$actualFrame"
	fi
	declare file="${out}/$(frameName $actualFrame)"
	declare f="$(printf -- '%04d' "$frame")"
	declare t="$(fdiv $frame $((frames - 1)))"
	declare explode="$(fint 40 0.0001 $t ease 5)"
	declare camA="60"
	declare camB="0"
	declare camC="$(fint 800 320 $t easeIn 7)"
	declare camX="0"
	declare camY="0"
	declare camZ="$(fint 70 -5 $t ease 7)"
	declare camR="$(fint 600 150 $t linear 6)"
	declare materials="$(fint 0 100 $t easeOut 4.8)"
	# Render of frame with and without materials
	printf -- '%s\n' "true" "false" | xargs -I {} \
		openscad -o "${tmp}/frame-{}.png" \
			-D "Wd=$(fint 0 5000 $(fdiv $actualFrame $totalFrames) easeIn 5)" \
			-D "\$fn=${fn}" \
			-D 'materials={}' \
			-D "explode=$explode" \
			--camera=$camX,$camY,$camZ,$camA,$camB,$camC,$camR \
			--projection=perspective \
			--imgsize=$resX,$resY \
			assembly.scad
	# Blend materials and false colour images
	composite -blend "$materials" "${tmp}/frame-true.png" "${tmp}/frame-false.png" -alpha Set "${file}"
}

# Render video from frames

function renderVideo {
	ffmpeg -r $rate -i "${out}/frame%04d.png" \
		-s "${vidres}" \
		-c:v libx264 \
		-crf "${crf}" \
		-pix_fmt yuv444p \
		-y "${out}/animation.mp4"
}

# Render GIF from video

function renderGif {
	rm -f -- "${out}"/*.gif

	local video="${out}/animation.mp4"
	local filters='scale=640:-1:flags=lanczos'

	ffmpeg -v warning \
		-i "${video}" \
		-vf "${filters},palettegen=max_colors=160:stats_mode=diff" \
		-c:v png -f image2 - | \
	ffmpeg -v warning \
		-i "${video}" -i - \
		-lavfi "${filters} [x]; [x][1:v] paletteuse=dither=bayer:diff_mode=rectangle" \
		-f gif - | pv -b | \
	gifsicle -b --optimize=3 -o "${out}/animation.gif"
	du -Bk "${out}/animation.gif"
}

# Parameter processor

if (( ${IN_SCRIPT:-0} == 0 )); then
	if (( HQ > 0 )); then
		printf -- "\e[1mHigh quality mode\e[0m\n"
	fi
fi

export IN_SCRIPT=1

while (( $# )); do
	declare cmd="$1"
	shift
	case "${cmd}" in
	clean) clean;;
	frame)
		declare index="$1"
		shift
		renderFrame $index
		;;
	frames) renderFrames;;
	video) renderVideo;;
	gif) renderGif;;
	all)
		clean
		renderFrames
		renderVideo
		renderGif
		;;
	allhq)
		(
			export HQ=1 IN_SCRIPT=0
			"$0" all
		)
		;;
	*)
		printf > /dev/stderr -- "\e[1;31mUnknown command: %s\e[0m\n" "${cmd}"
		exit 1
		;;
	esac
done
