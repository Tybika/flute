extends TileMapLayer

func style_8bit():
	set_cells_terrain_connect(self.get_used_cells(), 0, 1)

func style_32bit():
	set_cells_terrain_connect(self.get_used_cells(), 0, 0)
