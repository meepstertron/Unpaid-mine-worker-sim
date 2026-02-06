extends Node2D

@onready var tile_layer := $TileMapLayer
@onready var player := $CharacterBody2D

var CHUNK_HEIGHT = 16
var generated_chunks = {}

var noise := FastNoiseLite.new()

var width = 50



func generate_rows(y1, y2):
	var tiles = []
	for y in range(y1, y2):
		for x in range(-width, width):
			if y == 1000:
				tile_layer.set_cell(Vector2i(x,y), 0, Vector2i(0,3))
				continue
			if y > 1000:
				tile_layer.set_cell(Vector2i(x,y), 0, Vector2i(1,3))
				continue
			if x in [-1, 0]:
				if y<0:
					tile_layer.set_cell(Vector2i(x,y), 1, Vector2i(0,0))
				continue
			var v = noise.get_noise_2d(x,y)
			if v > -0.5:
				tiles.append(Vector2i(x,y))
			
	tile_layer.set_cells_terrain_connect(tiles, 0, 0)
	

func generate_chunk(chunk_y):
	if generated_chunks.has(chunk_y):
		return
	generated_chunks[chunk_y] = true
	
	var y1 = chunk_y * CHUNK_HEIGHT
	var y2 = y1 + CHUNK_HEIGHT
	
	generate_rows(y1, y2)
	

func generate_starterhole():
	for y in range(-1, 1):
		for x in range(-2, 2):
			
			tile_layer.set_cells_terrain_connect([Vector2i(x,y)], 0, -1)
	
	tile_layer.set_cell(Vector2i(0,0), 2, Vector2i(0,0))
	tile_layer.set_cell(Vector2i(-1,0), 2, Vector2i(0,0))
	
	tile_layer.set_cell(Vector2i(0,-1), 1, Vector2i(0,0))
	tile_layer.set_cell(Vector2i(-1,-1), 1, Vector2i(0,0))
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	noise.frequency = 0.02
	generate_chunk(0)
	generate_chunk(-1)
	generate_starterhole()




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var player_tile_y = tile_layer.local_to_map(player.global_position).y+5
	
	var chunk_y = int(floor(player_tile_y/ CHUNK_HEIGHT))
	
	for dy in range(-1, 2):
		generate_chunk(chunk_y + dy)
