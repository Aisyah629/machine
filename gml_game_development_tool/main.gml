// GML Game Development Tool - Main Engine Core
// Filename: main.gml

/// @description Initialize the game engine core
/// @param start_room {string} The first room to load
function gml_core_init(start_room) {
    // Set global engine state
    global.engine_running = true;
    global.engine_version = "1.0.0";
    global.asset_cache = ds_map_create();
    global.event_queue = ds_queue_create();
    global.debug_mode = false;
    global.profile_mode = false;

    // Initialize default rooms and objects
    if (room_exists(start_room)) {
        room_goto(start_room);
    } else {
        show_error("Start room does not exist: " + start_room, true);
    }

    // Start the main event loop
    game_start_event();
}

/// @description Main game loop handler
function game_start_event() {
    // Set application surface if needed
    if (surface_exists(application_surface)) {
        surface_resize(application_surface, display_get_width(), display_get_height());
    }

    // Initialize timer and delta tracking
    global.last_frame_time = 0;
    global.frame_delta = 0;
    global.fps_target = 60;
    global.fps_current = 60;

    // Start audio and input systems
    audio_master_volume(1.0);
    input_system_init();
}

/// @description Handle step event for all objects
function engine_step_event() {
    global.frame_delta = (current_time - global.last_frame_time) / 1000;
    global.last_frame_time = current_time;
    global.fps_current = 1.0 / global.frame_delta;

    // Process event queue
    while (!ds_queue_empty(global.event_queue)) {
        var evt = ds_queue_dequeue(global.event_queue);
        execute_event(evt);
    }

    // Update physics and collisions
    physics_update();
    collision_detection();
}

/// @description Handle draw event for rendering
function engine_draw_event() {
    // Clear application surface
    draw_clear_alpha(c_black, 1);

    // Draw background layer
    draw_background_layer(application_background_layer);

    // Draw all active objects
    draw_all_active_objects();

    // Draw UI/HUD elements
    draw_ui_overlay();

    // Debug overlay
    if (global.debug_mode) {
        draw_debug_overlay();
    }
}

/// @description Input system initialization
function input_system_init() {
    global.keys_down = 0;
    global.keys_pressed = 0;
    global.keys_released = 0;
    global.mouse_x = 0;
    global.mouse_y = 0;
    global.mouse_wheel = 0;

    // Register default key mappings
    global.key_map[ord("W")] = key_up;
    global.key_map[ord("A")] = key_left;
    global.key_map[ord("S")] = key_down;
    global.key_map[ord("D")] = key_right;
    global.key_map[ord(" ")] = key_jump;
}

/// @description Asset loading and caching
function asset_load(path) {
    if (ds_map_find_value(global.asset_cache, path) != undefined) {
        return ds_map_find_value(global.asset_cache, path);
    }

    var res_id = asset_get(path);
    if (res_id != -1) {
        ds_map_add(global.asset_cache, path, res_id);
        return res_id;
    }
    return -1;
}

/// @description Shutdown engine and clean up
function gml_core_shutdown() {
    global.engine_running = false;
    ds_map_destroy(global.asset_cache);
    ds_queue_destroy(global.event_queue);
    audio_master_volume(0);
    show_debug_message("Engine shut down successfully.");
}
