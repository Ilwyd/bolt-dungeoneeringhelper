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
				r = { 38, 39 },
				g = { 86, 88 },
				b = { 127, 128 },
			},
		},
		crimson = {
			colourrange = {
				r = { 136, 137 },
				g = { 41, 42 },
				b = { 47, 48 },
			},
		},
		gold = {
			colourrange = {
				r = { 138, 139 },
				g = { 109, 110 },
				b = { 56, 57 },
			},
		},
		green = {
			colourrange = {
				r = { 52, 54 },
				g = { 129, 130 },
				b = { 86, 87 },
			},
		},
		orange = {
			colourrange = {
				r = { 146, 147 },
				g = { 74, 75 },
				b = { 59, 61 },
			},
		},
		purple = {
			colourrange = {
				r = { 68, 69 },
				g = { 52, 54 },
				b = { 129, 130 },
			},
		},
		silver = {
			colourrange = {
				r = { 128, 129 },
				g = { 124, 125 },
				b = { 117, 118 },
			},
		},
		yellow = {
			colourrange = {
				r = { 200, 201 },
				g = { 186, 187 },
				b = { 40, 41 },
			},
		},
	},
}

return {
	keys = keys,
}
