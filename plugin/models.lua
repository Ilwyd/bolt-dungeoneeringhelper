local keydoors = {
    shapes = {
        corner = {
            vertcount = 2328,
            zerothvertpos = { -244, 512, -8 }
        },
        crescent = {
            vertcount = 2862,
            zerothvertpos = { -244, 524, -12 }
        },
        diamond = {
            vertcount = 2190,
            zerothvertpos = { -244, 488, -96 }
        },
        pentagon = {
            vertcount = 2259,
            zerothvertpos = { -244, 536, 4 }
        },
        triangle = {
            vertcount = 2121,
            zerothvertpos = { -244, 388, 4 }
        },
        rectangle = {
            vertcount = 2190,
            zerothvertpos = { -244, 416, -20 }
        },
        shield = {
            vertcount = 2796,
            zerothvertpos = { -244, 548, -44 }
        },
        wedge = {
            vertcount = 2190,
            zerothvertpos = { -244, 424, -40 }
        }
    },
    colours = {
        blue = {
            zerothvertcolours = {
                { 64, 141, 205 },
                { 61, 137, 203 }, -- Triangle
                { 64, 140, 205 }, -- Rectangle
            }
        },
        crimson = {
            zerothvertcolours = {
                { 138, 43, 49 },
                { 135, 40, 46 },
                { 136, 41, 47 }, -- Diamond
                { 137, 42, 48 }, -- Crescent
                { 138, 43, 49 }, -- Pentagon
            }
        },
        gold = {
            zerothvertcolours = {
                { 221, 184, 118 }
            }
        },
        green = {
            zerothvertcolours = {
                { 76, 188, 125 },
                { 75, 187, 124 }, -- Triangle
                { 78, 189, 126 }, -- Diamond
                { 79, 189, 127 }, -- Diamond
            }
        },
        orange = {
            zerothvertcolours = {
                { 215, 111, 90 },
                { 215, 110, 89 }, -- Pentagon
                { 215, 111, 91 }, -- Corner
                { 216, 113, 92 }, -- Wedge
            }
        },
        purple = {
            zerothvertcolours = {
                { 118, 94, 216 },
                { 117, 93, 216 },
                { 117, 93, 215 },
                { 120, 96, 217 }, -- Diamond
            }
        },
        silver = {
            zerothvertcolours = {
                { 197, 189, 188 },
                { 196, 189, 188 }, -- Wedge
                { 198, 191, 190 } -- Crescent
            }
        },
        yellow = {
            zerothvertcolours = {
                { 245, 234, 141 }, -- Corner
                { 245, 235, 142 },
                { 245, 235, 143 }, -- Shield
                { 245, 235, 144 }, -- Corner
                { 245, 235, 143 }, -- Crescent
            }
        }
    }
}

local skilldoors = {
    woodcutting = {
        vertcount = 4533,
        zerothvertpos = { 216, 0, 372 }
    },
    -- magic = { 
    --     vertcount = 690,
    --     zerothvertpos = { -196, 656, -240 }
    -- },
    magic = {
        vertcount = 7017,
        zerothvertpos = { -203, 412, -164 }
    },
    construction = {
        vertcount = 3972,
        zerothvertpos = { 208, 580, -468 }
    },
    runecrafting = {
        vertcount = 936,
        zerothvertpos = { -256, 780, -56 }
    },
    crafting = {
        vertcount = 6342,
        zerothvertpos = { 208, 408, -132 }
    },
    smithing = {
        vertcount = 4581,
        zerothvertpos = { 208, 508, 116 }
    },
    prayer = {
        vertcount = 726,
        zerothvertpos = { -104, 492, -164 }
    },
    firemaking = {
        vertcount = 3105,
        zerothvertpos = { 182, 32, 16 }
    }
}

local gatestones = {
    groupgatestone = {
        vertcount = 585,
        zerothvertpos = { 40, 76, 36 },
        zerothvertcolour = { 66, 97, 126 }
    },
    gatestone = {
        vertcount = 585,
        zerothvertpos = { 40, 76, 36 },
        zerothvertcolour = { 76, 118, 105 }
    }
}

return {
    keydoors = keydoors,
    gatestones = gatestones
}
