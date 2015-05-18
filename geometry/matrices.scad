function rotation(angle, axis = [0, 0, 1]) = [
	let (
		s = sin(angle),
		c = cos(angle),
		C = 1 - cos(angle)
	)
	for (row = [0:3]) [
		for (col = [0:3])
			let (
				one = (row == 3 && col == 3),
				zero = (row == 3 || col == 3),
				diag = (row == col),
				sgn = ((2 + col - row) % 3 == 0) ? -1 : +1
			)
			one ? 1 : zero ? 0 : (axis[row] * axis[col] * C) +
				(diag ? c : sgn * axis[(1 + col + row) % 3] * s)
	]
];

function translation(v) = [
	[1,0,0,v[0]],
	[0,1,0,v[1]],
	[0,0,1,(len(v) >= 3 ? v[2] : 0)],
	[0,0,0,1],
];
