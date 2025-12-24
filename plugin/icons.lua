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
				r = { 37, 40 },
				g = { 85, 88 },
				b = { 125, 128 },
			},
		},
		crimson = {
			colourrange = {
				r = { 135, 138 },
				g = { 40, 43 },
				b = { 46, 49 },
			},
		},
		gold = {
			colourrange = {
				r = { 136, 139 },
				g = { 108, 111 },
				b = { 55, 58 },
			},
		},
		green = {
			colourrange = {
				r = { 51, 54 },
				g = { 127, 131 },
				b = { 84, 88 },
			},
		},
		orange = {
			colourrange = {
				r = { 145, 148 },
				g = { 72, 76 },
				b = { 58, 61 },
			},
		},
		purple = {
			colourrange = {
				r = { 67, 70 },
				g = { 51, 54 },
				b = { 127, 131 },
			},
		},
		silver = {
			colourrange = {
				r = { 126, 130 },
				g = { 122, 125 },
				b = { 115, 119 },
			},
		},
		yellow = {
			colourrange = {
				r = { 200, 201 },
				g = { 185, 188 },
				b = { 39, 42 },
			},
		},
	},
}

return {
	keys = keys,
}
