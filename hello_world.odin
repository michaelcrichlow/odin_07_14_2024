package game

import rl "vendor:raylib"
// import rlgl "vendor:raylib/rlgl"
import "core:fmt"
// import "core:slice"
import "core:encoding/json"
import "core:os"
print :: fmt.println
printf :: fmt.printf

// -------------  global  -------------
screenWidth :: 640
screenHeight :: 360
EDITING_MODE :: true

editing_mode_active := false
brush_mode := false
select_mode := false

// rectangle lines -----------------------------
mouse_rect_start_x: i32 = -16
mouse_rect_start_y: i32 = -16
mouse_rect_width: i32 = 4
mouse_rect_height: i32 = 4

blue_mouse_rect_start_x: i32 = -16
blue_mouse_rect_start_y: i32 = -16
blue_mouse_rect_width: i32 = 4
blue_mouse_rect_height: i32 = 4
blue_anchor_x: i32
blue_anchor_y: i32

green_mouse_rect_start_x: i32 = -16
green_mouse_rect_start_y: i32 = -16
green_mouse_rect_width: i32 = 4
green_mouse_rect_height: i32 = 4
green_anchor_x: i32
green_anchor_y: i32

purple_mouse_rect_start_x: i32 = -16
purple_mouse_rect_start_y: i32 = -16
purple_mouse_rect_width: i32 = 4
purple_mouse_rect_height: i32 = 4
purple_anchor_x: i32
purple_anchor_y: i32

current_mouse_rect: int
current_mouse_delete_rect: int
starting_x: i32
starting_y: i32
del_starting_x: i32
del_starting_y: i32

del_mouse_rect_start_x: i32 = -16
del_mouse_rect_start_y: i32 = -16
del_mouse_rect_width: i32 = 4
del_mouse_rect_height: i32 = 4

black_mouse_rect_start_x: i32 = -16
black_mouse_rect_start_y: i32 = -16
black_mouse_rect_width: i32 = 4
black_mouse_rect_height: i32 = 4
black_anchor_x: i32
black_anchor_y: i32

lime_mouse_rect_start_x: i32 = -16
lime_mouse_rect_start_y: i32 = -16
lime_mouse_rect_width: i32 = 4
lime_mouse_rect_height: i32 = 4
lime_anchor_x: i32
lime_anchor_y: i32

gray_mouse_rect_start_x: i32 = -16
gray_mouse_rect_start_y: i32 = -16
gray_mouse_rect_width: i32 = 4
gray_mouse_rect_height: i32 = 4
gray_anchor_x: i32
gray_anchor_y: i32
// -------------------------------------------------------------------------

rect_16: rl.Rectangle
// blank_16: rl.Texture2D = rl.LoadTexture("resources/blank_16.png")
// blank_16: rl.Texture2D = rl.LoadTexture("resources/blank_16.png")
show_saving := false
save_count := 0

made_handoff := false
handoff_x: i32 = 0
handoff_y: i32 = 0

// ---------------------------------------------------------------------------
tile_pos_x: i32
tile_pos_y: i32
currently_selected_texture: rl.Texture2D
show_tileset: bool
// ---------------------------------------------------------------------------

// main
main :: proc() {

	// ***  setup (run once)  ***
	rl.SetWindowState({.MSAA_4X_HINT}) // set window state
	rl.InitWindow(screenWidth, screenHeight, "Fullscreen RayLib Example")
	rl.SetTargetFPS(60) // 60 frames-per-second
	rl.SetWindowState({.VSYNC_HINT}) // set window state
	// rl.SetWindowState({.VSYNC_HINT, .MSAA_4X_HINT}) // set window state

	// create textures of the images
	main_bg_grid: rl.Texture2D = rl.LoadTexture("resources/bg_template.png")
	main_white_pixels: rl.Texture2D = rl.LoadTexture("resources/white_pixels_to_check_corners.png")
	white_square: rl.Texture2D = rl.LoadTexture("resources/16_by_16_square2.png")
	mini_tileset: rl.Texture2D = rl.LoadTexture("resources/mono_tile_set_small_00.png")
	tile_selector: rl.Texture2D = rl.LoadTexture("resources/tile_selector.png")
	currently_selected_texture = rl.LoadTexture("resources/16_by_16_square.png")
	blank_16: rl.Texture2D = rl.LoadTexture("resources/blank_16.png")


	// the screen size we render to, that is then scaled
	//! NOTE: Only works if you have a single monitor
	m: i32 = rl.GetCurrentMonitor()
	virtualWidth := rl.GetMonitorWidth(m)
	virtualHeight := rl.GetMonitorHeight(m)

	// RTT target for the virtual screen
	target_default := rl.LoadRenderTexture(640, 360)
	target_fullscreen := rl.LoadRenderTexture(virtualWidth, virtualHeight)
	// rl.SetTextureFilter(target.texture, .POINT)

	// variable for fullscreen toggle
	//! NOTE: setting screen size AND toggling fullscreen needs to be done separately
	is_fullscreen := false

	// scale
	screenScale := min(
		f32(rl.GetScreenWidth() / virtualWidth),
		f32(rl.GetScreenHeight() / virtualHeight),
	)

	original_resolution_rect := rl.Rectangle{0, 0, 640, 360}
	upscaled_resolution_rect := rl.Rectangle{0, 0, f32(virtualWidth), f32(virtualHeight)}
	// upscaled_resolution_rect := rl.Rectangle{0, 0, 2560, 1440}


	//? Uncmment this to check initialization from file -------------------------------------------
	// rectangle_array: [dynamic]RectWithTexture
	// defer delete(rectangle_array)

	// if data, ok := os.read_entire_file("data.json", allocator = context.temp_allocator); ok {
	// 	if json.unmarshal(data, &rectangle_array) != nil {
	// 		append(&rectangle_array, RectWithTexture{{0, 0, 16, 16}, blank_16})
	// 		print("Problem unmarshaling 'data.json'...")
	// 	}
	// }
	//? ------------------------------------------------------------------------------------------
	rectangle_array := [?]RectWithTexture {
		{{0, 0, 16, 16}, blank_16},
		{{16, 0, 16, 16}, blank_16},
		{{32, 0, 16, 16}, blank_16},
		{{48, 0, 16, 16}, blank_16},
		{{64, 0, 16, 16}, blank_16},
		{{80, 0, 16, 16}, blank_16},
		{{96, 0, 16, 16}, blank_16},
		{{112, 0, 16, 16}, blank_16},
		{{128, 0, 16, 16}, blank_16},
		{{144, 0, 16, 16}, blank_16},
		{{160, 0, 16, 16}, blank_16},
		{{176, 0, 16, 16}, blank_16},
		{{192, 0, 16, 16}, blank_16},
		{{208, 0, 16, 16}, blank_16},
		{{224, 0, 16, 16}, blank_16},
		{{240, 0, 16, 16}, blank_16},
		{{256, 0, 16, 16}, blank_16},
		{{272, 0, 16, 16}, blank_16},
		{{288, 0, 16, 16}, blank_16},
		{{304, 0, 16, 16}, blank_16},
		{{320, 0, 16, 16}, blank_16},
		{{336, 0, 16, 16}, blank_16},
		{{352, 0, 16, 16}, blank_16},
		{{368, 0, 16, 16}, blank_16},
		{{384, 0, 16, 16}, blank_16},
		{{400, 0, 16, 16}, blank_16},
		{{416, 0, 16, 16}, blank_16},
		{{432, 0, 16, 16}, blank_16},
		{{448, 0, 16, 16}, blank_16},
		{{464, 0, 16, 16}, blank_16},
		{{480, 0, 16, 16}, blank_16},
		{{496, 0, 16, 16}, blank_16},
		{{512, 0, 16, 16}, blank_16},
		{{528, 0, 16, 16}, blank_16},
		{{544, 0, 16, 16}, blank_16},
		{{560, 0, 16, 16}, blank_16},
		{{576, 0, 16, 16}, blank_16},
		{{592, 0, 16, 16}, blank_16},
		{{608, 0, 16, 16}, blank_16},
		{{624, 0, 16, 16}, blank_16},
		{{0, 16, 16, 16}, blank_16}, // start here
		{{16, 16, 16, 16}, blank_16},
		{{32, 16, 16, 16}, blank_16},
		{{48, 16, 16, 16}, blank_16},
		{{64, 16, 16, 16}, blank_16},
		{{80, 16, 16, 16}, blank_16},
		{{96, 16, 16, 16}, blank_16},
		{{112, 16, 16, 16}, blank_16},
		{{128, 16, 16, 16}, blank_16},
		{{144, 16, 16, 16}, blank_16},
		{{160, 16, 16, 16}, blank_16},
		{{176, 16, 16, 16}, blank_16},
		{{192, 16, 16, 16}, blank_16},
		{{208, 16, 16, 16}, blank_16},
		{{224, 16, 16, 16}, blank_16},
		{{240, 16, 16, 16}, blank_16},
		{{256, 16, 16, 16}, blank_16},
		{{272, 16, 16, 16}, blank_16},
		{{288, 16, 16, 16}, blank_16},
		{{304, 16, 16, 16}, blank_16},
		{{320, 16, 16, 16}, blank_16},
		{{336, 16, 16, 16}, blank_16},
		{{352, 16, 16, 16}, blank_16},
		{{368, 16, 16, 16}, blank_16},
		{{384, 16, 16, 16}, blank_16},
		{{400, 16, 16, 16}, blank_16},
		{{416, 16, 16, 16}, blank_16},
		{{432, 16, 16, 16}, blank_16},
		{{448, 16, 16, 16}, blank_16},
		{{464, 16, 16, 16}, blank_16},
		{{480, 16, 16, 16}, blank_16},
		{{496, 16, 16, 16}, blank_16},
		{{512, 16, 16, 16}, blank_16},
		{{528, 16, 16, 16}, blank_16},
		{{544, 16, 16, 16}, blank_16},
		{{560, 16, 16, 16}, blank_16},
		{{576, 16, 16, 16}, blank_16},
		{{592, 16, 16, 16}, blank_16},
		{{608, 16, 16, 16}, blank_16},
		{{624, 16, 16, 16}, blank_16}, // ---
		{{0, 32, 16, 16}, blank_16}, // start here
		{{16, 32, 16, 16}, blank_16},
		{{32, 32, 16, 16}, blank_16},
		{{48, 32, 16, 16}, blank_16},
		{{64, 32, 16, 16}, blank_16},
		{{80, 32, 16, 16}, blank_16},
		{{96, 32, 16, 16}, blank_16},
		{{112, 32, 16, 16}, blank_16},
		{{128, 32, 16, 16}, blank_16},
		{{144, 32, 16, 16}, blank_16},
		{{160, 32, 16, 16}, blank_16},
		{{176, 32, 16, 16}, blank_16},
		{{192, 32, 16, 16}, blank_16},
		{{208, 32, 16, 16}, blank_16},
		{{224, 32, 16, 16}, blank_16},
		{{240, 32, 16, 16}, blank_16},
		{{256, 32, 16, 16}, blank_16},
		{{272, 32, 16, 16}, blank_16},
		{{288, 32, 16, 16}, blank_16},
		{{304, 32, 16, 16}, blank_16},
		{{320, 32, 16, 16}, blank_16},
		{{336, 32, 16, 16}, blank_16},
		{{352, 32, 16, 16}, blank_16},
		{{368, 32, 16, 16}, blank_16},
		{{384, 32, 16, 16}, blank_16},
		{{400, 32, 16, 16}, blank_16},
		{{416, 32, 16, 16}, blank_16},
		{{432, 32, 16, 16}, blank_16},
		{{448, 32, 16, 16}, blank_16},
		{{464, 32, 16, 16}, blank_16},
		{{480, 32, 16, 16}, blank_16},
		{{496, 32, 16, 16}, blank_16},
		{{512, 32, 16, 16}, blank_16},
		{{528, 32, 16, 16}, blank_16},
		{{544, 32, 16, 16}, blank_16},
		{{560, 32, 16, 16}, blank_16},
		{{576, 32, 16, 16}, blank_16},
		{{592, 32, 16, 16}, blank_16},
		{{608, 32, 16, 16}, blank_16},
		{{624, 32, 16, 16}, blank_16}, // ---
		{{0, 48, 16, 16}, blank_16}, // start here
		{{16, 48, 16, 16}, blank_16},
		{{32, 48, 16, 16}, blank_16},
		{{48, 48, 16, 16}, blank_16},
		{{64, 48, 16, 16}, blank_16},
		{{80, 48, 16, 16}, blank_16},
		{{96, 48, 16, 16}, blank_16},
		{{112, 48, 16, 16}, blank_16},
		{{128, 48, 16, 16}, blank_16},
		{{144, 48, 16, 16}, blank_16},
		{{160, 48, 16, 16}, blank_16},
		{{176, 48, 16, 16}, blank_16},
		{{192, 48, 16, 16}, blank_16},
		{{208, 48, 16, 16}, blank_16},
		{{224, 48, 16, 16}, blank_16},
		{{240, 48, 16, 16}, blank_16},
		{{256, 48, 16, 16}, blank_16},
		{{272, 48, 16, 16}, blank_16},
		{{288, 48, 16, 16}, blank_16},
		{{304, 48, 16, 16}, blank_16},
		{{320, 48, 16, 16}, blank_16},
		{{336, 48, 16, 16}, blank_16},
		{{352, 48, 16, 16}, blank_16},
		{{368, 48, 16, 16}, blank_16},
		{{384, 48, 16, 16}, blank_16},
		{{400, 48, 16, 16}, blank_16},
		{{416, 48, 16, 16}, blank_16},
		{{432, 48, 16, 16}, blank_16},
		{{448, 48, 16, 16}, blank_16},
		{{464, 48, 16, 16}, blank_16},
		{{480, 48, 16, 16}, blank_16},
		{{496, 48, 16, 16}, blank_16},
		{{512, 48, 16, 16}, blank_16},
		{{528, 48, 16, 16}, blank_16},
		{{544, 48, 16, 16}, blank_16},
		{{560, 48, 16, 16}, blank_16},
		{{576, 48, 16, 16}, blank_16},
		{{592, 48, 16, 16}, blank_16},
		{{608, 48, 16, 16}, blank_16},
		{{624, 48, 16, 16}, blank_16}, // ---
		{{0, 64, 16, 16}, blank_16}, // start here
		{{16, 64, 16, 16}, blank_16},
		{{32, 64, 16, 16}, blank_16},
		{{48, 64, 16, 16}, blank_16},
		{{64, 64, 16, 16}, blank_16},
		{{80, 64, 16, 16}, blank_16},
		{{96, 64, 16, 16}, blank_16},
		{{112, 64, 16, 16}, blank_16},
		{{128, 64, 16, 16}, blank_16},
		{{144, 64, 16, 16}, blank_16},
		{{160, 64, 16, 16}, blank_16},
		{{176, 64, 16, 16}, blank_16},
		{{192, 64, 16, 16}, blank_16},
		{{208, 64, 16, 16}, blank_16},
		{{224, 64, 16, 16}, blank_16},
		{{240, 64, 16, 16}, blank_16},
		{{256, 64, 16, 16}, blank_16},
		{{272, 64, 16, 16}, blank_16},
		{{288, 64, 16, 16}, blank_16},
		{{304, 64, 16, 16}, blank_16},
		{{320, 64, 16, 16}, blank_16},
		{{336, 64, 16, 16}, blank_16},
		{{352, 64, 16, 16}, blank_16},
		{{368, 64, 16, 16}, blank_16},
		{{384, 64, 16, 16}, blank_16},
		{{400, 64, 16, 16}, blank_16},
		{{416, 64, 16, 16}, blank_16},
		{{432, 64, 16, 16}, blank_16},
		{{448, 64, 16, 16}, blank_16},
		{{464, 64, 16, 16}, blank_16},
		{{480, 64, 16, 16}, blank_16},
		{{496, 64, 16, 16}, blank_16},
		{{512, 64, 16, 16}, blank_16},
		{{528, 64, 16, 16}, blank_16},
		{{544, 64, 16, 16}, blank_16},
		{{560, 64, 16, 16}, blank_16},
		{{576, 64, 16, 16}, blank_16},
		{{592, 64, 16, 16}, blank_16},
		{{608, 64, 16, 16}, blank_16},
		{{624, 64, 16, 16}, blank_16}, // ---
		{{0, 80, 16, 16}, blank_16}, // start here
		{{16, 80, 16, 16}, blank_16},
		{{32, 80, 16, 16}, blank_16},
		{{48, 80, 16, 16}, blank_16},
		{{64, 80, 16, 16}, blank_16},
		{{80, 80, 16, 16}, blank_16},
		{{96, 80, 16, 16}, blank_16},
		{{112, 80, 16, 16}, blank_16},
		{{128, 80, 16, 16}, blank_16},
		{{144, 80, 16, 16}, blank_16},
		{{160, 80, 16, 16}, blank_16},
		{{176, 80, 16, 16}, blank_16},
		{{192, 80, 16, 16}, blank_16},
		{{208, 80, 16, 16}, blank_16},
		{{224, 80, 16, 16}, blank_16},
		{{240, 80, 16, 16}, blank_16},
		{{256, 80, 16, 16}, blank_16},
		{{272, 80, 16, 16}, blank_16},
		{{288, 80, 16, 16}, blank_16},
		{{304, 80, 16, 16}, blank_16},
		{{320, 80, 16, 16}, blank_16},
		{{336, 80, 16, 16}, blank_16},
		{{352, 80, 16, 16}, blank_16},
		{{368, 80, 16, 16}, blank_16},
		{{384, 80, 16, 16}, blank_16},
		{{400, 80, 16, 16}, blank_16},
		{{416, 80, 16, 16}, blank_16},
		{{432, 80, 16, 16}, blank_16},
		{{448, 80, 16, 16}, blank_16},
		{{464, 80, 16, 16}, blank_16},
		{{480, 80, 16, 16}, blank_16},
		{{496, 80, 16, 16}, blank_16},
		{{512, 80, 16, 16}, blank_16},
		{{528, 80, 16, 16}, blank_16},
		{{544, 80, 16, 16}, blank_16},
		{{560, 80, 16, 16}, blank_16},
		{{576, 80, 16, 16}, blank_16},
		{{592, 80, 16, 16}, blank_16},
		{{608, 80, 16, 16}, blank_16},
		{{624, 80, 16, 16}, blank_16}, // ---
		{{0, 96, 16, 16}, blank_16}, // start here
		{{16, 96, 16, 16}, blank_16},
		{{32, 96, 16, 16}, blank_16},
		{{48, 96, 16, 16}, blank_16},
		{{64, 96, 16, 16}, blank_16},
		{{80, 96, 16, 16}, blank_16},
		{{96, 96, 16, 16}, blank_16},
		{{112, 96, 16, 16}, blank_16},
		{{128, 96, 16, 16}, blank_16},
		{{144, 96, 16, 16}, blank_16},
		{{160, 96, 16, 16}, blank_16},
		{{176, 96, 16, 16}, blank_16},
		{{192, 96, 16, 16}, blank_16},
		{{208, 96, 16, 16}, blank_16},
		{{224, 96, 16, 16}, blank_16},
		{{240, 96, 16, 16}, blank_16},
		{{256, 96, 16, 16}, blank_16},
		{{272, 96, 16, 16}, blank_16},
		{{288, 96, 16, 16}, blank_16},
		{{304, 96, 16, 16}, blank_16},
		{{320, 96, 16, 16}, blank_16},
		{{336, 96, 16, 16}, blank_16},
		{{352, 96, 16, 16}, blank_16},
		{{368, 96, 16, 16}, blank_16},
		{{384, 96, 16, 16}, blank_16},
		{{400, 96, 16, 16}, blank_16},
		{{416, 96, 16, 16}, blank_16},
		{{432, 96, 16, 16}, blank_16},
		{{448, 96, 16, 16}, blank_16},
		{{464, 96, 16, 16}, blank_16},
		{{480, 96, 16, 16}, blank_16},
		{{496, 96, 16, 16}, blank_16},
		{{512, 96, 16, 16}, blank_16},
		{{528, 96, 16, 16}, blank_16},
		{{544, 96, 16, 16}, blank_16},
		{{560, 96, 16, 16}, blank_16},
		{{576, 96, 16, 16}, blank_16},
		{{592, 96, 16, 16}, blank_16},
		{{608, 96, 16, 16}, blank_16},
		{{624, 96, 16, 16}, blank_16}, // ---
		{{0, 112, 16, 16}, blank_16}, // start here
		{{16, 112, 16, 16}, blank_16},
		{{32, 112, 16, 16}, blank_16},
		{{48, 112, 16, 16}, blank_16},
		{{64, 112, 16, 16}, blank_16},
		{{80, 112, 16, 16}, blank_16},
		{{96, 112, 16, 16}, blank_16},
		{{112, 112, 16, 16}, blank_16},
		{{128, 112, 16, 16}, blank_16},
		{{144, 112, 16, 16}, blank_16},
		{{160, 112, 16, 16}, blank_16},
		{{176, 112, 16, 16}, blank_16},
		{{192, 112, 16, 16}, blank_16},
		{{208, 112, 16, 16}, blank_16},
		{{224, 112, 16, 16}, blank_16},
		{{240, 112, 16, 16}, blank_16},
		{{256, 112, 16, 16}, blank_16},
		{{272, 112, 16, 16}, blank_16},
		{{288, 112, 16, 16}, blank_16},
		{{304, 112, 16, 16}, blank_16},
		{{320, 112, 16, 16}, blank_16},
		{{336, 112, 16, 16}, blank_16},
		{{352, 112, 16, 16}, blank_16},
		{{368, 112, 16, 16}, blank_16},
		{{384, 112, 16, 16}, blank_16},
		{{400, 112, 16, 16}, blank_16},
		{{416, 112, 16, 16}, blank_16},
		{{432, 112, 16, 16}, blank_16},
		{{448, 112, 16, 16}, blank_16},
		{{464, 112, 16, 16}, blank_16},
		{{480, 112, 16, 16}, blank_16},
		{{496, 112, 16, 16}, blank_16},
		{{512, 112, 16, 16}, blank_16},
		{{528, 112, 16, 16}, blank_16},
		{{544, 112, 16, 16}, blank_16},
		{{560, 112, 16, 16}, blank_16},
		{{576, 112, 16, 16}, blank_16},
		{{592, 112, 16, 16}, blank_16},
		{{608, 112, 16, 16}, blank_16},
		{{624, 112, 16, 16}, blank_16}, // ---
		{{0, 128, 16, 16}, blank_16}, // start here
		{{16, 128, 16, 16}, blank_16},
		{{32, 128, 16, 16}, blank_16},
		{{48, 128, 16, 16}, blank_16},
		{{64, 128, 16, 16}, blank_16},
		{{80, 128, 16, 16}, blank_16},
		{{96, 128, 16, 16}, blank_16},
		{{112, 128, 16, 16}, blank_16},
		{{128, 128, 16, 16}, blank_16},
		{{144, 128, 16, 16}, blank_16},
		{{160, 128, 16, 16}, blank_16},
		{{176, 128, 16, 16}, blank_16},
		{{192, 128, 16, 16}, blank_16},
		{{208, 128, 16, 16}, blank_16},
		{{224, 128, 16, 16}, blank_16},
		{{240, 128, 16, 16}, blank_16},
		{{256, 128, 16, 16}, blank_16},
		{{272, 128, 16, 16}, blank_16},
		{{288, 128, 16, 16}, blank_16},
		{{304, 128, 16, 16}, blank_16},
		{{320, 128, 16, 16}, blank_16},
		{{336, 128, 16, 16}, blank_16},
		{{352, 128, 16, 16}, blank_16},
		{{368, 128, 16, 16}, blank_16},
		{{384, 128, 16, 16}, blank_16},
		{{400, 128, 16, 16}, blank_16},
		{{416, 128, 16, 16}, blank_16},
		{{432, 128, 16, 16}, blank_16},
		{{448, 128, 16, 16}, blank_16},
		{{464, 128, 16, 16}, blank_16},
		{{480, 128, 16, 16}, blank_16},
		{{496, 128, 16, 16}, blank_16},
		{{512, 128, 16, 16}, blank_16},
		{{528, 128, 16, 16}, blank_16},
		{{544, 128, 16, 16}, blank_16},
		{{560, 128, 16, 16}, blank_16},
		{{576, 128, 16, 16}, blank_16},
		{{592, 128, 16, 16}, blank_16},
		{{608, 128, 16, 16}, blank_16},
		{{624, 128, 16, 16}, blank_16}, // ---
		{{0, 144, 16, 16}, blank_16}, // start here
		{{16, 144, 16, 16}, blank_16},
		{{32, 144, 16, 16}, blank_16},
		{{48, 144, 16, 16}, blank_16},
		{{64, 144, 16, 16}, blank_16},
		{{80, 144, 16, 16}, blank_16},
		{{96, 144, 16, 16}, blank_16},
		{{112, 144, 16, 16}, blank_16},
		{{128, 144, 16, 16}, blank_16},
		{{144, 144, 16, 16}, blank_16},
		{{160, 144, 16, 16}, blank_16},
		{{176, 144, 16, 16}, blank_16},
		{{192, 144, 16, 16}, blank_16},
		{{208, 144, 16, 16}, blank_16},
		{{224, 144, 16, 16}, blank_16},
		{{240, 144, 16, 16}, blank_16},
		{{256, 144, 16, 16}, blank_16},
		{{272, 144, 16, 16}, blank_16},
		{{288, 144, 16, 16}, blank_16},
		{{304, 144, 16, 16}, blank_16},
		{{320, 144, 16, 16}, blank_16},
		{{336, 144, 16, 16}, blank_16},
		{{352, 144, 16, 16}, blank_16},
		{{368, 144, 16, 16}, blank_16},
		{{384, 144, 16, 16}, blank_16},
		{{400, 144, 16, 16}, blank_16},
		{{416, 144, 16, 16}, blank_16},
		{{432, 144, 16, 16}, blank_16},
		{{448, 144, 16, 16}, blank_16},
		{{464, 144, 16, 16}, blank_16},
		{{480, 144, 16, 16}, blank_16},
		{{496, 144, 16, 16}, blank_16},
		{{512, 144, 16, 16}, blank_16},
		{{528, 144, 16, 16}, blank_16},
		{{544, 144, 16, 16}, blank_16},
		{{560, 144, 16, 16}, blank_16},
		{{576, 144, 16, 16}, blank_16},
		{{592, 144, 16, 16}, blank_16},
		{{608, 144, 16, 16}, blank_16},
		{{624, 144, 16, 16}, blank_16}, // ---
		{{0, 160, 16, 16}, blank_16}, // start here
		{{16, 160, 16, 16}, blank_16},
		{{32, 160, 16, 16}, blank_16},
		{{48, 160, 16, 16}, blank_16},
		{{64, 160, 16, 16}, blank_16},
		{{80, 160, 16, 16}, blank_16},
		{{96, 160, 16, 16}, blank_16},
		{{112, 160, 16, 16}, blank_16},
		{{128, 160, 16, 16}, blank_16},
		{{144, 160, 16, 16}, blank_16},
		{{160, 160, 16, 16}, blank_16},
		{{176, 160, 16, 16}, blank_16},
		{{192, 160, 16, 16}, blank_16},
		{{208, 160, 16, 16}, blank_16},
		{{224, 160, 16, 16}, blank_16},
		{{240, 160, 16, 16}, blank_16},
		{{256, 160, 16, 16}, blank_16},
		{{272, 160, 16, 16}, blank_16},
		{{288, 160, 16, 16}, blank_16},
		{{304, 160, 16, 16}, blank_16},
		{{320, 160, 16, 16}, blank_16},
		{{336, 160, 16, 16}, blank_16},
		{{352, 160, 16, 16}, blank_16},
		{{368, 160, 16, 16}, blank_16},
		{{384, 160, 16, 16}, blank_16},
		{{400, 160, 16, 16}, blank_16},
		{{416, 160, 16, 16}, blank_16},
		{{432, 160, 16, 16}, blank_16},
		{{448, 160, 16, 16}, blank_16},
		{{464, 160, 16, 16}, blank_16},
		{{480, 160, 16, 16}, blank_16},
		{{496, 160, 16, 16}, blank_16},
		{{512, 160, 16, 16}, blank_16},
		{{528, 160, 16, 16}, blank_16},
		{{544, 160, 16, 16}, blank_16},
		{{560, 160, 16, 16}, blank_16},
		{{576, 160, 16, 16}, blank_16},
		{{592, 160, 16, 16}, blank_16},
		{{608, 160, 16, 16}, blank_16},
		{{624, 160, 16, 16}, blank_16}, // ---
		{{0, 176, 16, 16}, blank_16}, // start here
		{{16, 176, 16, 16}, blank_16},
		{{32, 176, 16, 16}, blank_16},
		{{48, 176, 16, 16}, blank_16},
		{{64, 176, 16, 16}, blank_16},
		{{80, 176, 16, 16}, blank_16},
		{{96, 176, 16, 16}, blank_16},
		{{112, 176, 16, 16}, blank_16},
		{{128, 176, 16, 16}, blank_16},
		{{144, 176, 16, 16}, blank_16},
		{{160, 176, 16, 16}, blank_16},
		{{176, 176, 16, 16}, blank_16},
		{{192, 176, 16, 16}, blank_16},
		{{208, 176, 16, 16}, blank_16},
		{{224, 176, 16, 16}, blank_16},
		{{240, 176, 16, 16}, blank_16},
		{{256, 176, 16, 16}, blank_16},
		{{272, 176, 16, 16}, blank_16},
		{{288, 176, 16, 16}, blank_16},
		{{304, 176, 16, 16}, blank_16},
		{{320, 176, 16, 16}, blank_16},
		{{336, 176, 16, 16}, blank_16},
		{{352, 176, 16, 16}, blank_16},
		{{368, 176, 16, 16}, blank_16},
		{{384, 176, 16, 16}, blank_16},
		{{400, 176, 16, 16}, blank_16},
		{{416, 176, 16, 16}, blank_16},
		{{432, 176, 16, 16}, blank_16},
		{{448, 176, 16, 16}, blank_16},
		{{464, 176, 16, 16}, blank_16},
		{{480, 176, 16, 16}, blank_16},
		{{496, 176, 16, 16}, blank_16},
		{{512, 176, 16, 16}, blank_16},
		{{528, 176, 16, 16}, blank_16},
		{{544, 176, 16, 16}, blank_16},
		{{560, 176, 16, 16}, blank_16},
		{{576, 176, 16, 16}, blank_16},
		{{592, 176, 16, 16}, blank_16},
		{{608, 176, 16, 16}, blank_16},
		{{624, 176, 16, 16}, blank_16}, // ---
		{{0, 192, 16, 16}, blank_16}, // start here
		{{16, 192, 16, 16}, blank_16},
		{{32, 192, 16, 16}, blank_16},
		{{48, 192, 16, 16}, blank_16},
		{{64, 192, 16, 16}, blank_16},
		{{80, 192, 16, 16}, blank_16},
		{{96, 192, 16, 16}, blank_16},
		{{112, 192, 16, 16}, blank_16},
		{{128, 192, 16, 16}, blank_16},
		{{144, 192, 16, 16}, blank_16},
		{{160, 192, 16, 16}, blank_16},
		{{176, 192, 16, 16}, blank_16},
		{{192, 192, 16, 16}, blank_16},
		{{208, 192, 16, 16}, blank_16},
		{{224, 192, 16, 16}, blank_16},
		{{240, 192, 16, 16}, blank_16},
		{{256, 192, 16, 16}, blank_16},
		{{272, 192, 16, 16}, blank_16},
		{{288, 192, 16, 16}, blank_16},
		{{304, 192, 16, 16}, blank_16},
		{{320, 192, 16, 16}, blank_16},
		{{336, 192, 16, 16}, blank_16},
		{{352, 192, 16, 16}, blank_16},
		{{368, 192, 16, 16}, blank_16},
		{{384, 192, 16, 16}, blank_16},
		{{400, 192, 16, 16}, blank_16},
		{{416, 192, 16, 16}, blank_16},
		{{432, 192, 16, 16}, blank_16},
		{{448, 192, 16, 16}, blank_16},
		{{464, 192, 16, 16}, blank_16},
		{{480, 192, 16, 16}, blank_16},
		{{496, 192, 16, 16}, blank_16},
		{{512, 192, 16, 16}, blank_16},
		{{528, 192, 16, 16}, blank_16},
		{{544, 192, 16, 16}, blank_16},
		{{560, 192, 16, 16}, blank_16},
		{{576, 192, 16, 16}, blank_16},
		{{592, 192, 16, 16}, blank_16},
		{{608, 192, 16, 16}, blank_16},
		{{624, 192, 16, 16}, blank_16}, // ---
		{{0, 208, 16, 16}, blank_16}, // start here
		{{16, 208, 16, 16}, blank_16},
		{{32, 208, 16, 16}, blank_16},
		{{48, 208, 16, 16}, blank_16},
		{{64, 208, 16, 16}, blank_16},
		{{80, 208, 16, 16}, blank_16},
		{{96, 208, 16, 16}, blank_16},
		{{112, 208, 16, 16}, blank_16},
		{{128, 208, 16, 16}, blank_16},
		{{144, 208, 16, 16}, blank_16},
		{{160, 208, 16, 16}, blank_16},
		{{176, 208, 16, 16}, blank_16},
		{{192, 208, 16, 16}, blank_16},
		{{208, 208, 16, 16}, blank_16},
		{{224, 208, 16, 16}, blank_16},
		{{240, 208, 16, 16}, blank_16},
		{{256, 208, 16, 16}, blank_16},
		{{272, 208, 16, 16}, blank_16},
		{{288, 208, 16, 16}, blank_16},
		{{304, 208, 16, 16}, blank_16},
		{{320, 208, 16, 16}, blank_16},
		{{336, 208, 16, 16}, blank_16},
		{{352, 208, 16, 16}, blank_16},
		{{368, 208, 16, 16}, blank_16},
		{{384, 208, 16, 16}, blank_16},
		{{400, 208, 16, 16}, blank_16},
		{{416, 208, 16, 16}, blank_16},
		{{432, 208, 16, 16}, blank_16},
		{{448, 208, 16, 16}, blank_16},
		{{464, 208, 16, 16}, blank_16},
		{{480, 208, 16, 16}, blank_16},
		{{496, 208, 16, 16}, blank_16},
		{{512, 208, 16, 16}, blank_16},
		{{528, 208, 16, 16}, blank_16},
		{{544, 208, 16, 16}, blank_16},
		{{560, 208, 16, 16}, blank_16},
		{{576, 208, 16, 16}, blank_16},
		{{592, 208, 16, 16}, blank_16},
		{{608, 208, 16, 16}, blank_16},
		{{624, 208, 16, 16}, blank_16}, // ---
		{{0, 224, 16, 16}, blank_16}, // start here
		{{16, 224, 16, 16}, blank_16},
		{{32, 224, 16, 16}, blank_16},
		{{48, 224, 16, 16}, blank_16},
		{{64, 224, 16, 16}, blank_16},
		{{80, 224, 16, 16}, blank_16},
		{{96, 224, 16, 16}, blank_16},
		{{112, 224, 16, 16}, blank_16},
		{{128, 224, 16, 16}, blank_16},
		{{144, 224, 16, 16}, blank_16},
		{{160, 224, 16, 16}, blank_16},
		{{176, 224, 16, 16}, blank_16},
		{{192, 224, 16, 16}, blank_16},
		{{208, 224, 16, 16}, blank_16},
		{{224, 224, 16, 16}, blank_16},
		{{240, 224, 16, 16}, blank_16},
		{{256, 224, 16, 16}, blank_16},
		{{272, 224, 16, 16}, blank_16},
		{{288, 224, 16, 16}, blank_16},
		{{304, 224, 16, 16}, blank_16},
		{{320, 224, 16, 16}, blank_16},
		{{336, 224, 16, 16}, blank_16},
		{{352, 224, 16, 16}, blank_16},
		{{368, 224, 16, 16}, blank_16},
		{{384, 224, 16, 16}, blank_16},
		{{400, 224, 16, 16}, blank_16},
		{{416, 224, 16, 16}, blank_16},
		{{432, 224, 16, 16}, blank_16},
		{{448, 224, 16, 16}, blank_16},
		{{464, 224, 16, 16}, blank_16},
		{{480, 224, 16, 16}, blank_16},
		{{496, 224, 16, 16}, blank_16},
		{{512, 224, 16, 16}, blank_16},
		{{528, 224, 16, 16}, blank_16},
		{{544, 224, 16, 16}, blank_16},
		{{560, 224, 16, 16}, blank_16},
		{{576, 224, 16, 16}, blank_16},
		{{592, 224, 16, 16}, blank_16},
		{{608, 224, 16, 16}, blank_16},
		{{624, 224, 16, 16}, blank_16}, // ---
		{{0, 240, 16, 16}, blank_16}, // start here
		{{16, 240, 16, 16}, blank_16},
		{{32, 240, 16, 16}, blank_16},
		{{48, 240, 16, 16}, blank_16},
		{{64, 240, 16, 16}, blank_16},
		{{80, 240, 16, 16}, blank_16},
		{{96, 240, 16, 16}, blank_16},
		{{112, 240, 16, 16}, blank_16},
		{{128, 240, 16, 16}, blank_16},
		{{144, 240, 16, 16}, blank_16},
		{{160, 240, 16, 16}, blank_16},
		{{176, 240, 16, 16}, blank_16},
		{{192, 240, 16, 16}, blank_16},
		{{208, 240, 16, 16}, blank_16},
		{{224, 240, 16, 16}, blank_16},
		{{240, 240, 16, 16}, blank_16},
		{{256, 240, 16, 16}, blank_16},
		{{272, 240, 16, 16}, blank_16},
		{{288, 240, 16, 16}, blank_16},
		{{304, 240, 16, 16}, blank_16},
		{{320, 240, 16, 16}, blank_16},
		{{336, 240, 16, 16}, blank_16},
		{{352, 240, 16, 16}, blank_16},
		{{368, 240, 16, 16}, blank_16},
		{{384, 240, 16, 16}, blank_16},
		{{400, 240, 16, 16}, blank_16},
		{{416, 240, 16, 16}, blank_16},
		{{432, 240, 16, 16}, blank_16},
		{{448, 240, 16, 16}, blank_16},
		{{464, 240, 16, 16}, blank_16},
		{{480, 240, 16, 16}, blank_16},
		{{496, 240, 16, 16}, blank_16},
		{{512, 240, 16, 16}, blank_16},
		{{528, 240, 16, 16}, blank_16},
		{{544, 240, 16, 16}, blank_16},
		{{560, 240, 16, 16}, blank_16},
		{{576, 240, 16, 16}, blank_16},
		{{592, 240, 16, 16}, blank_16},
		{{608, 240, 16, 16}, blank_16},
		{{624, 240, 16, 16}, blank_16}, // ---
		{{0, 256, 16, 16}, blank_16}, // start here
		{{16, 256, 16, 16}, blank_16},
		{{32, 256, 16, 16}, blank_16},
		{{48, 256, 16, 16}, blank_16},
		{{64, 256, 16, 16}, blank_16},
		{{80, 256, 16, 16}, blank_16},
		{{96, 256, 16, 16}, blank_16},
		{{112, 256, 16, 16}, blank_16},
		{{128, 256, 16, 16}, blank_16},
		{{144, 256, 16, 16}, blank_16},
		{{160, 256, 16, 16}, blank_16},
		{{176, 256, 16, 16}, blank_16},
		{{192, 256, 16, 16}, blank_16},
		{{208, 256, 16, 16}, blank_16},
		{{224, 256, 16, 16}, blank_16},
		{{240, 256, 16, 16}, blank_16},
		{{256, 256, 16, 16}, blank_16},
		{{272, 256, 16, 16}, blank_16},
		{{288, 256, 16, 16}, blank_16},
		{{304, 256, 16, 16}, blank_16},
		{{320, 256, 16, 16}, blank_16},
		{{336, 256, 16, 16}, blank_16},
		{{352, 256, 16, 16}, blank_16},
		{{368, 256, 16, 16}, blank_16},
		{{384, 256, 16, 16}, blank_16},
		{{400, 256, 16, 16}, blank_16},
		{{416, 256, 16, 16}, blank_16},
		{{432, 256, 16, 16}, blank_16},
		{{448, 256, 16, 16}, blank_16},
		{{464, 256, 16, 16}, blank_16},
		{{480, 256, 16, 16}, blank_16},
		{{496, 256, 16, 16}, blank_16},
		{{512, 256, 16, 16}, blank_16},
		{{528, 256, 16, 16}, blank_16},
		{{544, 256, 16, 16}, blank_16},
		{{560, 256, 16, 16}, blank_16},
		{{576, 256, 16, 16}, blank_16},
		{{592, 256, 16, 16}, blank_16},
		{{608, 256, 16, 16}, blank_16},
		{{624, 256, 16, 16}, blank_16}, // ---
		{{0, 272, 16, 16}, blank_16}, // start here
		{{16, 272, 16, 16}, blank_16},
		{{32, 272, 16, 16}, blank_16},
		{{48, 272, 16, 16}, blank_16},
		{{64, 272, 16, 16}, blank_16},
		{{80, 272, 16, 16}, blank_16},
		{{96, 272, 16, 16}, blank_16},
		{{112, 272, 16, 16}, blank_16},
		{{128, 272, 16, 16}, blank_16},
		{{144, 272, 16, 16}, blank_16},
		{{160, 272, 16, 16}, blank_16},
		{{176, 272, 16, 16}, blank_16},
		{{192, 272, 16, 16}, blank_16},
		{{208, 272, 16, 16}, blank_16},
		{{224, 272, 16, 16}, blank_16},
		{{240, 272, 16, 16}, blank_16},
		{{256, 272, 16, 16}, blank_16},
		{{272, 272, 16, 16}, blank_16},
		{{288, 272, 16, 16}, blank_16},
		{{304, 272, 16, 16}, blank_16},
		{{320, 272, 16, 16}, blank_16},
		{{336, 272, 16, 16}, blank_16},
		{{352, 272, 16, 16}, blank_16},
		{{368, 272, 16, 16}, blank_16},
		{{384, 272, 16, 16}, blank_16},
		{{400, 272, 16, 16}, blank_16},
		{{416, 272, 16, 16}, blank_16},
		{{432, 272, 16, 16}, blank_16},
		{{448, 272, 16, 16}, blank_16},
		{{464, 272, 16, 16}, blank_16},
		{{480, 272, 16, 16}, blank_16},
		{{496, 272, 16, 16}, blank_16},
		{{512, 272, 16, 16}, blank_16},
		{{528, 272, 16, 16}, blank_16},
		{{544, 272, 16, 16}, blank_16},
		{{560, 272, 16, 16}, blank_16},
		{{576, 272, 16, 16}, blank_16},
		{{592, 272, 16, 16}, blank_16},
		{{608, 272, 16, 16}, blank_16},
		{{624, 272, 16, 16}, blank_16}, // ---
		{{0, 288, 16, 16}, blank_16}, // start here
		{{16, 288, 16, 16}, blank_16},
		{{32, 288, 16, 16}, blank_16},
		{{48, 288, 16, 16}, blank_16},
		{{64, 288, 16, 16}, blank_16},
		{{80, 288, 16, 16}, blank_16},
		{{96, 288, 16, 16}, blank_16},
		{{112, 288, 16, 16}, blank_16},
		{{128, 288, 16, 16}, blank_16},
		{{144, 288, 16, 16}, blank_16},
		{{160, 288, 16, 16}, blank_16},
		{{176, 288, 16, 16}, blank_16},
		{{192, 288, 16, 16}, blank_16},
		{{208, 288, 16, 16}, blank_16},
		{{224, 288, 16, 16}, blank_16},
		{{240, 288, 16, 16}, blank_16},
		{{256, 288, 16, 16}, blank_16},
		{{272, 288, 16, 16}, blank_16},
		{{288, 288, 16, 16}, blank_16},
		{{304, 288, 16, 16}, blank_16},
		{{320, 288, 16, 16}, blank_16},
		{{336, 288, 16, 16}, blank_16},
		{{352, 288, 16, 16}, blank_16},
		{{368, 288, 16, 16}, blank_16},
		{{384, 288, 16, 16}, blank_16},
		{{400, 288, 16, 16}, blank_16},
		{{416, 288, 16, 16}, blank_16},
		{{432, 288, 16, 16}, blank_16},
		{{448, 288, 16, 16}, blank_16},
		{{464, 288, 16, 16}, blank_16},
		{{480, 288, 16, 16}, blank_16},
		{{496, 288, 16, 16}, blank_16},
		{{512, 288, 16, 16}, blank_16},
		{{528, 288, 16, 16}, blank_16},
		{{544, 288, 16, 16}, blank_16},
		{{560, 288, 16, 16}, blank_16},
		{{576, 288, 16, 16}, blank_16},
		{{592, 288, 16, 16}, blank_16},
		{{608, 288, 16, 16}, blank_16},
		{{624, 288, 16, 16}, blank_16}, // ---
		{{0, 304, 16, 16}, blank_16}, // start here
		{{16, 304, 16, 16}, blank_16},
		{{32, 304, 16, 16}, blank_16},
		{{48, 304, 16, 16}, blank_16},
		{{64, 304, 16, 16}, blank_16},
		{{80, 304, 16, 16}, blank_16},
		{{96, 304, 16, 16}, blank_16},
		{{112, 304, 16, 16}, blank_16},
		{{128, 304, 16, 16}, blank_16},
		{{144, 304, 16, 16}, blank_16},
		{{160, 304, 16, 16}, blank_16},
		{{176, 304, 16, 16}, blank_16},
		{{192, 304, 16, 16}, blank_16},
		{{208, 304, 16, 16}, blank_16},
		{{224, 304, 16, 16}, blank_16},
		{{240, 304, 16, 16}, blank_16},
		{{256, 304, 16, 16}, blank_16},
		{{272, 304, 16, 16}, blank_16},
		{{288, 304, 16, 16}, blank_16},
		{{304, 304, 16, 16}, blank_16},
		{{320, 304, 16, 16}, blank_16},
		{{336, 304, 16, 16}, blank_16},
		{{352, 304, 16, 16}, blank_16},
		{{368, 304, 16, 16}, blank_16},
		{{384, 304, 16, 16}, blank_16},
		{{400, 304, 16, 16}, blank_16},
		{{416, 304, 16, 16}, blank_16},
		{{432, 304, 16, 16}, blank_16},
		{{448, 304, 16, 16}, blank_16},
		{{464, 304, 16, 16}, blank_16},
		{{480, 304, 16, 16}, blank_16},
		{{496, 304, 16, 16}, blank_16},
		{{512, 304, 16, 16}, blank_16},
		{{528, 304, 16, 16}, blank_16},
		{{544, 304, 16, 16}, blank_16},
		{{560, 304, 16, 16}, blank_16},
		{{576, 304, 16, 16}, blank_16},
		{{592, 304, 16, 16}, blank_16},
		{{608, 304, 16, 16}, blank_16},
		{{624, 304, 16, 16}, blank_16}, // ---
		{{0, 320, 16, 16}, blank_16}, // start here
		{{16, 320, 16, 16}, blank_16},
		{{32, 320, 16, 16}, blank_16},
		{{48, 320, 16, 16}, blank_16},
		{{64, 320, 16, 16}, blank_16},
		{{80, 320, 16, 16}, blank_16},
		{{96, 320, 16, 16}, blank_16},
		{{112, 320, 16, 16}, blank_16},
		{{128, 320, 16, 16}, blank_16},
		{{144, 320, 16, 16}, blank_16},
		{{160, 320, 16, 16}, blank_16},
		{{176, 320, 16, 16}, blank_16},
		{{192, 320, 16, 16}, blank_16},
		{{208, 320, 16, 16}, blank_16},
		{{224, 320, 16, 16}, blank_16},
		{{240, 320, 16, 16}, blank_16},
		{{256, 320, 16, 16}, blank_16},
		{{272, 320, 16, 16}, blank_16},
		{{288, 320, 16, 16}, blank_16},
		{{304, 320, 16, 16}, blank_16},
		{{320, 320, 16, 16}, blank_16},
		{{336, 320, 16, 16}, blank_16},
		{{352, 320, 16, 16}, blank_16},
		{{368, 320, 16, 16}, blank_16},
		{{384, 320, 16, 16}, blank_16},
		{{400, 320, 16, 16}, blank_16},
		{{416, 320, 16, 16}, blank_16},
		{{432, 320, 16, 16}, blank_16},
		{{448, 320, 16, 16}, blank_16},
		{{464, 320, 16, 16}, blank_16},
		{{480, 320, 16, 16}, blank_16},
		{{496, 320, 16, 16}, blank_16},
		{{512, 320, 16, 16}, blank_16},
		{{528, 320, 16, 16}, blank_16},
		{{544, 320, 16, 16}, blank_16},
		{{560, 320, 16, 16}, blank_16},
		{{576, 320, 16, 16}, blank_16},
		{{592, 320, 16, 16}, blank_16},
		{{608, 320, 16, 16}, blank_16},
		{{624, 320, 16, 16}, blank_16}, // ---
		{{0, 336, 16, 16}, blank_16}, // start here
		{{16, 336, 16, 16}, blank_16},
		{{32, 336, 16, 16}, blank_16},
		{{48, 336, 16, 16}, blank_16},
		{{64, 336, 16, 16}, blank_16},
		{{80, 336, 16, 16}, blank_16},
		{{96, 336, 16, 16}, blank_16},
		{{112, 336, 16, 16}, blank_16},
		{{128, 336, 16, 16}, blank_16},
		{{144, 336, 16, 16}, blank_16},
		{{160, 336, 16, 16}, blank_16},
		{{176, 336, 16, 16}, blank_16},
		{{192, 336, 16, 16}, blank_16},
		{{208, 336, 16, 16}, blank_16},
		{{224, 336, 16, 16}, blank_16},
		{{240, 336, 16, 16}, blank_16},
		{{256, 336, 16, 16}, blank_16},
		{{272, 336, 16, 16}, blank_16},
		{{288, 336, 16, 16}, blank_16},
		{{304, 336, 16, 16}, blank_16},
		{{320, 336, 16, 16}, blank_16},
		{{336, 336, 16, 16}, blank_16},
		{{352, 336, 16, 16}, blank_16},
		{{368, 336, 16, 16}, blank_16},
		{{384, 336, 16, 16}, blank_16},
		{{400, 336, 16, 16}, blank_16},
		{{416, 336, 16, 16}, blank_16},
		{{432, 336, 16, 16}, blank_16},
		{{448, 336, 16, 16}, blank_16},
		{{464, 336, 16, 16}, blank_16},
		{{480, 336, 16, 16}, blank_16},
		{{496, 336, 16, 16}, blank_16},
		{{512, 336, 16, 16}, blank_16},
		{{528, 336, 16, 16}, blank_16},
		{{544, 336, 16, 16}, blank_16},
		{{560, 336, 16, 16}, blank_16},
		{{576, 336, 16, 16}, blank_16},
		{{592, 336, 16, 16}, blank_16},
		{{608, 336, 16, 16}, blank_16},
		{{624, 336, 16, 16}, blank_16}, // ---
		{{0, 352, 16, 16}, blank_16}, // start here
		{{16, 352, 16, 16}, blank_16},
		{{32, 352, 16, 16}, blank_16},
		{{48, 352, 16, 16}, blank_16},
		{{64, 352, 16, 16}, blank_16},
		{{80, 352, 16, 16}, blank_16},
		{{96, 352, 16, 16}, blank_16},
		{{112, 352, 16, 16}, blank_16},
		{{128, 352, 16, 16}, blank_16},
		{{144, 352, 16, 16}, blank_16},
		{{160, 352, 16, 16}, blank_16},
		{{176, 352, 16, 16}, blank_16},
		{{192, 352, 16, 16}, blank_16},
		{{208, 352, 16, 16}, blank_16},
		{{224, 352, 16, 16}, blank_16},
		{{240, 352, 16, 16}, blank_16},
		{{256, 352, 16, 16}, blank_16},
		{{272, 352, 16, 16}, blank_16},
		{{288, 352, 16, 16}, blank_16},
		{{304, 352, 16, 16}, blank_16},
		{{320, 352, 16, 16}, blank_16},
		{{336, 352, 16, 16}, blank_16},
		{{352, 352, 16, 16}, blank_16},
		{{368, 352, 16, 16}, blank_16},
		{{384, 352, 16, 16}, blank_16},
		{{400, 352, 16, 16}, blank_16},
		{{416, 352, 16, 16}, blank_16},
		{{432, 352, 16, 16}, blank_16},
		{{448, 352, 16, 16}, blank_16},
		{{464, 352, 16, 16}, blank_16},
		{{480, 352, 16, 16}, blank_16},
		{{496, 352, 16, 16}, blank_16},
		{{512, 352, 16, 16}, blank_16},
		{{528, 352, 16, 16}, blank_16},
		{{544, 352, 16, 16}, blank_16},
		{{560, 352, 16, 16}, blank_16},
		{{576, 352, 16, 16}, blank_16},
		{{592, 352, 16, 16}, blank_16},
		{{608, 352, 16, 16}, blank_16},
		{{624, 352, 16, 16}, blank_16}, // ---
	}


	// *********  start animation loop  **********
	for (!rl.WindowShouldClose()) { 	// Quit if click X in top right corner or ESC

		// ***  input  ***
		// toggle fullscreen
		if (rl.IsKeyDown(.LEFT_ALT) && rl.IsKeyPressed(.ENTER)) ||
		   (rl.IsKeyDown(.RIGHT_ALT) && rl.IsKeyPressed(.ENTER)) {
			is_fullscreen = !is_fullscreen
			if (!rl.IsWindowFullscreen()) {
				rl.SetWindowSize(virtualWidth, virtualHeight)
			}
		}

		if is_fullscreen && !rl.IsWindowFullscreen() {
			rl.ToggleFullscreen()
		}
		if !is_fullscreen && rl.IsWindowFullscreen() {
			rl.ToggleFullscreen()
			rl.SetWindowSize(screenWidth, screenHeight)
			rl.SetWindowPosition(
				(virtualWidth - screenWidth) / 2,
				(virtualHeight - screenHeight) / 2,
			)
		}

		//* EDITING MODE SPECIFIC INPUTS * ---------------------------------------------------
		if EDITING_MODE {
			if (rl.IsKeyPressed(.E)) {
				editing_mode_active = !editing_mode_active
			}
		}

		if editing_mode_active {
			if (rl.IsKeyPressed(.B)) {
				brush_mode = true
				select_mode = false
			}
		}

		if editing_mode_active {
			if (rl.IsKeyPressed(.S)) {
				brush_mode = false
				select_mode = true
			}
		}

		if !editing_mode_active {
			brush_mode = false
			select_mode = false

		}

		{ 	//** MOUSE RECTANGLE LOGIC --------------------------------------------------------------
			if editing_mode_active && brush_mode {
				if (rl.IsMouseButtonPressed(.LEFT)) {

					// get current mouse position
					mouse_position: rl.Vector2
					mouse_position = rl.GetMousePosition()
					scale: i32 = 4

					if is_fullscreen {
						mouse_rect_start_x = i32(mouse_position.x) / scale
						mouse_rect_start_y = i32(mouse_position.y) / scale
					} else {
						mouse_rect_start_x = i32(mouse_position.x)
						mouse_rect_start_y = i32(mouse_position.y)
					}

				}

				// draws the orange rectangle lines
				if (rl.IsMouseButtonDown(.LEFT)) {
					mouse_position: rl.Vector2
					mouse_position = rl.GetMousePosition()
					scale: i32 = 4


					if is_fullscreen {
						mouse_rect_width = (i32(mouse_position.x) / scale) - mouse_rect_start_x
						mouse_rect_height = (i32(mouse_position.y) / scale) - mouse_rect_start_y
					} else {
						mouse_rect_width = i32(mouse_position.x) - mouse_rect_start_x
						mouse_rect_height = i32(mouse_position.y) - mouse_rect_start_y
					}

				}

				//? --------------------------------------------------------------------------------
				//? BLUE RECTANGLE LINES
				if (rl.IsMouseButtonPressed(.LEFT)) {

					// get current mouse position
					mouse_position: rl.Vector2
					mouse_position = rl.GetMousePosition()
					scale: i32 = 4

					if is_fullscreen {
						blue_anchor_x = i32(mouse_position.x) / scale
						blue_anchor_y = i32(mouse_position.y) / scale
					} else {
						blue_anchor_x = i32(mouse_position.x)
						blue_anchor_y = i32(mouse_position.y)
					}

				}

				// draws the blue rectangle lines
				if (rl.IsMouseButtonDown(.LEFT)) {
					mouse_position: rl.Vector2
					mouse_position = rl.GetMousePosition()
					scale: i32 = 4


					if is_fullscreen {
						blue_mouse_rect_start_x = (i32(mouse_position.x) / scale)
						blue_mouse_rect_start_y = blue_anchor_y
						blue_mouse_rect_width = blue_anchor_x - (i32(mouse_position.x) / scale)
						blue_mouse_rect_height = (i32(mouse_position.y) / scale) - blue_anchor_y
					} else {
						blue_mouse_rect_start_x = i32(mouse_position.x)
						blue_mouse_rect_start_y = blue_anchor_y
						blue_mouse_rect_width = blue_anchor_x - i32(mouse_position.x)
						blue_mouse_rect_height = i32(mouse_position.y) - blue_anchor_y
					}

				}
				//? --------------------------------------------------------------------------------

				//* --------------------------------------------------------------------------------
				//* GREEN RECTANGLE LINES
				if (rl.IsMouseButtonPressed(.LEFT)) {

					// get current mouse position
					mouse_position: rl.Vector2
					mouse_position = rl.GetMousePosition()
					scale: i32 = 4

					if is_fullscreen {
						green_anchor_x = i32(mouse_position.x) / scale
						green_anchor_y = i32(mouse_position.y) / scale
					} else {
						green_anchor_x = i32(mouse_position.x)
						green_anchor_y = i32(mouse_position.y)
					}

				}

				// draws the green rectangle lines
				if (rl.IsMouseButtonDown(.LEFT)) {
					mouse_position: rl.Vector2
					mouse_position = rl.GetMousePosition()
					scale: i32 = 4


					if is_fullscreen {
						green_mouse_rect_start_x = (i32(mouse_position.x) / scale)
						green_mouse_rect_start_y = (i32(mouse_position.y) / scale)
						green_mouse_rect_width = green_anchor_x - (i32(mouse_position.x) / scale)
						green_mouse_rect_height = green_anchor_y - (i32(mouse_position.y) / scale)
					} else {
						green_mouse_rect_start_x = i32(mouse_position.x)
						green_mouse_rect_start_y = i32(mouse_position.y)
						green_mouse_rect_width = green_anchor_x - i32(mouse_position.x)
						green_mouse_rect_height = green_anchor_y - i32(mouse_position.y)
					}

				}
				//* --------------------------------------------------------------------------------

				// --------------------------------------------------------------------------------
				// PURPLE RECTANGLE LINES
				if (rl.IsMouseButtonPressed(.LEFT)) {

					// get current mouse position
					mouse_position: rl.Vector2
					mouse_position = rl.GetMousePosition()
					scale: i32 = 4

					if is_fullscreen {
						purple_anchor_x = i32(mouse_position.x) / scale
						purple_anchor_y = i32(mouse_position.y) / scale
					} else {
						purple_anchor_x = i32(mouse_position.x)
						purple_anchor_y = i32(mouse_position.y)
					}

				}

				// draws the purple rectangle lines
				if (rl.IsMouseButtonDown(.LEFT)) {
					mouse_position: rl.Vector2
					mouse_position = rl.GetMousePosition()
					scale: i32 = 4


					if is_fullscreen {
						purple_mouse_rect_start_x = purple_anchor_x
						purple_mouse_rect_start_y = (i32(mouse_position.y) / scale)
						purple_mouse_rect_width = (i32(mouse_position.x) / scale) - purple_anchor_x
						purple_mouse_rect_height =
							purple_anchor_y - (i32(mouse_position.y) / scale)
					} else {
						purple_mouse_rect_start_x = purple_anchor_x
						purple_mouse_rect_start_y = i32(mouse_position.y)
						purple_mouse_rect_width = i32(mouse_position.x) - purple_anchor_x
						purple_mouse_rect_height = purple_anchor_y - i32(mouse_position.y)
					}

				}
				// --------------------------------------------------------------------------------

				// choose rect lines
				if (rl.IsMouseButtonPressed(.LEFT)) {

					// get current mouse position
					mouse_position: rl.Vector2
					mouse_position = rl.GetMousePosition()
					scale: i32 = 4

					if is_fullscreen {
						starting_x = i32(mouse_position.x) / scale
						starting_y = i32(mouse_position.y) / scale
					} else {
						starting_x = i32(mouse_position.x)
						starting_y = i32(mouse_position.y)
					}

				}

				if (rl.IsMouseButtonDown(.LEFT)) {
					mouse_position: rl.Vector2
					mouse_position = rl.GetMousePosition()
					scale: i32 = 4

					if is_fullscreen {
						if (i32(mouse_position.x) / scale) > starting_x &&
						   (i32(mouse_position.y) / scale) > starting_y {
							current_mouse_rect = int(current_rect.ORANGE)
						} else if (i32(mouse_position.x) / scale) < starting_x &&
						   (i32(mouse_position.y) / scale) > starting_y {
							current_mouse_rect = int(current_rect.BLUE)
						} else if (i32(mouse_position.x) / scale) < starting_x &&
						   (i32(mouse_position.y) / scale) < starting_y {
							current_mouse_rect = int(current_rect.GREEN)
						} else if (i32(mouse_position.x) / scale) > starting_x &&
						   (i32(mouse_position.y) / scale) < starting_y {
							current_mouse_rect = int(current_rect.PURPLE)
						}
					} else {
						if i32(mouse_position.x) > starting_x &&
						   i32(mouse_position.y) > starting_y {
							current_mouse_rect = int(current_rect.ORANGE)
						} else if i32(mouse_position.x) < starting_x &&
						   i32(mouse_position.y) > starting_y {
							current_mouse_rect = int(current_rect.BLUE)
						} else if i32(mouse_position.x) < starting_x &&
						   i32(mouse_position.y) < starting_y {
							current_mouse_rect = int(current_rect.GREEN)
						} else if i32(mouse_position.x) > starting_x &&
						   i32(mouse_position.y) < starting_y {
							current_mouse_rect = int(current_rect.PURPLE)
						}

					}

				}

				//* --------------------------------------------------------------------------------------------------

				// mouse_rect := define_mouse_rect(mouse_rect_start_x, mouse_rect_start_y)
				mouse_rect := rl.Rectangle {
					f32(mouse_rect_start_x),
					f32(mouse_rect_start_y),
					f32(mouse_rect_width),
					f32(mouse_rect_height),
				}

				blue_mouse_rect := rl.Rectangle {
					f32(blue_mouse_rect_start_x),
					f32(blue_mouse_rect_start_y),
					f32(blue_mouse_rect_width),
					f32(blue_mouse_rect_height),
				}

				green_mouse_rect := rl.Rectangle {
					f32(green_mouse_rect_start_x),
					f32(green_mouse_rect_start_y),
					f32(green_mouse_rect_width),
					f32(green_mouse_rect_height),
				}

				purple_mouse_rect := rl.Rectangle {
					f32(purple_mouse_rect_start_x),
					f32(purple_mouse_rect_start_y),
					f32(purple_mouse_rect_width),
					f32(purple_mouse_rect_height),
				}


				//* --------------------------------------------------------------------------------------------------

				for &val in rectangle_array {
					collision: bool
					if current_mouse_rect == int(current_rect.ORANGE) {
						collision = rl.CheckCollisionRecs(val.rect, mouse_rect)
					} else if current_mouse_rect == int(current_rect.BLUE) {
						collision = rl.CheckCollisionRecs(val.rect, blue_mouse_rect)
					} else if current_mouse_rect == int(current_rect.GREEN) {
						collision = rl.CheckCollisionRecs(val.rect, green_mouse_rect)
					} else if current_mouse_rect == int(current_rect.PURPLE) {
						collision = rl.CheckCollisionRecs(val.rect, purple_mouse_rect)
					}

					if collision {
						// updated code would be something like 'val.texture = get_currently_selected_texture()'
						// val.texture = white_square //! would be updated with the texture I'm clicking on in full editor
						val.texture = currently_selected_texture
					}
				}

				// reset when button is released
				if (rl.IsMouseButtonReleased(.LEFT)) {
					// reset orange rectangle lines
					mouse_rect_start_x = -16
					mouse_rect_start_y = -16
					mouse_rect_width = 4
					mouse_rect_height = 4

					// reset blue rectangle
					blue_mouse_rect_start_x = -16
					blue_mouse_rect_start_y = -16
					blue_mouse_rect_width = 4
					blue_mouse_rect_height = 4

					// reset green rectangle
					green_mouse_rect_start_x = -16
					green_mouse_rect_start_y = -16
					green_mouse_rect_width = 4
					green_mouse_rect_height = 4

					// reset purple rectangle
					purple_mouse_rect_start_x = -16
					purple_mouse_rect_start_y = -16
					purple_mouse_rect_width = 4
					purple_mouse_rect_height = 4
				}
			}

			// DELETE RECTANGLE -------------------------------------------------------------------------------------------------

			if editing_mode_active && brush_mode {
				if (rl.IsMouseButtonPressed(.RIGHT)) {

					// get current mouse position
					mouse_position: rl.Vector2
					mouse_position = rl.GetMousePosition()
					scale: i32 = 4

					if is_fullscreen {
						del_mouse_rect_start_x = i32(mouse_position.x) / scale
						del_mouse_rect_start_y = i32(mouse_position.y) / scale
					} else {
						del_mouse_rect_start_x = i32(mouse_position.x)
						del_mouse_rect_start_y = i32(mouse_position.y)
					}

				}

				// draws the orange rectangle
				if (rl.IsMouseButtonDown(.RIGHT)) {
					mouse_position: rl.Vector2
					mouse_position = rl.GetMousePosition()
					scale: i32 = 4

					if is_fullscreen {
						del_mouse_rect_width =
							(i32(mouse_position.x) / scale) - del_mouse_rect_start_x
						del_mouse_rect_height =
							(i32(mouse_position.y) / scale) - del_mouse_rect_start_y
					} else {
						del_mouse_rect_width = i32(mouse_position.x) - del_mouse_rect_start_x
						del_mouse_rect_height = i32(mouse_position.y) - del_mouse_rect_start_y
					}

				}

				//? --------------------------------------------------------------------------------
				//? BLACK RECTANGLE LINES
				if (rl.IsMouseButtonPressed(.RIGHT)) {

					// get current mouse position
					mouse_position: rl.Vector2
					mouse_position = rl.GetMousePosition()
					scale: i32 = 4

					if is_fullscreen {
						black_anchor_x = i32(mouse_position.x) / scale
						black_anchor_y = i32(mouse_position.y) / scale
					} else {
						black_anchor_x = i32(mouse_position.x)
						black_anchor_y = i32(mouse_position.y)
					}

				}

				// draws the black rectangle lines
				if (rl.IsMouseButtonDown(.RIGHT)) {
					mouse_position: rl.Vector2
					mouse_position = rl.GetMousePosition()
					scale: i32 = 4


					if is_fullscreen {
						black_mouse_rect_start_x = (i32(mouse_position.x) / scale)
						black_mouse_rect_start_y = black_anchor_y
						black_mouse_rect_width = black_anchor_x - (i32(mouse_position.x) / scale)
						black_mouse_rect_height = (i32(mouse_position.y) / scale) - black_anchor_y
					} else {
						black_mouse_rect_start_x = i32(mouse_position.x)
						black_mouse_rect_start_y = black_anchor_y
						black_mouse_rect_width = black_anchor_x - i32(mouse_position.x)
						black_mouse_rect_height = i32(mouse_position.y) - black_anchor_y
					}

				}
				//? --------------------------------------------------------------------------------
				//* --------------------------------------------------------------------------------
				//* LIME RECTANGLE LINES
				if (rl.IsMouseButtonPressed(.RIGHT)) {

					// get current mouse position
					mouse_position: rl.Vector2
					mouse_position = rl.GetMousePosition()
					scale: i32 = 4

					if is_fullscreen {
						lime_anchor_x = i32(mouse_position.x) / scale
						lime_anchor_y = i32(mouse_position.y) / scale
					} else {
						lime_anchor_x = i32(mouse_position.x)
						lime_anchor_y = i32(mouse_position.y)
					}

				}

				// draws the green rectangle lines
				if (rl.IsMouseButtonDown(.RIGHT)) {
					mouse_position: rl.Vector2
					mouse_position = rl.GetMousePosition()
					scale: i32 = 4


					if is_fullscreen {
						lime_mouse_rect_start_x = (i32(mouse_position.x) / scale)
						lime_mouse_rect_start_y = (i32(mouse_position.y) / scale)
						lime_mouse_rect_width = lime_anchor_x - (i32(mouse_position.x) / scale)
						lime_mouse_rect_height = lime_anchor_y - (i32(mouse_position.y) / scale)
					} else {
						lime_mouse_rect_start_x = i32(mouse_position.x)
						lime_mouse_rect_start_y = i32(mouse_position.y)
						lime_mouse_rect_width = lime_anchor_x - i32(mouse_position.x)
						lime_mouse_rect_height = lime_anchor_y - i32(mouse_position.y)
					}

				}
				//* --------------------------------------------------------------------------------
				// --------------------------------------------------------------------------------
				// GRAY RECTANGLE LINES
				if (rl.IsMouseButtonPressed(.RIGHT)) {

					// get current mouse position
					mouse_position: rl.Vector2
					mouse_position = rl.GetMousePosition()
					scale: i32 = 4

					if is_fullscreen {
						gray_anchor_x = i32(mouse_position.x) / scale
						gray_anchor_y = i32(mouse_position.y) / scale
					} else {
						gray_anchor_x = i32(mouse_position.x)
						gray_anchor_y = i32(mouse_position.y)
					}

				}

				// draws the gray rectangle lines
				if (rl.IsMouseButtonDown(.RIGHT)) {
					mouse_position: rl.Vector2
					mouse_position = rl.GetMousePosition()
					scale: i32 = 4


					if is_fullscreen {
						gray_mouse_rect_start_x = gray_anchor_x
						gray_mouse_rect_start_y = (i32(mouse_position.y) / scale)
						gray_mouse_rect_width = (i32(mouse_position.x) / scale) - gray_anchor_x
						gray_mouse_rect_height = gray_anchor_y - (i32(mouse_position.y) / scale)
					} else {
						gray_mouse_rect_start_x = gray_anchor_x
						gray_mouse_rect_start_y = i32(mouse_position.y)
						gray_mouse_rect_width = i32(mouse_position.x) - gray_anchor_x
						gray_mouse_rect_height = gray_anchor_y - i32(mouse_position.y)
					}

				}
				// --------------------------------------------------------------------------------


				// ---------------------------------------------------------------------------------
				// choose rect lines
				if (rl.IsMouseButtonPressed(.RIGHT)) {

					// get current mouse position
					mouse_position: rl.Vector2
					mouse_position = rl.GetMousePosition()
					scale: i32 = 4

					if is_fullscreen {
						del_starting_x = i32(mouse_position.x) / scale
						del_starting_y = i32(mouse_position.y) / scale
					} else {
						del_starting_x = i32(mouse_position.x)
						del_starting_y = i32(mouse_position.y)
					}

				}

				if (rl.IsMouseButtonDown(.RIGHT)) {
					mouse_position: rl.Vector2
					mouse_position = rl.GetMousePosition()
					scale: i32 = 4

					if is_fullscreen {
						if (i32(mouse_position.x) / scale) > del_starting_x &&
						   (i32(mouse_position.y) / scale) > del_starting_y {
							current_mouse_delete_rect = int(current_delete_rect.RED)
						} else if (i32(mouse_position.x) / scale) < del_starting_x &&
						   (i32(mouse_position.y) / scale) > del_starting_y {
							current_mouse_delete_rect = int(current_delete_rect.BLACK)
						} else if (i32(mouse_position.x) / scale) < del_starting_x &&
						   (i32(mouse_position.y) / scale) < del_starting_y {
							current_mouse_delete_rect = int(current_delete_rect.LIME)
						} else if (i32(mouse_position.x) / scale) > del_starting_x &&
						   (i32(mouse_position.y) / scale) < del_starting_y {
							current_mouse_delete_rect = int(current_delete_rect.GRAY)
						}
					} else {
						if i32(mouse_position.x) > del_starting_x &&
						   i32(mouse_position.y) > del_starting_y {
							current_mouse_delete_rect = int(current_delete_rect.RED)
						} else if i32(mouse_position.x) < del_starting_x &&
						   i32(mouse_position.y) > del_starting_y {
							current_mouse_delete_rect = int(current_delete_rect.BLACK)
						} else if i32(mouse_position.x) < del_starting_x &&
						   i32(mouse_position.y) < del_starting_y {
							current_mouse_delete_rect = int(current_delete_rect.LIME)
						} else if i32(mouse_position.x) > del_starting_x &&
						   i32(mouse_position.y) < del_starting_y {
							current_mouse_delete_rect = int(current_delete_rect.GRAY)
						}

					}

				}
				// ---------------------------------------------------------------------------------


				mouse_rect := rl.Rectangle {
					f32(del_mouse_rect_start_x),
					f32(del_mouse_rect_start_y),
					f32(del_mouse_rect_width),
					f32(del_mouse_rect_height),
				}

				black_mouse_rect := rl.Rectangle {
					f32(black_mouse_rect_start_x),
					f32(black_mouse_rect_start_y),
					f32(black_mouse_rect_width),
					f32(black_mouse_rect_height),
				}

				lime_mouse_rect := rl.Rectangle {
					f32(lime_mouse_rect_start_x),
					f32(lime_mouse_rect_start_y),
					f32(lime_mouse_rect_width),
					f32(lime_mouse_rect_height),
				}

				gray_mouse_rect := rl.Rectangle {
					f32(gray_mouse_rect_start_x),
					f32(gray_mouse_rect_start_y),
					f32(gray_mouse_rect_width),
					f32(gray_mouse_rect_height),
				}


				for &val in rectangle_array {
					collision: bool
					if current_mouse_delete_rect == int(current_delete_rect.RED) {
						collision = rl.CheckCollisionRecs(val.rect, mouse_rect)
					} else if current_mouse_delete_rect == int(current_delete_rect.BLACK) {
						collision = rl.CheckCollisionRecs(val.rect, black_mouse_rect)
					} else if current_mouse_delete_rect == int(current_delete_rect.LIME) {
						collision = rl.CheckCollisionRecs(val.rect, lime_mouse_rect)
					} else if current_mouse_delete_rect == int(current_delete_rect.GRAY) {
						collision = rl.CheckCollisionRecs(val.rect, gray_mouse_rect)
					}

					if collision {
						val.texture = blank_16
					}
				}


				// for &val in rectangle_array {
				// 	collision := rl.CheckCollisionRecs(val.rect, mouse_rect)
				// 	if collision {
				// 		val.texture = blank_16
				// 	}
				// }

				// reset when button is released
				if (rl.IsMouseButtonReleased(.RIGHT)) {
					del_mouse_rect_start_x = -16
					del_mouse_rect_start_y = -16
					del_mouse_rect_width = 4
					del_mouse_rect_height = 4

					black_mouse_rect_start_x = -16
					black_mouse_rect_start_y = -16
					black_mouse_rect_width = 4
					black_mouse_rect_height = 4

					lime_mouse_rect_start_x = -16
					lime_mouse_rect_start_y = -16
					lime_mouse_rect_width = 4
					lime_mouse_rect_height = 4

					gray_mouse_rect_start_x = -16
					gray_mouse_rect_start_y = -16
					gray_mouse_rect_width = 4
					gray_mouse_rect_height = 4
				}
			}
			// --------------------------------------------------------------------------------------------------------
		} //** MOUSE RECTANGLE LOGIC END ------------------------------------------------------------

		if editing_mode_active {
			if (rl.IsKeyDown(.LEFT_CONTROL)) && (rl.IsKeyPressed(.S)) {
				//save the current layout
				save_data_to_disk(rectangle_array[:])
				show_saving = true
				save_count = 60
			}
		}

		if select_mode {
			if (rl.IsMouseButtonPressed(.LEFT)) {
				image := rl.LoadImageFromTexture(target_default.texture)
				rl.ImageFlipVertical(&image)
				rl.ImageCrop(&image, {f32(tile_pos_x + 2), f32(tile_pos_y + 2), 16, 16})
				// rl.ImageCrop(&image, {0, 0, 16, 16})
				currently_selected_texture = rl.LoadTextureFromImage(image)

			} else if (rl.IsMouseButtonPressed(.RIGHT)) {
				currently_selected_texture = rl.LoadTexture("resources/16_by_16_square.png")
			}


		}

		if editing_mode_active {
			if (rl.IsKeyPressed(.ONE)) {
				show_tileset = !show_tileset
			}
		}

		// 
		// if editing_mode_active && brush_mode {
		// 	if (rl.IsMouseButtonPressed(.LEFT)) || (rl.IsMouseButtonDown(.LEFT)) {

		// 		// get current mouse position
		// 		mouse_position: rl.Vector2
		// 		mouse_position = rl.GetMousePosition()

		// 		// create the entity
		// 		block: Block
		// 		block.texture = white_square //! would be updated with the texture I'm clicking on in full editor
		// 		block.block_num, block.position = get_mouse_block_and_position(
		// 			is_fullscreen,
		// 			mouse_position.x,
		// 			mouse_position.y,
		// 		)

		// 		found_match := false
		// 		for val in entity_array {
		// 			if val.block_num == block.block_num {
		// 				found_match = true
		// 				break
		// 			}
		// 		}
		// 		// add the entity to the array if it's not already there
		// 		if found_match == false {
		// 			append(&entity_array, block)
		// 		}
		// 	}

		// 	// slice stuff //! come back to later
		// 	// if !slice.contains(entity_array[:], block){
		// 	//     append(&entity_array, block)
		// 	// }

		// 	if (rl.IsMouseButtonPressed(.RIGHT)) || (rl.IsMouseButtonDown(.RIGHT)) {
		// 		// get current mouse position
		// 		mouse_position: rl.Vector2
		// 		mouse_position = rl.GetMousePosition()

		// 		// get the block_num
		// 		block_num: int
		// 		block_num, _ = get_mouse_block_and_position(
		// 			is_fullscreen,
		// 			mouse_position.x,
		// 			mouse_position.y,
		// 		)

		// 		found_match := false
		// 		my_index: int
		// 		for val, i in entity_array {
		// 			if val.block_num == block_num {
		// 				found_match = true
		// 				my_index = i
		// 				break
		// 			}
		// 		}
		// 		// add the entity to the array if it's not already there
		// 		if found_match {
		// 			unordered_remove(&entity_array, my_index)
		// 		}
		// 	}
		// }
		//* ----------------------------------------------------------------------------------

		// ***  update  ***
		// saving icon logic
		if save_count - 1 > 0 {
			save_count -= 1
		} else {
			save_count = 0
			show_saving = false
		}
		// *---------------
		mouse_position_00: rl.Vector2
		mouse_position_00 = rl.GetMousePosition()
		tile_pos_x, tile_pos_y = get_tile_selector_position_b(
			is_fullscreen,
			mouse_position_00.x,
			mouse_position_00.y,
		)

		// ***  draw  ***
		rl.BeginDrawing()
		rl.BeginTextureMode(target_default)

		// -----------------------------------------------------------------------------------
		rl.DrawTexture(main_bg_grid, 0, 0, rl.WHITE)
		// draw_red_squares_in_corners()
		rl.DrawTexture(main_white_pixels, 0, 0, rl.WHITE)
		// rl.DrawFPS(25, 25) // show fps
		rl.DrawText(rl.TextFormat("FPS: %d", rl.GetFPS()), 25, 25, 20, rl.BLACK)
		print_mouse_position(is_fullscreen)
		rl.DrawText("RayLib function example", 250, 200, 20, rl.GREEN)
		rl.DrawText("'Alt + Enter' toggles RESIZE capability", 250, 250, 20, rl.GREEN)


		// --EDITING--------------------------------------------------------------------------
		if editing_mode_active {
			rl.DrawText("EDITING", screenWidth - 100, 16, 20, rl.RED)
			rl.DrawText(
				rl.TextFormat("brush_mode: %s", brush_mode ? "true" : "false"),
				screenWidth - 200,
				46,
				20,
				rl.RED,
			)
			rl.DrawText(
				rl.TextFormat("select_mode: %s", select_mode ? "true" : "false"),
				screenWidth - 200,
				76,
				20,
				rl.RED,
			)

		}
		// -----------------------------------------------------------------------------------

		// --SAVING---------------------------------------------------------------------------
		if show_saving {
			rl.DrawText("SAVING", screenWidth - 100, screenHeight - 32, 20, rl.RED)
		}

		// draw everything in the array
		// for val in entity_array {
		// 	rl.DrawTexture(val.texture, i32(val.position.x), i32(val.position.y), rl.WHITE)
		// }

		// opacity help: 255 = 100%, 192 = 75%, 128 = 50%, 64 = 25%
		for val in rectangle_array {
			rl.DrawTexture(val.texture, i32(val.rect.x), i32(val.rect.y), rl.WHITE)
		}
		// -----------------------------------------------------------------------------------

		// draw orange rectangle lines
		if current_mouse_rect == int(current_rect.ORANGE) {
			rl.DrawRectangleLines(
				mouse_rect_start_x,
				mouse_rect_start_y,
				mouse_rect_width,
				mouse_rect_height,
				rl.ORANGE,
			)
		}

		// draw blue rectangle lines
		if current_mouse_rect == int(current_rect.BLUE) {
			rl.DrawRectangleLines(
				blue_mouse_rect_start_x,
				blue_mouse_rect_start_y,
				blue_mouse_rect_width,
				blue_mouse_rect_height,
				rl.BLUE,
			)
		}

		// draw green rectangle lines
		if current_mouse_rect == int(current_rect.GREEN) {
			rl.DrawRectangleLines(
				green_mouse_rect_start_x,
				green_mouse_rect_start_y,
				green_mouse_rect_width,
				green_mouse_rect_height,
				rl.GREEN,
			)
		}

		// draw purple rectangle lines
		if current_mouse_rect == int(current_rect.PURPLE) {
			rl.DrawRectangleLines(
				purple_mouse_rect_start_x,
				purple_mouse_rect_start_y,
				purple_mouse_rect_width,
				purple_mouse_rect_height,
				rl.PURPLE,
			)
		}

		//? DELETE RECTANGLE LINES -------------------------------------------------------------------------------------------
		// draw rectangle
		if current_mouse_delete_rect == int(current_delete_rect.RED) {
			rl.DrawRectangleLines(
				del_mouse_rect_start_x,
				del_mouse_rect_start_y,
				del_mouse_rect_width,
				del_mouse_rect_height,
				rl.RED,
			)
		}

		// draw black rectangle lines
		if current_mouse_delete_rect == int(current_delete_rect.BLACK) {
			rl.DrawRectangleLines(
				black_mouse_rect_start_x,
				black_mouse_rect_start_y,
				black_mouse_rect_width,
				black_mouse_rect_height,
				rl.BLACK,
			)
		}

		// draw lime rectangle lines
		if current_mouse_delete_rect == int(current_delete_rect.LIME) {
			rl.DrawRectangleLines(
				lime_mouse_rect_start_x,
				lime_mouse_rect_start_y,
				lime_mouse_rect_width,
				lime_mouse_rect_height,
				rl.LIME,
			)
		}

		// draw gray rectangle lines
		if current_mouse_delete_rect == int(current_delete_rect.GRAY) {
			rl.DrawRectangleLines(
				gray_mouse_rect_start_x,
				gray_mouse_rect_start_y,
				gray_mouse_rect_width,
				gray_mouse_rect_height,
				rl.GRAY,
			)
		}
		//? ------------------------------------------------------------------------------------------------------------------
		// SELECT ICON -------------------------------------------------------------------------------------------------------

		// tileset
		if show_tileset {
			rl.DrawTexture(mini_tileset, 0, 0, rl.WHITE)
		}

		// tile selector
		if select_mode {
			rl.DrawTexture(tile_selector, tile_pos_x, tile_pos_y, rl.WHITE)
		}

		// -------------------------------------------------------------------------------------------------------------------
		// -----------------------------------------------------------------------------------

		// -----------------------------------------------------------------------------------

		rl.EndTextureMode()

		// draw the virtual screen on the actual one
		if is_fullscreen {
			rl.DrawTexturePro(
				target_default.texture,
				{0, 0, f32(target_default.texture.width), -f32(target_default.texture.height)},
				upscaled_resolution_rect,
				{0, 0},
				0,
				rl.WHITE,
			)
		} else {
			rl.DrawTexturePro(
				target_default.texture,
				{0, 0, f32(target_default.texture.width), -f32(target_default.texture.height)},
				original_resolution_rect,
				{0, 0},
				0,
				rl.WHITE,
			)
		}

		rl.EndDrawing()
	} // *********  end animation loop  **********

	//? - DEBUG STATEMENTS -------------------------------------------------------------------------
	//? --------------------------------------------------------------------------------------------

	// cleaning up memory at the end
	save_data_to_disk(rectangle_array[:])
	free_all(context.temp_allocator)

	// ***  quit  ***
	rl.CloseWindow() // cleanup


}

// ---------------------------------------------------------------------------------------------------------
// ooooooooo.                                                .o8                                          
// `888   `Y88.                                             "888                                          
//  888   .d88' oooo d8b  .ooooo.   .ooooo.   .ooooo.   .oooo888  oooo  oooo  oooo d8b  .ooooo.   .oooo.o 
//  888ooo88P'  `888""8P d88' `88b d88' `"Y8 d88' `88b d88' `888  `888  `888  `888""8P d88' `88b d88(  "8 
//  888          888     888   888 888       888ooo888 888   888   888   888   888     888ooo888 `"Y88b.  
//  888          888     888   888 888   .o8 888    .o 888   888   888   888   888     888    .o o.  )88b 
// o888o        d888b    `Y8bod8P' `Y8bod8P' `Y8bod8P' `Y8bod88P"  `V88V"V8P' d888b    `Y8bod8P' 8""888P' 
// --------------------------------------------------------------------------------------------------------- 

draw_red_squares_in_corners :: proc() {
	rl.DrawRectangleV({0, 0}, {16, 16}, rl.RED)
	rl.DrawRectangleV({screenWidth - 16, 0}, {16, 16}, rl.RED)
	rl.DrawRectangleV({0, screenHeight - 16}, {16, 16}, rl.RED)
	rl.DrawRectangleV({screenWidth - 16, screenHeight - 16}, {16, 16}, rl.RED)
}

// DrawText example
// rl.DrawText(rl.TextFormat("zoomMode = %d", zoomMode), 20, 50, 20, rl.DARKGRAY);

print_mouse_position :: proc(is_fullscreen: bool) {
	mouse_position: rl.Vector2
	mouse_position = rl.GetMousePosition()
	rl.DrawText(
		rl.TextFormat("mouse_position: %.02f, %.02f", mouse_position.x, mouse_position.y),
		25,
		55,
		20,
		rl.BLACK,
	)

	block := 0
	position: rl.Vector2
	block, position = get_mouse_block_and_position(
		is_fullscreen,
		mouse_position.x,
		mouse_position.y,
	)
	rl.DrawText(rl.TextFormat("Block: %d", block), 25, 85, 20, rl.BLACK)
	rl.DrawText(
		rl.TextFormat("Position: %.02f, %.02f", position.x, position.y),
		25,
		115,
		20,
		rl.BLACK,
	)
}

// this allocates memory, so it is freed in main after it's called
save_data_to_disk :: proc(data: []RectWithTexture) {
	if the_data, err := json.marshal(data, allocator = context.temp_allocator); err == nil {
		os.write_entire_file("data.json", the_data)
	}
}

define_mouse_rect :: proc(x: i32, y: i32) -> rl.Rectangle {
	mouse_position: rl.Vector2
	mouse_position = rl.GetMousePosition()

	if x < (i32(mouse_position.x)) && y < (i32(mouse_position.y)) {
		return {f32(x), f32(y), f32(mouse_rect_width), f32(mouse_rect_height)}
	} else if x > (i32(mouse_position.x)) && y < (i32(mouse_position.y)) {
		return {
			f32(x - i32(mouse_position.x)),
			f32(y),
			f32(mouse_rect_width),
			f32(mouse_rect_height),
		}
	}

	return {f32(x), f32(y), f32(mouse_rect_width), f32(mouse_rect_height)}
}


Block :: struct {
	texture:   rl.Texture2D,
	position:  rl.Vector2,
	block_num: int,
}

RectWithTexture :: struct {
	rect:    rl.Rectangle,
	texture: rl.Texture2D,
}

entity_array: [dynamic]Block

current_rect :: enum int {
	ORANGE = 1,
	BLUE   = 2,
	GREEN  = 3,
	PURPLE = 4,
}

current_delete_rect :: enum int {
	RED   = 1,
	BLACK = 2,
	LIME  = 3,
	GRAY  = 4,
}
