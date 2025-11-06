local keydoors = {
	shapes = {
		corner = {
			vertcount = 2328,
			zerothvertpos = { -244, 512, -8 },
		},
		crescent = {
			vertcount = 2862,
			zerothvertpos = { -244, 524, -12 },
		},
		diamond = {
			vertcount = 2190,
			zerothvertpos = { -244, 488, -96 },
		},
		pentagon = {
			vertcount = 2259,
			zerothvertpos = { -244, 536, 4 },
		},
		triangle = {
			vertcount = 2121,
			zerothvertpos = { -244, 388, 4 },
		},
		rectangle = {
			vertcount = 2190,
			zerothvertpos = { -244, 416, -20 },
		},
		shield = {
			vertcount = 2796,
			zerothvertpos = { -244, 548, -44 },
		},
		wedge = {
			vertcount = 2190,
			zerothvertpos = { -244, 424, -40 },
		},
	},
	colours = {
		blue = {
			zerothvertcolourrange = {
				r = { 61, 64 },
				g = { 137, 141 },
				b = { 203, 205 },
			},
		},
		crimson = {
			zerothvertcolourrange = {
				r = { 135, 138 },
				g = { 40, 43 },
				b = { 46, 49 },
			},
		},
		gold = {
			zerothvertcolourrange = {
				r = { 221, 222 },
				g = { 184, 185 },
				b = { 118, 121 },
			},
		},
		green = {
			zerothvertcolourrange = {
				r = { 75, 79 },
				g = { 187, 189 },
				b = { 124, 127 },
			},
		},
		orange = {
			zerothvertcolourrange = {
				r = { 215, 216 },
				g = { 110, 114 },
				b = { 89, 93 },
			},
		},
		purple = {
			zerothvertcolourrange = {
				r = { 117, 121 },
				g = { 93, 96 },
				b = { 215, 217 },
			},
		},
		silver = {
			zerothvertcolourrange = {
				r = { 196, 198 },
				g = { 189, 191 },
				b = { 188, 190 },
			},
		},
		yellow = {
			zerothvertcolourrange = {
				r = { 245, 245 },
				g = { 234, 235 },
				b = { 141, 144 },
			},
		},
	},
}

local skilldoors = {
	woodcutting = {
		vertcount = 4533,
		zerothvertpos = { 216, 0, 372 },
	},
	-- magic = {
	--     vertcount = 690,
	--     zerothvertpos = { -196, 656, -240 }
	-- },
	magic = {
		vertcount = 7017,
		zerothvertpos = { -203, 412, -164 },
	},
	construction = {
		vertcount = 3972,
		zerothvertpos = { 208, 580, -468 },
	},
	runecrafting = {
		vertcount = 936,
		zerothvertpos = { -256, 780, -56 },
	},
	crafting = {
		vertcount = 6342,
		zerothvertpos = { 208, 408, -132 },
	},
	smithing = {
		vertcount = 4581,
		zerothvertpos = { 208, 508, 116 },
	},
	prayer = {
		vertcount = 726,
		zerothvertpos = { -104, 492, -164 },
	},
	firemaking = {
		vertcount = 3105,
		zerothvertpos = { 182, 32, 16 },
	},
}

local gatestones = {
	groupgatestone = {
		vertcount = 585,
		zerothvertpos = { 40, 76, 36 },
		zerothvertcolourrange = {
			r = { 63, 66 },
			g = { 95, 97 },
			b = { 124, 126 },
		},
	},
	gatestone = {
		vertcount = 585,
		zerothvertpos = { 40, 76, 36 },
		zerothvertcolourrange = {
			r = { 73, 75 },
			g = { 116, 118 },
			b = { 103, 105 },
		},
	},
}

return {
	keydoors = keydoors,
	gatestones = gatestones,
}
