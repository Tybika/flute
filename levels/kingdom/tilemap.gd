extends TileMapLayer

func update_terrain_8bit():
	set_cells_terrain_connect(self.get_used_cells(), 0, 1)

func update_terrain_32bit():
	set_cells_terrain_connect(self.get_used_cells(), 0, 0)
