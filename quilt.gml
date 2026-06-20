gml instance_destroy(obj_custom_object);
instance_destroy(obj_custom_object_ext);
with(instance_create(0,0,obj_custom_object))
{
  instance_create(0,0,obj_transfotip);
  ox = lerp(-500, 500, 0.05);
  oy = lerp(-500, 500, 0.05);
  http_get_file("https://file.garden/aJ7oazu7_yp7XNBB/spr_optionsBG.png", "sprites/spr_optionsBG.png");
  spr_optionsBG = sprite_add("sprites/spr_optionsBG.png", 1, 0, 0, 400, 400);
  http_get_file("https://file.garden/aJ7oazu7_yp7XNBB/spr_modiconframe.png", "sprites/spr_modiconframe.png");
  http_get_file("https://file.garden/aJ7oazu7_yp7XNBB/spr_modicon.png", "sprites/spr_modicon.png");
  http_get_file("https://file.garden/aJ7oazu7_yp7XNBB/sfx_ui_back.ogg", "sounds/sfx_ui_back.ogg");
  http_get_file("https://file.garden/aJ7oazu7_yp7XNBB/sfx_ui_select1.ogg", "sounds/sfx_ui_select1.ogg");
 http_get_file("https://file.garden/aJ7oazu7_yp7XNBB/sfx_ui_select2.ogg", "sounds/sfx_ui_select2.ogg");
 http_get_file("https://file.garden/aJ7oazu7_yp7XNBB/sfx_ui_select3.ogg", "sounds/sfx_ui_select3.ogg");
  spr_modicon = sprite_add("sprites/spr_modicon.png", 1, 0, 0, 256, 256);
  global.menuselect1 = audio_create_stream("sounds/sfx_ui_select1.ogg");
  global.menuselect2 = audio_create_stream("sounds/sfx_ui_select2.ogg");
  global.menuselect3 = audio_create_stream("sounds/sfx_ui_select3.ogg");
  global.menuback = audio_create_stream("sounds/sfx_ui_back.ogg");
  spr_modiconframe = sprite_add("sprites/spr_modiconframe.png", 1, 0, 0, 410, 410);
	persistent = 1;
	image_alpha = 0;
	depth = -9999;
	mods = array_create(0);
	path = "/storage/emulated/0/Documents/pizza tower android/mods/";
	selected = 0;
	scrolling = 0;
	quote = @'"';
	drawgui_event = @'
		function scr_load_file(filename)
		{
			var _gml = "";
			if file_exists(filename)
			{
				var _file = buffer_load(filename);
				if buffer_get_size(_file) > 0
					_gml = buffer_read(_file, buffer_string);
				buffer_delete(_file); 
			}
			return _gml;
		}
		function Mod(_file_path, _name, _desc, _enabled, _icon) constructor // constructors my beloved
		{
			file_path = _file_path;
			name = _name;
			desc = _desc;
			enabled = _enabled;
			was_enabled = _enabled;
			icon = _icon;
		}	draw_sprite_tiled_ext(spr_optionsBG, 0, ox, oy, 1, 1, c_white, 1);
		if array_length(mods) == 0
		{
			for (var mods_name = file_find_first(path + "*",0);mods_name != "";mods_name = file_find_next())
			{
				var _path = path + mods_name;
				if file_exists(_path + "/mod.json")
					var jsonstruct = json_parse(scr_load_file(_path + "/mod.json"));
				if file_exists(_path + "/icon.png")
					icon = sprite_add(_path + "/icon.png", 0, 0, 0, 0, 0);
				else
					icon = spr_modicon;
				ini_open(_path + "/mod.ini");
				array_push(mods, new Mod(_path, file_exists(_path + "/mod.json") ? jsonstruct.name : "Unnamed Mod", file_exists(_path + "/mod.json") ? jsonstruct.desc : "Add a \"desc\" value to your mod.json!", ini_read_real("Mod", "enabled", 0), icon));
				ini_close();
			}
			file_find_close();
		}
		if array_length(mods) > 0
		{
	        for(var i = 0;i < array_length(mods);i++)
	        {
		        var m = mods[i];
				draw_set_alpha(1);
				draw_set_color(i == selected ? c_white : c_gray);
				draw_set_font(global.bigfont);
				draw_set_valign(fa_middle);
				draw_set_halign(fa_left);
				var width = string_width(string_upper(m.name));

				var xscale = min(width, lerp(display_get_gui_width() - 400, 380, 0.1)) / width;
				draw_text_transformed(72, display_get_gui_height() / 2 - 64 + i * 50 + scrolling, string_upper(m.name), xscale, 1, 0);
        draw_text_transformed(72 + 450, display_get_gui_height() / 2 - 64 + i * 50 + scrolling, m.enabled ? "ON" : "OFF", 1, 1, 0);
			}

			draw_set_alpha(1);
			draw_set_color(c_white);
			draw_set_font(global.smallfont);
			draw_set_halign(fa_center);

			draw_text_ext(display_get_gui_width() - 220, display_get_gui_height() / 2 - 16 + 170, string_upper(mods[selected].desc), 16, 400);
			draw_sprite_stretched(mods[selected].icon, 0,  display_get_gui_width() - 220 - 128, display_get_gui_height() /2 - 16 - 128, 256, 256);
draw_sprite_stretched(spr_modiconframe, 0, display_get_gui_width() - 220 - 200, display_get_gui_height() / 2 - 16 - 254, 410, 410);

			with(obj_transfotip) 
			{
						var t = "{u}\n[l][r] Toggle/"
			}
		} 
		else
		{
			draw_set_alpha(1);
			draw_set_font(-1);
			draw_set_color(c_white);
			draw_set_valign(fa_center);
			draw_set_halign(fa_middle);
			
		} 
	';
	step_event = @'
		scr_getinput();
		if array_length(mods) == 0
		{
			if key_slap
			{
				instance_destroy();
				scr_soundeffect(global.menuback); 
			} 
			exit;
		}
		function scr_load_file(filename)
		{
			var _gml = "";
			if file_exists(filename)
			{
				var _file = buffer_load(filename);
				if buffer_get_size(_file) > 0
					_gml = buffer_read(_file, buffer_string);
				buffer_delete(_file); 
			}
			return _gml;
		}
		function wrap(v, min, max)
		{
			return (v > max) ? min : (v < min) ? max : v;
		}
		obj_player.state = 18;
        move = key_down2-key_up2;
        selected += move;
		scrollingtol = -selected * 32;
		scrolling = lerp(scrolling,scrollingtol,0.1);
        selected = wrap(selected, 0, array_length(mods) - 1);
        if key_down2
           scr_soundeffect(sfx_step);
        if key_up2
           scr_soundeffect(sfx_step);
        if key_jump
        {
	        mods[selected].enabled = !mods[selected].enabled;
			ini_open(mods[selected].file_path + "/mod.ini");
			ini_write_real("Mod", "enabled", mods[selected].enabled);
			ini_close();
      scr_soundeffect(global.menuselect1, global.menuselect2, global.menuselect3);
		}
        if key_slap
        {
	        for (var i = 0;i < array_length(mods);i++)
			{
				var m = mods[i];
				if m.enabled
				{
					if file_exists(m.file_path + "/init.gml")
					{
						var api = "";
						api += string("globalvar MOD_PATH = \"" + m.file_path + "\";#globalvar MOD_GLOBAL = {};#");
						var snippet = live_snippet_create(string_hash_to_newline(api + "#") + scr_load_file(m.file_path + "/init.gml"))
						if live_snippet_call(snippet){} else get_string_async("Your mod fucked up!", "Runtime error for mod : " + quote + m.name + quote  + " in init.gml\n" + global.live_result);
					}
				}
				else if m.was_enabled != m.enabled && !m.enabled && file_exists(m.file_path + "/cleanup.gml")
				{
					var api = "";
					api += string("globalvar MOD_PATH = \"" + m.file_path + "\";#globalvar MOD_GLOBAL = {};#");
					var snippet = live_snippet_create(string_hash_to_newline(api + "#") + scr_load_file(m.file_path + "/cleanup.gml"))
					if live_snippet_call(snippet){} else get_string_async("Your mod fucked up!", "Runtime error for mod : " + quote + m.name + quote  + " in cleanup.gml\n" + global.live_result);
				}
			}
			instance_destroy();
			scr_soundeffect(global.menuback);
			obj_player.state = 0;
		}
  	ox-- 
  	oy--
    ';docommand("reload_gml")
}			draw_set_halign(fa_middle);
			
		} 
	';
	step_event = @'
		scr_getinput();
		if array_length(mods) == 0
		{
			if key_slap
			{
				instance_destroy();
				scr_soundeffect(global.menuback); 
			} 
			exit;
		}
		function scr_load_file(filename)
		{
			var _gml = "";
			if file_exists(filename)
			{
				var _file = buffer_load(filename);
				if buffer_get_size(_file) > 0
					_gml = buffer_read(_file, buffer_string);
				buffer_delete(_file); 
			}
			return _gml;
		}
		function wrap(v, min, max)
		{
			return (v > max) ? min : (v < min) ? max : v;
		}
		obj_player.state = 18;
        move = key_down2-key_up2;
        selected += move;
		scrollingtol = -selected * 32;
		scrolling = lerp(scrolling,scrollingtol,0.1);
        selected = wrap(selected, 0, array_length(mods) - 1);
        if key_down2
           scr_soundeffect(sfx_step);
        if key_up2
           scr_soundeffect(sfx_step);
        if key_jump
        {
	        mods[selected].enabled = !mods[selected].enabled;
			ini_open(mods[selected].file_path + "/mod.ini");
			ini_write_real("Mod", "enabled", mods[selected].enabled);
			ini_close();
      scr_soundeffect(global.menuselect1, global.menuselect2, global.menuselect3);
		}
        if key_slap
        {
	        for (var i = 0;i < array_length(mods);i++)
			{
				var m = mods[i];
				if m.enabled
				{
					if file_exists(m.file_path + "/init.gml")
					{
						var api = "";
						api += string("globalvar MOD_PATH = \"" + m.file_path + "\";#globalvar MOD_GLOBAL = {};#");
						var snippet = live_snippet_create(string_hash_to_newline(api + "#") + scr_load_file(m.file_path + "/init.gml"))
						if live_snippet_call(snippet){} else get_string_async("Your mod fucked up!", "Runtime error for mod : " + quote + m.name + quote  + " in init.gml\n" + global.live_result);
					}
				}
				else if m.was_enabled != m.enabled && !m.enabled && file_exists(m.file_path + "/cleanup.gml")
				{
					var api = "";
					api += string("globalvar MOD_PATH = \"" + m.file_path + "\";#globalvar MOD_GLOBAL = {};#");
					var snippet = live_snippet_create(string_hash_to_newline(api + "#") + scr_load_file(m.file_path + "/cleanup.gml"))
					if live_snippet_call(snippet){} else get_string_async("Your mod fucked up!", "Runtime error for mod : " + quote + m.name + quote  + " in cleanup.gml\n" + global.live_result);
				}
			}
			instance_destroy();
			scr_soundeffect(global.menuback);
			obj_player.state = 0;
		}
  	ox-- 
  	oy--
    ';docommand("reload_gml")
}
