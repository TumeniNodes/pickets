-- [Mod]Pickets [pickets] [Ver. 0.1]
-- Copyright (c) 2015 - 2026 TumeniNodes

pickets = {}

local function handle_manual_rotation(pos, node, user, mode, new_param2)
	if mode == 1 then
		minetest.swap_node(pos, {name = node.name, param2 = new_param2})
		return true
	end
	return false
end

function pickets.register_picket_nodes(subname, groups, single_texture, description, sounds)
	local node_groups = table.copy(groups)
	node_groups.picket = 1

	local images = {single_texture, single_texture, single_texture, single_texture, single_texture, single_texture}

	-- Straight Picket
	minetest.register_node(":pickets:picket" .. subname, {
		description = description .. " Picket",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		groups = node_groups,
		sounds = sounds,
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.0625, -0.4375, 0.5, 0},
				{0.4375, -0.5, -0.0625, 0.5, 0.5, 0},
				{-0.3125, -0.5, -0.0625, -0.1875, 0.5, 0},
				{-0.5, 0.1875, 0, 0.5, 0.3125, 0.0625},
				{0.1875, -0.5, -0.0625, 0.3125, 0.5, 0},
				{-0.5, -0.3125, 0, 0.5, -0.1875, 0.0625},
				{-0.0625, -0.5, -0.0625, 0.0625, 0.5, 0},
			}
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.0625, 0.5, 0.5, 0},
			}
		},
		on_rotate = handle_manual_rotation,
	})

	-- Post Picket (because hyper-rationality is real)
	minetest.register_node(":pickets:post_picket" .. subname, {
		description = description .. " Post Picket",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		groups = node_groups,
		sounds = sounds,
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
				{0.4375, -0.5, -0.0625, 0.5, 0.5, 0},
				{-0.5, -0.5, -0.0625, -0.4375, 0.5, 0},
				{-0.3125, -0.5, -0.0625, -0.1875, 0.5, 0},
				{-0.0625, -0.5, -0.0625, 0.0625, 0.5, 0.0625},
				{0.1875, -0.5, -0.0625, 0.3125, 0.5, 0},
				{-0.5, 0.1875, 0, 0.5, 0.3125, 0.0625},
				{-0.5, -0.3125, 0, 0.5, -0.1875, 0.0625},
			}
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.0625, 0.5, 0.5, 0},
			}
		},
		on_rotate = handle_manual_rotation,
	})

	-- Outer Corner
	minetest.register_node(":pickets:picket_corner" .. subname, {
		description = description .. " Picket Corner",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		groups = node_groups,
		sounds = sounds,
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.0625, -0.5, 0.4375, 0, 0.5, 0.5},
				{0.4375, -0.5, -0.0625, 0.5, 0.5, 0},
				{-0.0625, -0.5, 0.1875, 0, 0.5, 0.3125},
				{0, 0.1875, 0, 0.5, 0.3125, 0.0625},
				{0.1875, -0.5, -0.0625, 0.3125, 0.5, 0},
				{0, -0.3125, 0, 0.5, -0.1875, 0.0625},
				{-0.0625, -0.5, -0.0625, 0.0625, 0.5, 0.0625},
				{0, 0.1875, 0.0625, 0.0625, 0.3125, 0.5},
				{0, -0.3125, 0.0625, 0.0625, -0.1875, 0.5},
			}
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{0, -0.5, -0.0625, 0.5, 0.5, 0},
				{-0.0625, -0.5, -0.0625, 0, 0.5, 0.5},
			}
		},
		on_rotate = handle_manual_rotation,
	})

	-- Inner Corner
	minetest.register_node(":pickets:picket_icorner" .. subname, {
		description = description .. " Picket iCorner",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		groups = node_groups,
		sounds = sounds,
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
				{0, -0.5, -0.5, 0.0625, 0.5, -0.4375},
				{0.4375, -0.5, -0.0625, 0.5, 0.5, 0},
				{0, -0.5, -0.3125, 0.0625, 0.5, -0.1875},
				{0.0625, 0.1875, 0, 0.5, 0.3125, 0.0625},
				{0.1875, -0.5, -0.0625, 0.3125, 0.5, 0},
				{0.0625, -0.3125, 0, 0.5, -0.1875, 0.0625},
				{-0.0625, -0.5, -0.0625, 0.0625, 0.5, 0.0625},
				{-0.0625, 0.1875, -0.5, 0, 0.3125, -0.0625},
				{-0.0625, -0.3125, -0.5, 0, -0.1875, -0.0625},
			}
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{0.0625, -0.5, -0.0625, 0.5, 0.5, 0},
				{0, -0.5, -0.5, 0.0625, 0.5, 0},
			}
		},
		on_rotate = handle_manual_rotation,
	})
end

function pickets.register_gate_nodes(subname, groups, gate_texture, post_texture,  description, sounds)
	local node_groups = table.copy(groups)
	node_groups.picket = 1
	node_groups.gate = 1

	local gate_images = {post_texture, gate_texture}

	-- Closed State
	minetest.register_node(":pickets:gate_closed" .. subname, {
		description = description .. " Gate",
		tiles = gate_images,
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		use_texture_alpha = "clip",
		groups = node_groups,
		sounds = sounds,
		drawtype = "mesh",
		mesh = "picket_gate_closed.obj",
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.125, 0.5, 0.5, 0.0625}
		},
		collision_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.125, 0.5, 0.5, 0.0625}
		},
		on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			minetest.swap_node(pos, {name = "pickets:gate_half_open" .. subname, param2 = node.param2})
			minetest.sound_play("doors_fencegate_open", {pos = pos, gain = 1.0, max_hear_distance = 16})

			minetest.after(0.15, function()
				local current_node = minetest.get_node(pos)
				if current_node.name == "pickets:gate_half_open" .. subname then
					minetest.swap_node(pos, {name = "pickets:gate_open" .. subname, param2 = node.param2})
				end
			end)
		end,
		on_rotate = handle_manual_rotation,
	})

	-- Half-Open State
	local intermediate_groups = table.copy(node_groups)
	intermediate_groups.not_in_creative_inventory = 1

	minetest.register_node(":pickets:gate_half_open" .. subname, {
		description = description .. " Gate (Opening...)",
		tiles = gate_images,
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		use_texture_alpha = "clip",
		groups = intermediate_groups,
		sounds = sounds,
		drop = "pickets:gate_closed" .. subname,
		drawtype = "mesh",
		mesh = "picket_gate_half_open.obj",
		create_inventory_image = false,
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.125, 0.5, 0.5, 0.0625}
		},
		collision_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.125, 0.5, 0.5, 0.0625}
		},
		on_rotate = handle_manual_rotation,
	})

	-- Open State
	local open_groups = table.copy(node_groups)
	open_groups.not_in_creative_inventory = 1

	minetest.register_node(":pickets:gate_open" .. subname, {
		description = description .. " Gate (Open)",
		tiles = gate_images,
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		use_texture_alpha = "clip",
		groups = open_groups,
		sounds = sounds,
		drop = "pickets:gate_closed" .. subname,
		drawtype = "mesh",
		mesh = "picket_gate_open.obj",
		create_inventory_image = false,
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.125, 0.5, 0.5, 0.0625}
		},
		collision_box = {
			type = "fixed",
			fixed = {{0, 0, 0, 0, 0, 0}}
		},
		on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			minetest.swap_node(pos, {name = "pickets:gate_half_open" .. subname, param2 = node.param2})
			minetest.sound_play("doors_fencegate_close", {pos = pos, gain = 1.0, max_hear_distance = 16})

			minetest.after(0.15, function()
				local current_node = minetest.get_node(pos)
				if current_node.name == "pickets:gate_half_open" .. subname then
					minetest.swap_node(pos, {name = "pickets:gate_closed" .. subname, param2 = node.param2})
				end
			end)
		end,
		on_rotate = handle_manual_rotation,
	})
end

function pickets.register_all_variants(subname, groups, fence_tex, gate_tex, post_tex, desc, sounds)
	pickets.register_picket_nodes(subname, groups, fence_tex, desc, sounds)
	pickets.register_gate_nodes(subname, groups, gate_tex, post_tex, desc, sounds)
end

-- Register pickets & gates with separated texture asset mappings
-- Tex #1 slot is post_picket, picket, and the inner and outer corners
-- Tex #2 is the gate_panel, Tex #3 is the gate_post

-- ===========================
-- REGISTRATIONS WITH SETTINGS
-- ===========================

local master_enable_standard = minetest.settings:get_bool("enable_standard_pickets", true)

if master_enable_standard then
	if minetest.settings:get_bool("enable_picket_birch", true) then
		pickets.register_all_variants("_birch",
			{snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
			"pickets_birch_planks.png", "pickets_birch_planks.png", "pickets_birch_planks.png",
			"Birch", default.node_sound_wood_defaults())
	end

	if minetest.settings:get_bool("enable_picket_maple", true) then
		pickets.register_all_variants("_maple",
			{snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
			"pickets_maple_planks.png", "pickets_maple_planks.png", "pickets_maple_planks.png",
			"Maple", default.node_sound_wood_defaults())
	end

	if minetest.settings:get_bool("enable_picket_oak", true) then
		pickets.register_all_variants("_oak",
			{snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
			"pickets_oak_planks.png", "pickets_oak_planks.png", "pickets_oak_planks.png",
			"Oak", default.node_sound_wood_defaults())
	end

	if minetest.settings:get_bool("enable_picket_pine", true) then
		pickets.register_all_variants("_pine",
			{snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
			"pickets_pine_planks.png", "pickets_pine_planks.png", "pickets_pine_planks.png",
			"Pine", default.node_sound_wood_defaults())
	end

	if minetest.settings:get_bool("enable_picket_walnut", true) then
		pickets.register_all_variants("_walnut",
			{snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
			"pickets_walnut_planks.png", "pickets_walnut_planks.png", "pickets_walnut_planks.png",
			"Walnut", default.node_sound_wood_defaults())
	end

	if minetest.settings:get_bool("enable_picket_white", true) then
		pickets.register_all_variants("_white",
			{snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
			"default_clay.png", "default_clay.png", "default_clay.png",
			"White", default.node_sound_wood_defaults())
	end

	if minetest.settings:get_bool("enable_picket_willow", true) then
		pickets.register_all_variants("_willow",
			{snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
			"pickets_willow_planks.png", "pickets_willow_planks.png", "pickets_willow_planks.png",
			"Willow", default.node_sound_wood_defaults())
	end

	if minetest.settings:get_bool("enable_picket_wood", true) then
		pickets.register_all_variants("_wood",
			{snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
			"default_wood.png", "default_obsidian.png", "default_wood.png",
			"Wood", default.node_sound_wood_defaults())
	end
end


