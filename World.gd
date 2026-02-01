extends Node2D

@onready var tile_layer := $TileMapLayer

var width = 50

func generate_rows(y1, y2):
	var tiles = []
	for y in range(y1, y2):
		for x in range(-width, width):
			if x in [-1, 0]:
				continue
			tiles.append(Vector2i(x,y))
	tile_layer.set_cells_terrain_connect(tiles, 0, 0)
	

func generate_starterhole():
	for y in range(-1, 1):
		for x in range(-2, 2):
			
			tile_layer.set_cells_terrain_connect([Vector2i(x,y)], 0, -1)
	
	tile_layer.set_cell(Vector2i(0,0), 2, Vector2i(0,0))
	tile_layer.set_cell(Vector2i(-1,0), 2, Vector2i(0,0))
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_rows(-20, 40)
	generate_starterhole()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
