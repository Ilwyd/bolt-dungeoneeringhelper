local keys = {
	-- Shapes:
	-- vertindex - The first vert on the shape's model that has the actual colour of the key.
	-- vertcount - The number of verts in the shape's icon model
	-- zerothvertpos - The model position of the first vertex
	shapes = {
		corner = {
			vertindex = 6,
			vertcount = 408,
			zerothvertpos = { 48, 24, -116 },
		},
		crescent = {
			vertindex = 144,
			vertcount = 960,
			zerothvertpos = { 84, 12, -120 },
		},
		diamond = {
			vertindex = 0,
			vertcount = 456,
			zerothvertpos = { -108, 36, 32 },
		},
		pentagon = {
			vertindex = 0,
			vertcount = 528,
			zerothvertpos = { 60, 32, -8 },
		},
		triangle = {
			vertindex = 72,
			vertcount = 312,
			zerothvertpos = { -100, 44, -44 },
		},
		rectangle = {
			vertindex = 0,
			vertcount = 456,
			zerothvertpos = { 100, 24, -4 },
		},
		shield = {
			vertindex = 36,
			vertcount = 984,
			zerothvertpos = { 100, 0, -72 },
		},
		wedge = {
			vertindex = 48,
			vertcount = 504,
			zerothvertpos = { 44, 24, -60 },
		},
	},
	-- Colours:
	-- colourrange - The range of values that are possible for a given key colour in rgb
	--> e.g. The red value for a key could be 10, 11, 12 therefore its range is r = { 10, 12 }
	colours = {
		blue = {
			colourrange = {
				r = { 32, 45 },
				g = { 80, 93 },
				b = { 120, 133 },
			},
		},
		crimson = {
			colourrange = {
				r = { 130, 143 },
				g = { 35, 48 },
				b = { 41, 54 },
			},
		},
		gold = {
			colourrange = {
				r = { 131, 144 },
				g = { 103, 116 },
				b = { 50, 63 },
			},
		},
		green = {
			colourrange = {
				r = { 46, 59 },
				g = { 122, 136 },
				b = { 81, 93 },
			},
		},
		orange = {
			colourrange = {
				r = { 140, 153 },
				g = { 67, 81 },
				b = { 53, 66 },
			},
		},
		purple = {
			colourrange = {
				r = { 62, 75 },
				g = { 46, 59 },
				b = { 122, 136 },
			},
		},
		silver = {
			colourrange = {
				r = { 121, 135 },
				g = { 117, 130 },
				b = { 110, 124 },
			},
		},
		yellow = {
			colourrange = {
				r = { 195, 206 },
				g = { 180, 193 },
				b = { 34, 47 },
			},
		},
	},
}

return {
	keys = keys,
}
