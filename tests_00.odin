package game

// import rl "vendor:raylib"

// // import "core:fmt"
// // print :: fmt.println

// main :: proc() {
//     // Initialization
//     //--------------------------------------------------------------------------------------
//     screenWidth  :: 800;
//     screenHeight :: 450;

//     rl.InitWindow(screenWidth, screenHeight, "raylib [core] example - input mouse wheel");

//     boxPositionY : i32 = screenHeight/2 - 40;
//     scrollSpeed := 4;            // Scrolling speed in pixels

//     rl.SetTargetFPS(60);               // Set our game to run at 60 frames-per-second
//     //--------------------------------------------------------------------------------------

//     // Main game loop
//     for !rl.WindowShouldClose()    // Detect window close button or ESC key
//     {
//         // Update
//         //----------------------------------------------------------------------------------
//         boxPositionY -= i32(rl.GetMouseWheelMove()* f32(scrollSpeed));
//         //----------------------------------------------------------------------------------

//         // Draw
//         //----------------------------------------------------------------------------------
//         rl.BeginDrawing();

//             rl.ClearBackground(rl.RAYWHITE);

//            rl.DrawRectangle(screenWidth/2 - 40, boxPositionY, 80, 80, rl.MAROON);

//             rl.DrawText("Use mouse wheel to move the cube up and down!", 10, 10, 20, rl.GRAY);
//             rl.DrawText(rl.TextFormat("Box position Y: %03i", boxPositionY), 10, 40, 20, rl.LIGHTGRAY);

//         rl.EndDrawing();
//         //----------------------------------------------------------------------------------
//     }

//     // De-Initialization
//     //--------------------------------------------------------------------------------------
//     rl.CloseWindow();        // Close window and OpenGL context
//     //--------------------------------------------------------------------------------------
// }

// package game

// import "core:fmt"
// import rl "vendor:raylib"
// import rlgl "vendor:raylib/rlgl"
// print :: fmt.println

// VAL_01 :: 5
// VAL_02 :: 7

// main :: proc() {
// 	// c := my_add(VAL_01, VAL_02)
// 	// print("This is c: ", c)

// 	// d := another_function(VAL_01, VAL_02)
// 	// print("This is d: ", d)

// 	my_array := [?]int{1, 2, 3, 4, 5}

// 	// for val in my_array[1:4] do print(val)

// 	for i in 0 ..= 10 do print(i)
// }
// my_add :: proc(x: int, y: int) -> int {
// 	return x + y
// }

// another_function :: proc(a: f32, b: f32) -> f32 {
// 	return a * b
// }
