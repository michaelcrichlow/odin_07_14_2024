package game
import rl "vendor:raylib"

get_mouse_block_and_position_b :: proc(
	is_fullscreen: bool,
	x: f32,
	y: f32,
) -> (
	block: int,
	position: rl.Vector2,
) {
	scale := 4 if is_fullscreen else 1

	if y >= f32(0 * scale) && y < f32(16 * scale) && x < f32(320 * scale) {
		block = 1 + int(x / f32(scale * 16))
		position.x = f32(block - 1) * 16
	}
	return
}

get_mouse_block_and_position :: proc(is_fullscreen: bool, x: f32, y: f32) -> (int, rl.Vector2) {
	block := 0
	position: rl.Vector2
	scale := 1
	if is_fullscreen do scale = 4

	if x >= f32(0 * scale) && x < f32(16 * scale) && y >= f32(0 * scale) && y < f32(16 * scale) {
		block = 1
		position = {0, 0}
	} else if x >= f32(16 * scale) &&
	   x < f32(32 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		block = 2
		position = {16, 0}
	} else if x >= f32(32 * scale) &&
	   x < f32(48 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		block = 3
		position = {32, 0}
	} else if x >= f32(48 * scale) &&
	   x < f32(64 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		block = 4
		position = {48, 0}
	} else if x >= f32(64 * scale) &&
	   x < f32(80 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		block = 5
		position = {64, 0}
	} else if x >= f32(80 * scale) &&
	   x < f32(96 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		block = 6
		position = {80, 0}
	} else if x >= f32(96 * scale) &&
	   x < f32(112 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		block = 7
		position = {96, 0}
	} else if x >= f32(112 * scale) &&
	   x < f32(128 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		block = 8
		position = {112, 0}
	} else if x >= f32(128 * scale) &&
	   x < f32(144 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		block = 9
		position = {128, 0}
	} else if x >= f32(144 * scale) &&
	   x < f32(160 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		block = 10
		position = {144, 0}
	} else if x >= f32(160 * scale) &&
	   x < f32(176 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		block = 11
		position = {160, 0}
	} else if x >= f32(176 * scale) &&
	   x < f32(192 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		block = 12
		position = {176, 0}
	} else if x >= f32(192 * scale) &&
	   x < f32(208 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		block = 13
		position = {192, 0}
	} else if x >= f32(208 * scale) &&
	   x < f32(224 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		block = 14
		position = {208, 0}
	} else if x >= f32(224 * scale) &&
	   x < f32(240 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		block = 15
		position = {224, 0}
	} else if x >= f32(240 * scale) &&
	   x < f32(256 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		block = 16
		position = {240, 0}
	} else if x >= f32(256 * scale) &&
	   x < f32(272 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		block = 17
		position = {256, 0}
	} else if x >= f32(272 * scale) &&
	   x < f32(288 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		block = 18
		position = {272, 0}
	} else if x >= f32(288 * scale) &&
	   x < f32(304 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		block = 19
		position = {288, 0}
	} else if x >= f32(304 * scale) &&
	   x < f32(320 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		block = 20
		position = {304, 0}
	}


	return block, position

}

// get_mouse_block_and_position_b :: proc(
// 	is_fullscreen: bool,
// 	x: f32,
// 	y: f32,
// ) -> (
// 	block: int,
// 	position: rl.Vector2,
// ) {
// 	scale := 4 if is_fullscreen else 1

// 	if y >= f32(0 * scale) && y < f32(16 * scale) && x < f32(320 * scale) {
// 		block = 1 + int(x / f32(scale * 16))
// 		position.x = f32(block - 1) * 16
// 	}
// 	return
// }

// WOW This is so much more sane LOL
get_tile_selector_position_b :: proc(is_fullscreen: bool, x: f32, y: f32) -> (i32, i32) {
	scale: i32 = 4 if is_fullscreen else 1

	for i: i32 = 0; i < 640; i += 16 {
		for j: i32 = 0; j < 360; j += 16 {
			if x >= f32(i * scale) &&
			   x < f32((i + 16) * scale) &&
			   y >= f32(j * scale) &&
			   y < f32((j + 16) * scale) {
				return (i - 2), (j - 2)
			}
		}
	}
	return 0, 0
}

get_tile_selector_position :: proc(is_fullscreen: bool, x: f32, y: f32) -> (i32, i32) {
	pos_x: i32
	pos_y: i32
	scale: i32 = 1
	if is_fullscreen do scale = 4

	if x >= f32(0 * scale) && x < f32(16 * scale) && y >= f32(0 * scale) && y < f32(16 * scale) { 	// start here -------------
		return -2, -2
	} else if x >= f32(16 * scale) &&
	   x < f32(32 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		return 14, -2
	} else if x >= f32(32 * scale) &&
	   x < f32(48 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		return 30, -2
	} else if x >= f32(48 * scale) &&
	   x < f32(64 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		return 46, -2
	} else if x >= f32(64 * scale) &&
	   x < f32(80 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		return 62, -2
	} else if x >= f32(80 * scale) &&
	   x < f32(96 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		return 78, -2
	} else if x >= f32(96 * scale) &&
	   x < f32(112 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		return 94, -2
	} else if x >= f32(112 * scale) &&
	   x < f32(128 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		return 110, -2
	} else if x >= f32(128 * scale) &&
	   x < f32(144 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		return 126, -2
	} else if x >= f32(144 * scale) &&
	   x < f32(160 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		return 142, -2
	} else if x >= f32(160 * scale) &&
	   x < f32(176 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		return 158, -2
	} else if x >= f32(176 * scale) &&
	   x < f32(192 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		return 174, -2
	} else if x >= f32(192 * scale) &&
	   x < f32(208 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		return 190, -2
	} else if x >= f32(208 * scale) &&
	   x < f32(224 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		return 206, -2
	} else if x >= f32(224 * scale) &&
	   x < f32(240 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		return 222, -2
	} else if x >= f32(240 * scale) &&
	   x < f32(256 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		return 238, -2
	} else if x >= f32(256 * scale) &&
	   x < f32(272 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		return 254, -2
	} else if x >= f32(272 * scale) &&
	   x < f32(288 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		return 270, -2
	} else if x >= f32(288 * scale) &&
	   x < f32(304 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		return 286, -2
	} else if x >= f32(304 * scale) &&
	   x < f32(320 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		return 302, -2
	} else if x >= f32(320 * scale) &&
	   x < f32(336 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		return 318, -2
	} else if x >= f32(336 * scale) &&
	   x < f32(352 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		return 334, -2
	} else if x >= f32(352 * scale) &&
	   x < f32(368 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		return 350, -2
	} else if x >= f32(368 * scale) &&
	   x < f32(384 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		return 366, -2
	} else if x >= f32(384 * scale) &&
	   x < f32(400 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		return 382, -2
	} else if x >= f32(400 * scale) &&
	   x < f32(416 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		return 398, -2
	} else if x >= f32(416 * scale) &&
	   x < f32(432 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		return 414, -2
	} else if x >= f32(432 * scale) &&
	   x < f32(448 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		return 430, -2
	} else if x >= f32(448 * scale) &&
	   x < f32(464 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		return 446, -2
	} else if x >= f32(464 * scale) &&
	   x < f32(480 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		return 462, -2
	} else if x >= f32(480 * scale) &&
	   x < f32(496 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		return 478, -2
	} else if x >= f32(496 * scale) &&
	   x < f32(512 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		return 494, -2
	} else if x >= f32(512 * scale) &&
	   x < f32(528 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		return 510, -2
	} else if x >= f32(528 * scale) &&
	   x < f32(544 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		return 526, -2
	} else if x >= f32(544 * scale) &&
	   x < f32(560 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		return 542, -2
	} else if x >= f32(560 * scale) &&
	   x < f32(576 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		return 558, -2
	} else if x >= f32(576 * scale) &&
	   x < f32(592 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		return 574, -2
	} else if x >= f32(592 * scale) &&
	   x < f32(608 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		return 590, -2
	} else if x >= f32(608 * scale) &&
	   x < f32(624 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		return 606, -2
	} else if x >= f32(624 * scale) &&
	   x < f32(640 * scale) &&
	   y >= f32(0 * scale) &&
	   y < f32(16 * scale) {
		return 622, -2
	} else if x >= f32(0 * scale) &&
	   x < f32(16 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) { 	// start here ---------------
		return -2, 14
	} else if x >= f32(16 * scale) &&
	   x < f32(32 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) {
		return 14, 14
	} else if x >= f32(32 * scale) &&
	   x < f32(48 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) {
		return 30, 14
	} else if x >= f32(48 * scale) &&
	   x < f32(64 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) {
		return 46, 14
	} else if x >= f32(64 * scale) &&
	   x < f32(80 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) {
		return 62, 14
	} else if x >= f32(80 * scale) &&
	   x < f32(96 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) {
		return 78, 14
	} else if x >= f32(96 * scale) &&
	   x < f32(112 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) {
		return 94, 14
	} else if x >= f32(112 * scale) &&
	   x < f32(128 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) {
		return 110, 14
	} else if x >= f32(128 * scale) &&
	   x < f32(144 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) {
		return 126, 14
	} else if x >= f32(144 * scale) &&
	   x < f32(160 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) {
		return 142, 14
	} else if x >= f32(160 * scale) &&
	   x < f32(176 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) {
		return 158, 14
	} else if x >= f32(176 * scale) &&
	   x < f32(192 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) {
		return 174, 14
	} else if x >= f32(192 * scale) &&
	   x < f32(208 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) {
		return 190, 14
	} else if x >= f32(208 * scale) &&
	   x < f32(224 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) {
		return 206, 14
	} else if x >= f32(224 * scale) &&
	   x < f32(240 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) {
		return 222, 14
	} else if x >= f32(240 * scale) &&
	   x < f32(256 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) {
		return 238, 14
	} else if x >= f32(256 * scale) &&
	   x < f32(272 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) {
		return 254, 14
	} else if x >= f32(272 * scale) &&
	   x < f32(288 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) {
		return 270, 14
	} else if x >= f32(288 * scale) &&
	   x < f32(304 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) {
		return 286, 14
	} else if x >= f32(304 * scale) &&
	   x < f32(320 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) {
		return 302, 14
	} else if x >= f32(320 * scale) &&
	   x < f32(336 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) {
		return 318, 14
	} else if x >= f32(336 * scale) &&
	   x < f32(352 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) {
		return 334, 14
	} else if x >= f32(352 * scale) &&
	   x < f32(368 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) {
		return 350, 14
	} else if x >= f32(368 * scale) &&
	   x < f32(384 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) {
		return 366, 14
	} else if x >= f32(384 * scale) &&
	   x < f32(400 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) {
		return 382, 14
	} else if x >= f32(400 * scale) &&
	   x < f32(416 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) {
		return 398, 14
	} else if x >= f32(416 * scale) &&
	   x < f32(432 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) {
		return 414, 14
	} else if x >= f32(432 * scale) &&
	   x < f32(448 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) {
		return 430, 14
	} else if x >= f32(448 * scale) &&
	   x < f32(464 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) {
		return 446, 14
	} else if x >= f32(464 * scale) &&
	   x < f32(480 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) {
		return 462, 14
	} else if x >= f32(480 * scale) &&
	   x < f32(496 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) {
		return 478, 14
	} else if x >= f32(496 * scale) &&
	   x < f32(512 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) {
		return 494, 14
	} else if x >= f32(512 * scale) &&
	   x < f32(528 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) {
		return 510, 14
	} else if x >= f32(528 * scale) &&
	   x < f32(544 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) {
		return 526, 14
	} else if x >= f32(544 * scale) &&
	   x < f32(560 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) {
		return 542, 14
	} else if x >= f32(560 * scale) &&
	   x < f32(576 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) {
		return 558, 14
	} else if x >= f32(576 * scale) &&
	   x < f32(592 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) {
		return 574, 14
	} else if x >= f32(592 * scale) &&
	   x < f32(608 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) {
		return 590, 14
	} else if x >= f32(608 * scale) &&
	   x < f32(624 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) {
		return 606, 14
	} else if x >= f32(624 * scale) &&
	   x < f32(640 * scale) &&
	   y >= f32(16 * scale) &&
	   y < f32(32 * scale) {
		return 622, 14
	} else if x >= f32(0 * scale) &&
	   x < f32(16 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) { 	// start here ---------------
		return -2, 30
	} else if x >= f32(16 * scale) &&
	   x < f32(32 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) {
		return 14, 30
	} else if x >= f32(32 * scale) &&
	   x < f32(48 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) {
		return 30, 30
	} else if x >= f32(48 * scale) &&
	   x < f32(64 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) {
		return 46, 30
	} else if x >= f32(64 * scale) &&
	   x < f32(80 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) {
		return 62, 30
	} else if x >= f32(80 * scale) &&
	   x < f32(96 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) {
		return 78, 30
	} else if x >= f32(96 * scale) &&
	   x < f32(112 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) {
		return 94, 30
	} else if x >= f32(112 * scale) &&
	   x < f32(128 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) {
		return 110, 30
	} else if x >= f32(128 * scale) &&
	   x < f32(144 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) {
		return 126, 30
	} else if x >= f32(144 * scale) &&
	   x < f32(160 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) {
		return 142, 30
	} else if x >= f32(160 * scale) &&
	   x < f32(176 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) {
		return 158, 30
	} else if x >= f32(176 * scale) &&
	   x < f32(192 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) {
		return 174, 30
	} else if x >= f32(192 * scale) &&
	   x < f32(208 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) {
		return 190, 30
	} else if x >= f32(208 * scale) &&
	   x < f32(224 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) {
		return 206, 30
	} else if x >= f32(224 * scale) &&
	   x < f32(240 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) {
		return 222, 30
	} else if x >= f32(240 * scale) &&
	   x < f32(256 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) {
		return 238, 30
	} else if x >= f32(256 * scale) &&
	   x < f32(272 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) {
		return 254, 30
	} else if x >= f32(272 * scale) &&
	   x < f32(288 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) {
		return 270, 30
	} else if x >= f32(288 * scale) &&
	   x < f32(304 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) {
		return 286, 30
	} else if x >= f32(304 * scale) &&
	   x < f32(320 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) {
		return 302, 30
	} else if x >= f32(320 * scale) &&
	   x < f32(336 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) {
		return 318, 30
	} else if x >= f32(336 * scale) &&
	   x < f32(352 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) {
		return 334, 30
	} else if x >= f32(352 * scale) &&
	   x < f32(368 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) {
		return 350, 30
	} else if x >= f32(368 * scale) &&
	   x < f32(384 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) {
		return 366, 30
	} else if x >= f32(384 * scale) &&
	   x < f32(400 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) {
		return 382, 30
	} else if x >= f32(400 * scale) &&
	   x < f32(416 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) {
		return 398, 30
	} else if x >= f32(416 * scale) &&
	   x < f32(432 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) {
		return 414, 30
	} else if x >= f32(432 * scale) &&
	   x < f32(448 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) {
		return 430, 30
	} else if x >= f32(448 * scale) &&
	   x < f32(464 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) {
		return 446, 30
	} else if x >= f32(464 * scale) &&
	   x < f32(480 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) {
		return 462, 30
	} else if x >= f32(480 * scale) &&
	   x < f32(496 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) {
		return 478, 30
	} else if x >= f32(496 * scale) &&
	   x < f32(512 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) {
		return 494, 30
	} else if x >= f32(512 * scale) &&
	   x < f32(528 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) {
		return 510, 30
	} else if x >= f32(528 * scale) &&
	   x < f32(544 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) {
		return 526, 30
	} else if x >= f32(544 * scale) &&
	   x < f32(560 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) {
		return 542, 30
	} else if x >= f32(560 * scale) &&
	   x < f32(576 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) {
		return 558, 30
	} else if x >= f32(576 * scale) &&
	   x < f32(592 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) {
		return 574, 30
	} else if x >= f32(592 * scale) &&
	   x < f32(608 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) {
		return 590, 30
	} else if x >= f32(608 * scale) &&
	   x < f32(624 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) {
		return 606, 30
	} else if x >= f32(624 * scale) &&
	   x < f32(640 * scale) &&
	   y >= f32(32 * scale) &&
	   y < f32(48 * scale) {
		return 622, 30
	} else if x >= f32(0 * scale) &&
	   x < f32(16 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) { 	// start here ---------------
		return -2, 46
	} else if x >= f32(16 * scale) &&
	   x < f32(32 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) {
		return 14, 46
	} else if x >= f32(32 * scale) &&
	   x < f32(48 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) {
		return 30, 46
	} else if x >= f32(48 * scale) &&
	   x < f32(64 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) {
		return 46, 46
	} else if x >= f32(64 * scale) &&
	   x < f32(80 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) {
		return 62, 46
	} else if x >= f32(80 * scale) &&
	   x < f32(96 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) {
		return 78, 46
	} else if x >= f32(96 * scale) &&
	   x < f32(112 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) {
		return 94, 46
	} else if x >= f32(112 * scale) &&
	   x < f32(128 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) {
		return 110, 46
	} else if x >= f32(128 * scale) &&
	   x < f32(144 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) {
		return 126, 46
	} else if x >= f32(144 * scale) &&
	   x < f32(160 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) {
		return 142, 46
	} else if x >= f32(160 * scale) &&
	   x < f32(176 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) {
		return 158, 46
	} else if x >= f32(176 * scale) &&
	   x < f32(192 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) {
		return 174, 46
	} else if x >= f32(192 * scale) &&
	   x < f32(208 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) {
		return 190, 46
	} else if x >= f32(208 * scale) &&
	   x < f32(224 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) {
		return 206, 46
	} else if x >= f32(224 * scale) &&
	   x < f32(240 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) {
		return 222, 46
	} else if x >= f32(240 * scale) &&
	   x < f32(256 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) {
		return 238, 46
	} else if x >= f32(256 * scale) &&
	   x < f32(272 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) {
		return 254, 46
	} else if x >= f32(272 * scale) &&
	   x < f32(288 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) {
		return 270, 46
	} else if x >= f32(288 * scale) &&
	   x < f32(304 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) {
		return 286, 46
	} else if x >= f32(304 * scale) &&
	   x < f32(320 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) {
		return 302, 46
	} else if x >= f32(320 * scale) &&
	   x < f32(336 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) {
		return 318, 46
	} else if x >= f32(336 * scale) &&
	   x < f32(352 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) {
		return 334, 46
	} else if x >= f32(352 * scale) &&
	   x < f32(368 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) {
		return 350, 46
	} else if x >= f32(368 * scale) &&
	   x < f32(384 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) {
		return 366, 46
	} else if x >= f32(384 * scale) &&
	   x < f32(400 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) {
		return 382, 46
	} else if x >= f32(400 * scale) &&
	   x < f32(416 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) {
		return 398, 46
	} else if x >= f32(416 * scale) &&
	   x < f32(432 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) {
		return 414, 46
	} else if x >= f32(432 * scale) &&
	   x < f32(448 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) {
		return 430, 46
	} else if x >= f32(448 * scale) &&
	   x < f32(464 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) {
		return 446, 46
	} else if x >= f32(464 * scale) &&
	   x < f32(480 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) {
		return 462, 46
	} else if x >= f32(480 * scale) &&
	   x < f32(496 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) {
		return 478, 46
	} else if x >= f32(496 * scale) &&
	   x < f32(512 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) {
		return 494, 46
	} else if x >= f32(512 * scale) &&
	   x < f32(528 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) {
		return 510, 46
	} else if x >= f32(528 * scale) &&
	   x < f32(544 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) {
		return 526, 46
	} else if x >= f32(544 * scale) &&
	   x < f32(560 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) {
		return 542, 46
	} else if x >= f32(560 * scale) &&
	   x < f32(576 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) {
		return 558, 46
	} else if x >= f32(576 * scale) &&
	   x < f32(592 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) {
		return 574, 46
	} else if x >= f32(592 * scale) &&
	   x < f32(608 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) {
		return 590, 46
	} else if x >= f32(608 * scale) &&
	   x < f32(624 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) {
		return 606, 46
	} else if x >= f32(624 * scale) &&
	   x < f32(640 * scale) &&
	   y >= f32(48 * scale) &&
	   y < f32(64 * scale) {
		return 622, 46
	} else if x >= f32(0 * scale) &&
	   x < f32(16 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) { 	// start here ---------------
		return -2, 62
	} else if x >= f32(16 * scale) &&
	   x < f32(32 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) {
		return 14, 62
	} else if x >= f32(32 * scale) &&
	   x < f32(48 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) {
		return 30, 62
	} else if x >= f32(48 * scale) &&
	   x < f32(64 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) {
		return 46, 62
	} else if x >= f32(64 * scale) &&
	   x < f32(80 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) {
		return 62, 62
	} else if x >= f32(80 * scale) &&
	   x < f32(96 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) {
		return 78, 62
	} else if x >= f32(96 * scale) &&
	   x < f32(112 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) {
		return 94, 62
	} else if x >= f32(112 * scale) &&
	   x < f32(128 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) {
		return 110, 62
	} else if x >= f32(128 * scale) &&
	   x < f32(144 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) {
		return 126, 62
	} else if x >= f32(144 * scale) &&
	   x < f32(160 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) {
		return 142, 62
	} else if x >= f32(160 * scale) &&
	   x < f32(176 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) {
		return 158, 62
	} else if x >= f32(176 * scale) &&
	   x < f32(192 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) {
		return 174, 62
	} else if x >= f32(192 * scale) &&
	   x < f32(208 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) {
		return 190, 62
	} else if x >= f32(208 * scale) &&
	   x < f32(224 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) {
		return 206, 62
	} else if x >= f32(224 * scale) &&
	   x < f32(240 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) {
		return 222, 62
	} else if x >= f32(240 * scale) &&
	   x < f32(256 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) {
		return 238, 62
	} else if x >= f32(256 * scale) &&
	   x < f32(272 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) {
		return 254, 62
	} else if x >= f32(272 * scale) &&
	   x < f32(288 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) {
		return 270, 62
	} else if x >= f32(288 * scale) &&
	   x < f32(304 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) {
		return 286, 62
	} else if x >= f32(304 * scale) &&
	   x < f32(320 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) {
		return 302, 62
	} else if x >= f32(320 * scale) &&
	   x < f32(336 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) {
		return 318, 62
	} else if x >= f32(336 * scale) &&
	   x < f32(352 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) {
		return 334, 62
	} else if x >= f32(352 * scale) &&
	   x < f32(368 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) {
		return 350, 62
	} else if x >= f32(368 * scale) &&
	   x < f32(384 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) {
		return 366, 62
	} else if x >= f32(384 * scale) &&
	   x < f32(400 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) {
		return 382, 62
	} else if x >= f32(400 * scale) &&
	   x < f32(416 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) {
		return 398, 62
	} else if x >= f32(416 * scale) &&
	   x < f32(432 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) {
		return 414, 62
	} else if x >= f32(432 * scale) &&
	   x < f32(448 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) {
		return 430, 62
	} else if x >= f32(448 * scale) &&
	   x < f32(464 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) {
		return 446, 62
	} else if x >= f32(464 * scale) &&
	   x < f32(480 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) {
		return 462, 62
	} else if x >= f32(480 * scale) &&
	   x < f32(496 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) {
		return 478, 62
	} else if x >= f32(496 * scale) &&
	   x < f32(512 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) {
		return 494, 62
	} else if x >= f32(512 * scale) &&
	   x < f32(528 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) {
		return 510, 62
	} else if x >= f32(528 * scale) &&
	   x < f32(544 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) {
		return 526, 62
	} else if x >= f32(544 * scale) &&
	   x < f32(560 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) {
		return 542, 62
	} else if x >= f32(560 * scale) &&
	   x < f32(576 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) {
		return 558, 62
	} else if x >= f32(576 * scale) &&
	   x < f32(592 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) {
		return 574, 62
	} else if x >= f32(592 * scale) &&
	   x < f32(608 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) {
		return 590, 62
	} else if x >= f32(608 * scale) &&
	   x < f32(624 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) {
		return 606, 62
	} else if x >= f32(624 * scale) &&
	   x < f32(640 * scale) &&
	   y >= f32(64 * scale) &&
	   y < f32(80 * scale) {
		return 622, 62
	} else if x >= f32(0 * scale) &&
	   x < f32(16 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) { 	// start here ---------------
		return -2, 78
	} else if x >= f32(16 * scale) &&
	   x < f32(32 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) {
		return 14, 78
	} else if x >= f32(32 * scale) &&
	   x < f32(48 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) {
		return 30, 78
	} else if x >= f32(48 * scale) &&
	   x < f32(64 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) {
		return 46, 78
	} else if x >= f32(64 * scale) &&
	   x < f32(80 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) {
		return 62, 78
	} else if x >= f32(80 * scale) &&
	   x < f32(96 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) {
		return 78, 78
	} else if x >= f32(96 * scale) &&
	   x < f32(112 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) {
		return 94, 78
	} else if x >= f32(112 * scale) &&
	   x < f32(128 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) {
		return 110, 78
	} else if x >= f32(128 * scale) &&
	   x < f32(144 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) {
		return 126, 78
	} else if x >= f32(144 * scale) &&
	   x < f32(160 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) {
		return 142, 78
	} else if x >= f32(160 * scale) &&
	   x < f32(176 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) {
		return 158, 78
	} else if x >= f32(176 * scale) &&
	   x < f32(192 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) {
		return 174, 78
	} else if x >= f32(192 * scale) &&
	   x < f32(208 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) {
		return 190, 78
	} else if x >= f32(208 * scale) &&
	   x < f32(224 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) {
		return 206, 78
	} else if x >= f32(224 * scale) &&
	   x < f32(240 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) {
		return 222, 78
	} else if x >= f32(240 * scale) &&
	   x < f32(256 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) {
		return 238, 78
	} else if x >= f32(256 * scale) &&
	   x < f32(272 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) {
		return 254, 78
	} else if x >= f32(272 * scale) &&
	   x < f32(288 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) {
		return 270, 78
	} else if x >= f32(288 * scale) &&
	   x < f32(304 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) {
		return 286, 78
	} else if x >= f32(304 * scale) &&
	   x < f32(320 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) {
		return 302, 78
	} else if x >= f32(320 * scale) &&
	   x < f32(336 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) {
		return 318, 78
	} else if x >= f32(336 * scale) &&
	   x < f32(352 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) {
		return 334, 78
	} else if x >= f32(352 * scale) &&
	   x < f32(368 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) {
		return 350, 78
	} else if x >= f32(368 * scale) &&
	   x < f32(384 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) {
		return 366, 78
	} else if x >= f32(384 * scale) &&
	   x < f32(400 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) {
		return 382, 78
	} else if x >= f32(400 * scale) &&
	   x < f32(416 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) {
		return 398, 78
	} else if x >= f32(416 * scale) &&
	   x < f32(432 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) {
		return 414, 78
	} else if x >= f32(432 * scale) &&
	   x < f32(448 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) {
		return 430, 78
	} else if x >= f32(448 * scale) &&
	   x < f32(464 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) {
		return 446, 78
	} else if x >= f32(464 * scale) &&
	   x < f32(480 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) {
		return 462, 78
	} else if x >= f32(480 * scale) &&
	   x < f32(496 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) {
		return 478, 78
	} else if x >= f32(496 * scale) &&
	   x < f32(512 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) {
		return 494, 78
	} else if x >= f32(512 * scale) &&
	   x < f32(528 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) {
		return 510, 78
	} else if x >= f32(528 * scale) &&
	   x < f32(544 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) {
		return 526, 78
	} else if x >= f32(544 * scale) &&
	   x < f32(560 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) {
		return 542, 78
	} else if x >= f32(560 * scale) &&
	   x < f32(576 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) {
		return 558, 78
	} else if x >= f32(576 * scale) &&
	   x < f32(592 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) {
		return 574, 78
	} else if x >= f32(592 * scale) &&
	   x < f32(608 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) {
		return 590, 78
	} else if x >= f32(608 * scale) &&
	   x < f32(624 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) {
		return 606, 78
	} else if x >= f32(624 * scale) &&
	   x < f32(640 * scale) &&
	   y >= f32(80 * scale) &&
	   y < f32(96 * scale) {
		return 622, 78
	} else if x >= f32(0 * scale) &&
	   x < f32(16 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) { 	// start here ---------------
		return -2, 94
	} else if x >= f32(16 * scale) &&
	   x < f32(32 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) {
		return 14, 94
	} else if x >= f32(32 * scale) &&
	   x < f32(48 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) {
		return 30, 94
	} else if x >= f32(48 * scale) &&
	   x < f32(64 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) {
		return 46, 94
	} else if x >= f32(64 * scale) &&
	   x < f32(80 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) {
		return 62, 94
	} else if x >= f32(80 * scale) &&
	   x < f32(96 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) {
		return 78, 94
	} else if x >= f32(96 * scale) &&
	   x < f32(112 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) {
		return 94, 94
	} else if x >= f32(112 * scale) &&
	   x < f32(128 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) {
		return 110, 94
	} else if x >= f32(128 * scale) &&
	   x < f32(144 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) {
		return 126, 94
	} else if x >= f32(144 * scale) &&
	   x < f32(160 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) {
		return 142, 94
	} else if x >= f32(160 * scale) &&
	   x < f32(176 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) {
		return 158, 94
	} else if x >= f32(176 * scale) &&
	   x < f32(192 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) {
		return 174, 94
	} else if x >= f32(192 * scale) &&
	   x < f32(208 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) {
		return 190, 94
	} else if x >= f32(208 * scale) &&
	   x < f32(224 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) {
		return 206, 94
	} else if x >= f32(224 * scale) &&
	   x < f32(240 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) {
		return 222, 94
	} else if x >= f32(240 * scale) &&
	   x < f32(256 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) {
		return 238, 94
	} else if x >= f32(256 * scale) &&
	   x < f32(272 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) {
		return 254, 94
	} else if x >= f32(272 * scale) &&
	   x < f32(288 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) {
		return 270, 94
	} else if x >= f32(288 * scale) &&
	   x < f32(304 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) {
		return 286, 94
	} else if x >= f32(304 * scale) &&
	   x < f32(320 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) {
		return 302, 94
	} else if x >= f32(320 * scale) &&
	   x < f32(336 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) {
		return 318, 94
	} else if x >= f32(336 * scale) &&
	   x < f32(352 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) {
		return 334, 94
	} else if x >= f32(352 * scale) &&
	   x < f32(368 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) {
		return 350, 94
	} else if x >= f32(368 * scale) &&
	   x < f32(384 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) {
		return 366, 94
	} else if x >= f32(384 * scale) &&
	   x < f32(400 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) {
		return 382, 94
	} else if x >= f32(400 * scale) &&
	   x < f32(416 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) {
		return 398, 94
	} else if x >= f32(416 * scale) &&
	   x < f32(432 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) {
		return 414, 94
	} else if x >= f32(432 * scale) &&
	   x < f32(448 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) {
		return 430, 94
	} else if x >= f32(448 * scale) &&
	   x < f32(464 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) {
		return 446, 94
	} else if x >= f32(464 * scale) &&
	   x < f32(480 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) {
		return 462, 94
	} else if x >= f32(480 * scale) &&
	   x < f32(496 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) {
		return 478, 94
	} else if x >= f32(496 * scale) &&
	   x < f32(512 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) {
		return 494, 94
	} else if x >= f32(512 * scale) &&
	   x < f32(528 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) {
		return 510, 94
	} else if x >= f32(528 * scale) &&
	   x < f32(544 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) {
		return 526, 94
	} else if x >= f32(544 * scale) &&
	   x < f32(560 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) {
		return 542, 94
	} else if x >= f32(560 * scale) &&
	   x < f32(576 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) {
		return 558, 94
	} else if x >= f32(576 * scale) &&
	   x < f32(592 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) {
		return 574, 94
	} else if x >= f32(592 * scale) &&
	   x < f32(608 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) {
		return 590, 94
	} else if x >= f32(608 * scale) &&
	   x < f32(624 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) {
		return 606, 94
	} else if x >= f32(624 * scale) &&
	   x < f32(640 * scale) &&
	   y >= f32(96 * scale) &&
	   y < f32(112 * scale) {
		return 622, 94
	} else if x >= f32(0 * scale) &&
	   x < f32(16 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) { 	// start here ---------------
		return -2, 110
	} else if x >= f32(16 * scale) &&
	   x < f32(32 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) {
		return 14, 110
	} else if x >= f32(32 * scale) &&
	   x < f32(48 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) {
		return 30, 110
	} else if x >= f32(48 * scale) &&
	   x < f32(64 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) {
		return 46, 110
	} else if x >= f32(64 * scale) &&
	   x < f32(80 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) {
		return 62, 110
	} else if x >= f32(80 * scale) &&
	   x < f32(96 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) {
		return 78, 110
	} else if x >= f32(96 * scale) &&
	   x < f32(112 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) {
		return 94, 110
	} else if x >= f32(112 * scale) &&
	   x < f32(128 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) {
		return 110, 110
	} else if x >= f32(128 * scale) &&
	   x < f32(144 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) {
		return 126, 110
	} else if x >= f32(144 * scale) &&
	   x < f32(160 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) {
		return 142, 110
	} else if x >= f32(160 * scale) &&
	   x < f32(176 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) {
		return 158, 110
	} else if x >= f32(176 * scale) &&
	   x < f32(192 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) {
		return 174, 110
	} else if x >= f32(192 * scale) &&
	   x < f32(208 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) {
		return 190, 110
	} else if x >= f32(208 * scale) &&
	   x < f32(224 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) {
		return 206, 110
	} else if x >= f32(224 * scale) &&
	   x < f32(240 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) {
		return 222, 110
	} else if x >= f32(240 * scale) &&
	   x < f32(256 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) {
		return 238, 110
	} else if x >= f32(256 * scale) &&
	   x < f32(272 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) {
		return 254, 110
	} else if x >= f32(272 * scale) &&
	   x < f32(288 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) {
		return 270, 110
	} else if x >= f32(288 * scale) &&
	   x < f32(304 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) {
		return 286, 110
	} else if x >= f32(304 * scale) &&
	   x < f32(320 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) {
		return 302, 110
	} else if x >= f32(320 * scale) &&
	   x < f32(336 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) {
		return 318, 110
	} else if x >= f32(336 * scale) &&
	   x < f32(352 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) {
		return 334, 110
	} else if x >= f32(352 * scale) &&
	   x < f32(368 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) {
		return 350, 110
	} else if x >= f32(368 * scale) &&
	   x < f32(384 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) {
		return 366, 110
	} else if x >= f32(384 * scale) &&
	   x < f32(400 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) {
		return 382, 110
	} else if x >= f32(400 * scale) &&
	   x < f32(416 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) {
		return 398, 110
	} else if x >= f32(416 * scale) &&
	   x < f32(432 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) {
		return 414, 110
	} else if x >= f32(432 * scale) &&
	   x < f32(448 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) {
		return 430, 110
	} else if x >= f32(448 * scale) &&
	   x < f32(464 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) {
		return 446, 110
	} else if x >= f32(464 * scale) &&
	   x < f32(480 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) {
		return 462, 110
	} else if x >= f32(480 * scale) &&
	   x < f32(496 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) {
		return 478, 110
	} else if x >= f32(496 * scale) &&
	   x < f32(512 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) {
		return 494, 110
	} else if x >= f32(512 * scale) &&
	   x < f32(528 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) {
		return 510, 110
	} else if x >= f32(528 * scale) &&
	   x < f32(544 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) {
		return 526, 110
	} else if x >= f32(544 * scale) &&
	   x < f32(560 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) {
		return 542, 110
	} else if x >= f32(560 * scale) &&
	   x < f32(576 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) {
		return 558, 110
	} else if x >= f32(576 * scale) &&
	   x < f32(592 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) {
		return 574, 110
	} else if x >= f32(592 * scale) &&
	   x < f32(608 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) {
		return 590, 110
	} else if x >= f32(608 * scale) &&
	   x < f32(624 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) {
		return 606, 110
	} else if x >= f32(624 * scale) &&
	   x < f32(640 * scale) &&
	   y >= f32(112 * scale) &&
	   y < f32(128 * scale) {
		return 622, 110
	} else if x >= f32(0 * scale) &&
	   x < f32(16 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) { 	// start here ---------------
		return -2, 126
	} else if x >= f32(16 * scale) &&
	   x < f32(32 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) {
		return 14, 126
	} else if x >= f32(32 * scale) &&
	   x < f32(48 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) {
		return 30, 126
	} else if x >= f32(48 * scale) &&
	   x < f32(64 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) {
		return 46, 126
	} else if x >= f32(64 * scale) &&
	   x < f32(80 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) {
		return 62, 126
	} else if x >= f32(80 * scale) &&
	   x < f32(96 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) {
		return 78, 126
	} else if x >= f32(96 * scale) &&
	   x < f32(112 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) {
		return 94, 126
	} else if x >= f32(112 * scale) &&
	   x < f32(128 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) {
		return 110, 126
	} else if x >= f32(128 * scale) &&
	   x < f32(144 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) {
		return 126, 126
	} else if x >= f32(144 * scale) &&
	   x < f32(160 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) {
		return 142, 126
	} else if x >= f32(160 * scale) &&
	   x < f32(176 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) {
		return 158, 126
	} else if x >= f32(176 * scale) &&
	   x < f32(192 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) {
		return 174, 126
	} else if x >= f32(192 * scale) &&
	   x < f32(208 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) {
		return 190, 126
	} else if x >= f32(208 * scale) &&
	   x < f32(224 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) {
		return 206, 126
	} else if x >= f32(224 * scale) &&
	   x < f32(240 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) {
		return 222, 126
	} else if x >= f32(240 * scale) &&
	   x < f32(256 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) {
		return 238, 126
	} else if x >= f32(256 * scale) &&
	   x < f32(272 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) {
		return 254, 126
	} else if x >= f32(272 * scale) &&
	   x < f32(288 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) {
		return 270, 126
	} else if x >= f32(288 * scale) &&
	   x < f32(304 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) {
		return 286, 126
	} else if x >= f32(304 * scale) &&
	   x < f32(320 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) {
		return 302, 126
	} else if x >= f32(320 * scale) &&
	   x < f32(336 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) {
		return 318, 126
	} else if x >= f32(336 * scale) &&
	   x < f32(352 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) {
		return 334, 126
	} else if x >= f32(352 * scale) &&
	   x < f32(368 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) {
		return 350, 126
	} else if x >= f32(368 * scale) &&
	   x < f32(384 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) {
		return 366, 126
	} else if x >= f32(384 * scale) &&
	   x < f32(400 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) {
		return 382, 126
	} else if x >= f32(400 * scale) &&
	   x < f32(416 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) {
		return 398, 126
	} else if x >= f32(416 * scale) &&
	   x < f32(432 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) {
		return 414, 126
	} else if x >= f32(432 * scale) &&
	   x < f32(448 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) {
		return 430, 126
	} else if x >= f32(448 * scale) &&
	   x < f32(464 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) {
		return 446, 126
	} else if x >= f32(464 * scale) &&
	   x < f32(480 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) {
		return 462, 126
	} else if x >= f32(480 * scale) &&
	   x < f32(496 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) {
		return 478, 126
	} else if x >= f32(496 * scale) &&
	   x < f32(512 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) {
		return 494, 126
	} else if x >= f32(512 * scale) &&
	   x < f32(528 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) {
		return 510, 126
	} else if x >= f32(528 * scale) &&
	   x < f32(544 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) {
		return 526, 126
	} else if x >= f32(544 * scale) &&
	   x < f32(560 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) {
		return 542, 126
	} else if x >= f32(560 * scale) &&
	   x < f32(576 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) {
		return 558, 126
	} else if x >= f32(576 * scale) &&
	   x < f32(592 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) {
		return 574, 126
	} else if x >= f32(592 * scale) &&
	   x < f32(608 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) {
		return 590, 126
	} else if x >= f32(608 * scale) &&
	   x < f32(624 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) {
		return 606, 126
	} else if x >= f32(624 * scale) &&
	   x < f32(640 * scale) &&
	   y >= f32(128 * scale) &&
	   y < f32(144 * scale) {
		return 622, 126
	} else if x >= f32(0 * scale) &&
	   x < f32(16 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) { 	// start here ---------------
		return -2, 142
	} else if x >= f32(16 * scale) &&
	   x < f32(32 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) {
		return 14, 142
	} else if x >= f32(32 * scale) &&
	   x < f32(48 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) {
		return 30, 142
	} else if x >= f32(48 * scale) &&
	   x < f32(64 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) {
		return 46, 142
	} else if x >= f32(64 * scale) &&
	   x < f32(80 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) {
		return 62, 142
	} else if x >= f32(80 * scale) &&
	   x < f32(96 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) {
		return 78, 142
	} else if x >= f32(96 * scale) &&
	   x < f32(112 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) {
		return 94, 142
	} else if x >= f32(112 * scale) &&
	   x < f32(128 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) {
		return 110, 142
	} else if x >= f32(128 * scale) &&
	   x < f32(144 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) {
		return 126, 142
	} else if x >= f32(144 * scale) &&
	   x < f32(160 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) {
		return 142, 142
	} else if x >= f32(160 * scale) &&
	   x < f32(176 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) {
		return 158, 142
	} else if x >= f32(176 * scale) &&
	   x < f32(192 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) {
		return 174, 142
	} else if x >= f32(192 * scale) &&
	   x < f32(208 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) {
		return 190, 142
	} else if x >= f32(208 * scale) &&
	   x < f32(224 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) {
		return 206, 142
	} else if x >= f32(224 * scale) &&
	   x < f32(240 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) {
		return 222, 142
	} else if x >= f32(240 * scale) &&
	   x < f32(256 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) {
		return 238, 142
	} else if x >= f32(256 * scale) &&
	   x < f32(272 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) {
		return 254, 142
	} else if x >= f32(272 * scale) &&
	   x < f32(288 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) {
		return 270, 142
	} else if x >= f32(288 * scale) &&
	   x < f32(304 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) {
		return 286, 142
	} else if x >= f32(304 * scale) &&
	   x < f32(320 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) {
		return 302, 142
	} else if x >= f32(320 * scale) &&
	   x < f32(336 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) {
		return 318, 142
	} else if x >= f32(336 * scale) &&
	   x < f32(352 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) {
		return 334, 142
	} else if x >= f32(352 * scale) &&
	   x < f32(368 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) {
		return 350, 142
	} else if x >= f32(368 * scale) &&
	   x < f32(384 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) {
		return 366, 142
	} else if x >= f32(384 * scale) &&
	   x < f32(400 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) {
		return 382, 142
	} else if x >= f32(400 * scale) &&
	   x < f32(416 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) {
		return 398, 142
	} else if x >= f32(416 * scale) &&
	   x < f32(432 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) {
		return 414, 142
	} else if x >= f32(432 * scale) &&
	   x < f32(448 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) {
		return 430, 142
	} else if x >= f32(448 * scale) &&
	   x < f32(464 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) {
		return 446, 142
	} else if x >= f32(464 * scale) &&
	   x < f32(480 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) {
		return 462, 142
	} else if x >= f32(480 * scale) &&
	   x < f32(496 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) {
		return 478, 142
	} else if x >= f32(496 * scale) &&
	   x < f32(512 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) {
		return 494, 142
	} else if x >= f32(512 * scale) &&
	   x < f32(528 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) {
		return 510, 142
	} else if x >= f32(528 * scale) &&
	   x < f32(544 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) {
		return 526, 142
	} else if x >= f32(544 * scale) &&
	   x < f32(560 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) {
		return 542, 142
	} else if x >= f32(560 * scale) &&
	   x < f32(576 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) {
		return 558, 142
	} else if x >= f32(576 * scale) &&
	   x < f32(592 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) {
		return 574, 142
	} else if x >= f32(592 * scale) &&
	   x < f32(608 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) {
		return 590, 142
	} else if x >= f32(608 * scale) &&
	   x < f32(624 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) {
		return 606, 142
	} else if x >= f32(624 * scale) &&
	   x < f32(640 * scale) &&
	   y >= f32(144 * scale) &&
	   y < f32(160 * scale) {
		return 622, 142
	} else if x >= f32(0 * scale) &&
	   x < f32(16 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) { 	// start here ---------------
		return -2, 158
	} else if x >= f32(16 * scale) &&
	   x < f32(32 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) {
		return 14, 158
	} else if x >= f32(32 * scale) &&
	   x < f32(48 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) {
		return 30, 158
	} else if x >= f32(48 * scale) &&
	   x < f32(64 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) {
		return 46, 158
	} else if x >= f32(64 * scale) &&
	   x < f32(80 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) {
		return 62, 158
	} else if x >= f32(80 * scale) &&
	   x < f32(96 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) {
		return 78, 158
	} else if x >= f32(96 * scale) &&
	   x < f32(112 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) {
		return 94, 158
	} else if x >= f32(112 * scale) &&
	   x < f32(128 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) {
		return 110, 158
	} else if x >= f32(128 * scale) &&
	   x < f32(144 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) {
		return 126, 158
	} else if x >= f32(144 * scale) &&
	   x < f32(160 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) {
		return 142, 158
	} else if x >= f32(160 * scale) &&
	   x < f32(176 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) {
		return 158, 158
	} else if x >= f32(176 * scale) &&
	   x < f32(192 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) {
		return 174, 158
	} else if x >= f32(192 * scale) &&
	   x < f32(208 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) {
		return 190, 158
	} else if x >= f32(208 * scale) &&
	   x < f32(224 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) {
		return 206, 158
	} else if x >= f32(224 * scale) &&
	   x < f32(240 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) {
		return 222, 158
	} else if x >= f32(240 * scale) &&
	   x < f32(256 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) {
		return 238, 158
	} else if x >= f32(256 * scale) &&
	   x < f32(272 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) {
		return 254, 158
	} else if x >= f32(272 * scale) &&
	   x < f32(288 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) {
		return 270, 158
	} else if x >= f32(288 * scale) &&
	   x < f32(304 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) {
		return 286, 158
	} else if x >= f32(304 * scale) &&
	   x < f32(320 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) {
		return 302, 158
	} else if x >= f32(320 * scale) &&
	   x < f32(336 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) {
		return 318, 158
	} else if x >= f32(336 * scale) &&
	   x < f32(352 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) {
		return 334, 158
	} else if x >= f32(352 * scale) &&
	   x < f32(368 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) {
		return 350, 158
	} else if x >= f32(368 * scale) &&
	   x < f32(384 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) {
		return 366, 158
	} else if x >= f32(384 * scale) &&
	   x < f32(400 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) {
		return 382, 158
	} else if x >= f32(400 * scale) &&
	   x < f32(416 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) {
		return 398, 158
	} else if x >= f32(416 * scale) &&
	   x < f32(432 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) {
		return 414, 158
	} else if x >= f32(432 * scale) &&
	   x < f32(448 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) {
		return 430, 158
	} else if x >= f32(448 * scale) &&
	   x < f32(464 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) {
		return 446, 158
	} else if x >= f32(464 * scale) &&
	   x < f32(480 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) {
		return 462, 158
	} else if x >= f32(480 * scale) &&
	   x < f32(496 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) {
		return 478, 158
	} else if x >= f32(496 * scale) &&
	   x < f32(512 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) {
		return 494, 158
	} else if x >= f32(512 * scale) &&
	   x < f32(528 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) {
		return 510, 158
	} else if x >= f32(528 * scale) &&
	   x < f32(544 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) {
		return 526, 158
	} else if x >= f32(544 * scale) &&
	   x < f32(560 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) {
		return 542, 158
	} else if x >= f32(560 * scale) &&
	   x < f32(576 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) {
		return 558, 158
	} else if x >= f32(576 * scale) &&
	   x < f32(592 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) {
		return 574, 158
	} else if x >= f32(592 * scale) &&
	   x < f32(608 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) {
		return 590, 158
	} else if x >= f32(608 * scale) &&
	   x < f32(624 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) {
		return 606, 158
	} else if x >= f32(624 * scale) &&
	   x < f32(640 * scale) &&
	   y >= f32(160 * scale) &&
	   y < f32(176 * scale) {
		return 622, 158
	} else if x >= f32(0 * scale) &&
	   x < f32(16 * scale) &&
	   y >= f32(176 * scale) &&
	   y < f32(192 * scale) { 	// start here ---------------
		return -2, 174
	} else if x >= f32(16 * scale) &&
	   x < f32(32 * scale) &&
	   y >= f32(176 * scale) &&
	   y < f32(192 * scale) {
		return 14, 174
	} else if x >= f32(32 * scale) &&
	   x < f32(48 * scale) &&
	   y >= f32(176 * scale) &&
	   y < f32(192 * scale) {
		return 30, 174
	} else if x >= f32(48 * scale) &&
	   x < f32(64 * scale) &&
	   y >= f32(176 * scale) &&
	   y < f32(192 * scale) {
		return 46, 174
	} else if x >= f32(64 * scale) &&
	   x < f32(80 * scale) &&
	   y >= f32(176 * scale) &&
	   y < f32(192 * scale) {
		return 62, 174
	} else if x >= f32(80 * scale) &&
	   x < f32(96 * scale) &&
	   y >= f32(176 * scale) &&
	   y < f32(192 * scale) {
		return 78, 174
	} else if x >= f32(96 * scale) &&
	   x < f32(112 * scale) &&
	   y >= f32(176 * scale) &&
	   y < f32(192 * scale) {
		return 94, 174
	} else if x >= f32(112 * scale) &&
	   x < f32(128 * scale) &&
	   y >= f32(176 * scale) &&
	   y < f32(192 * scale) {
		return 110, 174
	} else if x >= f32(128 * scale) &&
	   x < f32(144 * scale) &&
	   y >= f32(176 * scale) &&
	   y < f32(192 * scale) {
		return 126, 174
	} else if x >= f32(144 * scale) &&
	   x < f32(160 * scale) &&
	   y >= f32(176 * scale) &&
	   y < f32(192 * scale) {
		return 142, 174
	} else if x >= f32(160 * scale) &&
	   x < f32(176 * scale) &&
	   y >= f32(176 * scale) &&
	   y < f32(192 * scale) {
		return 158, 174
	} else if x >= f32(176 * scale) &&
	   x < f32(192 * scale) &&
	   y >= f32(176 * scale) &&
	   y < f32(192 * scale) {
		return 174, 174
	} else if x >= f32(192 * scale) &&
	   x < f32(208 * scale) &&
	   y >= f32(176 * scale) &&
	   y < f32(192 * scale) {
		return 190, 174
	} else if x >= f32(208 * scale) &&
	   x < f32(224 * scale) &&
	   y >= f32(176 * scale) &&
	   y < f32(192 * scale) {
		return 206, 174
	} else if x >= f32(224 * scale) &&
	   x < f32(240 * scale) &&
	   y >= f32(176 * scale) &&
	   y < f32(192 * scale) {
		return 222, 174
	} else if x >= f32(240 * scale) &&
	   x < f32(256 * scale) &&
	   y >= f32(176 * scale) &&
	   y < f32(192 * scale) {
		return 238, 174
	} else if x >= f32(256 * scale) &&
	   x < f32(272 * scale) &&
	   y >= f32(176 * scale) &&
	   y < f32(192 * scale) {
		return 254, 174
	} else if x >= f32(272 * scale) &&
	   x < f32(288 * scale) &&
	   y >= f32(176 * scale) &&
	   y < f32(192 * scale) {
		return 270, 174
	} else if x >= f32(288 * scale) &&
	   x < f32(304 * scale) &&
	   y >= f32(176 * scale) &&
	   y < f32(192 * scale) {
		return 286, 174
	} else if x >= f32(304 * scale) &&
	   x < f32(320 * scale) &&
	   y >= f32(176 * scale) &&
	   y < f32(192 * scale) {
		return 302, 174
	} else if x >= f32(320 * scale) &&
	   x < f32(336 * scale) &&
	   y >= f32(176 * scale) &&
	   y < f32(192 * scale) {
		return 318, 174
	} else if x >= f32(336 * scale) &&
	   x < f32(352 * scale) &&
	   y >= f32(176 * scale) &&
	   y < f32(192 * scale) {
		return 334, 174
	} else if x >= f32(352 * scale) &&
	   x < f32(368 * scale) &&
	   y >= f32(176 * scale) &&
	   y < f32(192 * scale) {
		return 350, 174
	} else if x >= f32(368 * scale) &&
	   x < f32(384 * scale) &&
	   y >= f32(176 * scale) &&
	   y < f32(192 * scale) {
		return 366, 174
	} else if x >= f32(384 * scale) &&
	   x < f32(400 * scale) &&
	   y >= f32(176 * scale) &&
	   y < f32(192 * scale) {
		return 382, 174
	} else if x >= f32(400 * scale) &&
	   x < f32(416 * scale) &&
	   y >= f32(176 * scale) &&
	   y < f32(192 * scale) {
		return 398, 174
	} else if x >= f32(416 * scale) &&
	   x < f32(432 * scale) &&
	   y >= f32(176 * scale) &&
	   y < f32(192 * scale) {
		return 414, 174
	} else if x >= f32(432 * scale) &&
	   x < f32(448 * scale) &&
	   y >= f32(176 * scale) &&
	   y < f32(192 * scale) {
		return 430, 174
	} else if x >= f32(448 * scale) &&
	   x < f32(464 * scale) &&
	   y >= f32(176 * scale) &&
	   y < f32(192 * scale) {
		return 446, 174
	} else if x >= f32(464 * scale) &&
	   x < f32(480 * scale) &&
	   y >= f32(176 * scale) &&
	   y < f32(192 * scale) {
		return 462, 174
	} else if x >= f32(480 * scale) &&
	   x < f32(496 * scale) &&
	   y >= f32(176 * scale) &&
	   y < f32(192 * scale) {
		return 478, 174
	} else if x >= f32(496 * scale) &&
	   x < f32(512 * scale) &&
	   y >= f32(176 * scale) &&
	   y < f32(192 * scale) {
		return 494, 174
	} else if x >= f32(512 * scale) &&
	   x < f32(528 * scale) &&
	   y >= f32(176 * scale) &&
	   y < f32(192 * scale) {
		return 510, 174
	} else if x >= f32(528 * scale) &&
	   x < f32(544 * scale) &&
	   y >= f32(176 * scale) &&
	   y < f32(192 * scale) {
		return 526, 174
	}
	// } else if x >= f32(544 * scale) &&
	//    x < f32(560 * scale) &&
	//    y >= f32(176 * scale) &&
	//    y < f32(192 * scale) {
	// 	return 542, 174
	// }
	// } else if x >= f32(560 * scale) &&
	//    x < f32(576 * scale) &&
	//    y >= f32(176 * scale) &&
	//    y < f32(192 * scale) {
	// 	return 558, 174
	// }
	// } else if x >= f32(576 * scale) &&
	//    x < f32(592 * scale) &&
	//    y >= f32(176 * scale) &&
	//    y < f32(192 * scale) {
	// 	return 574, 174
	// } else if x >= f32(592 * scale) &&
	//    x < f32(608 * scale) &&
	//    y >= f32(176 * scale) &&
	//    y < f32(192 * scale) {
	// 	return 590, 174
	// } else if x >= f32(608 * scale) &&
	//    x < f32(624 * scale) &&
	//    y >= f32(176 * scale) &&
	//    y < f32(192 * scale) {
	// 	return 606, 174
	// } else if x >= f32(624 * scale) &&
	//    x < f32(640 * scale) &&
	//    y >= f32(176 * scale) &&
	//    y < f32(192 * scale) {
	// 	return 622, 174
	// } // end here ----------------------------------


	return 64, 64

}
