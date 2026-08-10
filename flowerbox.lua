-- [Mod] Flowerbox [flowerbox] [Ver. 0.1]
-- MIT Copyright (c) 2015 - 2026 TumeniNodes

-- Read the module configuration setting state (Defaults to true if missing)
local enable_module = minetest.settings:get_bool("enable_flowerbox_module", true)

if not enable_module then
	-- If disabled in settings, stop reading immediately and skip registering any box items
	return
end

flowerbox = {}

local STAGE_DIRT    = 1
local STAGE_SEEDS   = 2
local STAGE_GROWN   = 3

-- Add Flowers Here
flowerbox.registered_flowers = {
	{id = "rose",   desc = "Rose",   tex = "flowerbox_flowers_rose.png"},
	{id = "viola",  desc = "Viola",  tex = "flowerbox_flowers_viola.png"},
	{id = "daisy",  desc = "Daisy",  tex = "flowerbox_flowers_dandelion_white.png"},
}

local function is_valid_attachment(pos)
	local below = {x = pos.x, y = pos.y - 1, z = pos.z}
	local bnode = minetest.get_node(below)

	if minetest.registered_nodes[bnode.name] and minetest.registered_nodes[bnode.name].walkable then
		return true
	end
	if minetest.get_item_group(bnode.name, "picket") > 0 then
		return true
	end
	return false
end

local function update_flower_top_node(pos, stage, node_type, subname)
	local top_pos = {x = pos.x, y = pos.y + 1, z = pos.z}
	local top_node = minetest.get_node(top_pos)

	if stage == STAGE_DIRT or stage == STAGE_SEEDS then
		if top_node.name:find("flowerbox:flowers_") then
			minetest.remove_node(top_pos)
		end
		return
	end

	local meta = minetest.get_meta(pos)
	local flower_type = meta:get_string("flower_type")
	if flower_type == "" then flower_type = "rose" end

	local box_dir = minetest.get_node(pos).param2
	minetest.set_node(top_pos, {
		name = "flowerbox:flowers_" .. node_type .. "_" .. flower_type .. "_" .. subname,
		param2 = box_dir
	})
end

-- ===========
-- FLOWERBOXES
-- ===========

local picketbox = {
	type = "fixed",
	fixed = {
		{-0.4375, 0.125, 0.875, 0.4375, 0.375, 0.9375},
		{-0.4375, 0.0625, 0.5625, 0.4375, 0.125, 0.9375},
		{-0.4375, 0.125, 0.5625, 0.4375, 0.375, 0.625},
		{0.4375, 0.0625, 0.5625, 0.5, 0.375, 0.9375},
		{-0.5, 0.0625, 0.5625, -0.4375, 0.375, 0.9375},
	}
}

local picketbox_full = {
	type = "fixed",
	fixed = {
		{-0.4375, 0.125, 0.875, 0.4375, 0.375, 0.9375},
		{-0.4375, 0.0625, 0.5625, 0.4375, 0.125, 0.9375},
		{-0.4375, 0.125, 0.5625, 0.4375, 0.375, 0.625},
		{0.4375, 0.0625, 0.5625, 0.5, 0.375, 0.9375},
		{-0.5, 0.0625, 0.5625, -0.4375, 0.375, 0.9375},
		{-0.4375, 0.0625, 0.625, 0.4375, 0.3125, 0.875}, -- Dirt Inside Flowerbox
	}
}

local picketbox_flowers = {
	type = "fixed",
	fixed = {
		{-0.5, -0.625, 0.5625, 0.5, -0.5, 0.9375},
		{-0.5, -0.6875, 0.5, 0.5, -0.5, 0.5625},
		{-0.375, -0.75, 0.5, 0.375, -0.6875, 0.5625},
		{-0.1875, -0.8125, 0.5, 0.1875, -0.75, 0.5625},
		{0.5, -0.5625, 0.5, 0.5625, -0.5, 0.9375},
		{0.5, -0.625, 0.5, 0.5625, -0.5625, 0.875},
		{0.5, -0.6875, 0.5, 0.5625, -0.625, 0.75},
		{-0.5625, -0.5625, 0.5, -0.5, -0.5, 0.9375},
		{-0.5625, -0.625, 0.5, -0.5, -0.5625, 0.875},
		{-0.5625, -0.6875, 0.5, -0.5, -0.625, 0.75},
	}
}

local selection_box = {
	type = "fixed",
	fixed = {{-0.5, 0.0625, 0.5625, 0.5, 0.375, 0.9375}}
}

local windowbox = {
	type = "fixed",
	fixed = {
		{-0.4375, 0.125, 0.4375, 0.4375, 0.375, 0.5},
		{-0.4375, 0.0625, 0.125, 0.4375, 0.125, 0.5},
		{-0.4375, 0.125, 0.125, 0.4375, 0.375, 0.1875},
		{0.4375, 0.0625, 0.125, 0.5, 0.375, 0.5},
		{-0.5, 0.0625, 0.125, -0.4375, 0.375, 0.5},
	}
}

local windowbox_full = {
	type = "fixed",
	fixed = {
		{-0.4375, 0.125, 0.4375, 0.4375, 0.375, 0.5},
		{-0.4375, 0.0625, 0.125, 0.4375, 0.125, 0.5},
		{-0.4375, 0.125, 0.125, 0.4375, 0.375, 0.1875},
		{0.4375, 0.0625, 0.125, 0.5, 0.375, 0.5},
		{-0.5, 0.0625, 0.125, -0.4375, 0.375, 0.5},
		{-0.4375, 0.0625, 0.1875, 0.4375, 0.3125, 0.4375}, --Dirt Inside Flowerbox
	}
}

local windowbox_flowers = {
	type = "fixed",
	fixed = {
		{-0.5, -0.625, 0.125, 0.5, -0.5, 0.5},
		{-0.5, -0.6875, 0.0625, 0.5, -0.5, 0.125},
		{-0.375, -0.75, 0.0625, 0.375, -0.6875, 0.125},
		{-0.1875, -0.8125, 0.0625, 0.1875, -0.75, 0.125},
		{0.5, -0.5625, 0.0625, 0.5625, -0.5, 0.5},
		{0.5, -0.625, 0.0625, 0.5625, -0.5625, 0.4375},
		{0.5, -0.6875, 0.0625, 0.5625, -0.625, 0.3125},
		{-0.5625, -0.5625, 0.0625, -0.5, -0.5, 0.5},
		{-0.5625, -0.625, 0.0625, -0.5, -0.5625, 0.4375},
		{-0.5625, -0.6875, 0.0625, -0.5, -0.625, 0.3125},
	}
}

local windowbox_selection_box = {
	type = "fixed",
	fixed = {{-0.5, 0.0625, 0.125, 0.5, 0.375, 0.5}}
}

-- ======================
-- REGISTER NODES & TOOLS
-- ======================

function flowerbox.register_box_variant(subname, groups, mat_tex, type_desc, node_type, empty_boxes, full_boxes, flower_boxes, selection_boxes, sounds)
	local box_groups = table.copy(groups)
	box_groups.flowerbox = 1

	local hidden_groups = table.copy(box_groups)
	hidden_groups.not_in_creative_inventory = 1

	local empty_name = node_type .. "_" .. subname
	local full_name  = node_type .. "_full_" .. subname

	for _, flower in ipairs(flowerbox.registered_flowers) do
		local blooming_name = "flowers_" .. node_type .. "_" .. flower.id .. "_" .. subname

		minetest.register_node(":flowerbox:" .. blooming_name, {
			description = type_desc .. " Box " .. flower.desc .. " Layout (" .. subname:gsub("^%l", string.upper) .. ")",
			tiles = {flower.tex},
			paramtype = "light",
			paramtype2 = "facedir",
			use_texture_alpha = "clip",
			walkable = false,
			pointable = false,
			sunlight_propagates = true,
			drawtype = "nodebox",
			node_box = flower_boxes,
			selection_box = {type = "fixed", fixed = {0,0,0,0,0,0}},
			groups = hidden_groups,
		})
	end

	-- EMPTY FLOWERBOX
	minetest.register_node(":" .. empty_name, {
		description = type_desc .. " " .. subname:gsub("^%l", string.upper) .. " Box",
		tiles = {mat_tex},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = box_groups,
		sounds = sounds,
		drawtype = "nodebox",
		node_box = empty_boxes,
		selection_box = selection_boxes,
		on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			if itemstack:get_name() == "default:dirt" then
				if not minetest.settings:get_bool("creative_mode") then itemstack:take_item() end
				minetest.sound_play("default_place_node", {pos = pos, gain = 1.0})
				minetest.swap_node(pos, {name = full_name, param2 = node.param2})

				local meta = minetest.get_meta(pos)
				meta:set_int("stage", STAGE_DIRT)
				meta:set_string("infotext", type_desc .. " Box (Ready for Seeds)")
				return itemstack
			end
		end,
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			if not is_valid_attachment(pos) then minetest.remove_node(pos) end
		end,
	})

	-- FULL FLOWERBOX

local top_texture = mat_tex .. "^flowerbox_window_dirt.png"
	if node_type == "picketbox" then
		top_texture = mat_tex .. "^flowerbox_picket_dirt.png"
	elseif node_type == "windowbox" then
		top_texture = mat_tex .. "^flowerbox_window_dirt.png"
	end

	minetest.register_node(":" .. full_name, {
		description = type_desc .. " " .. subname:gsub("^%l", string.upper) .. " Box (Full)",
		tiles = {top_texture, mat_tex},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = hidden_groups,
		sounds = sounds,
		drop = empty_name,
		drawtype = "nodebox",
		node_box = full_boxes,
		selection_box = selection_boxes,
		on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			local meta = minetest.get_meta(pos)
			local stage = meta:get_int("stage")
			local item_name = itemstack:get_name()

			if item_name:find("shovel") or item_name == "pickets:garden_shovel" then
				minetest.sound_play("default_dig_crumbly", {pos = pos, gain = 0.9})
				update_flower_top_node(pos, STAGE_DIRT, node_type, subname)
				minetest.swap_node(pos, {name = empty_name, param2 = node.param2})
				meta:set_int("stage", 0)
				meta:set_string("infotext", "")
				meta:set_string("flower_type", "")
				return itemstack
			end

			if stage == STAGE_DIRT then
				for _, flower in ipairs(flowerbox.registered_flowers) do
					if item_name == "pickets:seed_" .. flower.id or item_name == "flowers:seed_" .. flower.id then
						if not minetest.settings:get_bool("creative_mode") then itemstack:take_item() end
						minetest.sound_play("default_place_node", {pos = pos, gain = 0.7})

						meta:set_int("stage", STAGE_SEEDS)
						meta:set_string("flower_type", flower.id)
						meta:set_string("infotext", type_desc .. " Box (" .. flower.desc .. " Seeds Planted)")
						return itemstack
					end
				end
			end

			if stage == STAGE_SEEDS and item_name == "pickets:watering_can_full" then
				minetest.sound_play("bucket_water", {pos = pos, gain = 0.8})
				meta:set_string("infotext", type_desc .. " Box (Watered)")
				minetest.get_node_timer(pos):start(math.random(15, 30))
				if not minetest.settings:get_bool("creative_mode") then
					itemstack:set_name("pickets:watering_can_empty")
					return itemstack
				end
			end
		end,
		on_timer = function(pos, elapsed)
			local meta = minetest.get_meta(pos)
			meta:set_int("stage", STAGE_GROWN)

			local f_type = meta:get_string("flower_type")
			if f_type == "" then f_type = "rose" end

			meta:set_string("infotext", type_desc .. " Box (Blooming " .. f_type:gsub("^%l", string.upper) .. "s)")
			update_flower_top_node(pos, STAGE_GROWN, node_type, subname)
			return false
		end,
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			if not is_valid_attachment(pos) then minetest.remove_node(pos) end
		end,
		on_destruct = function(pos)
			update_flower_top_node(pos, STAGE_DIRT, node_type, subname)
		end,
	})
end

-- =============
-- TOOLS & SEEDS
-- =============

minetest.register_craftitem("pickets:watering_can_empty", {
	description = "Empty Watering Can",
	inventory_image = "flowerbox_watering_can_empty.png",
	liquids_pointable = true,
	on_use = function(itemstack, user, pointed_thing)
		if not pointed_thing or pointed_thing.type ~= "node" then return end
		local pos = pointed_thing.under
		local node = minetest.get_node(pos)

		if minetest.get_item_group(node.name, "water") > 0 then
			minetest.sound_play("bucket_water", {pos = pos, gain = 1.0})
			itemstack:set_name("pickets:watering_can_full")
			return itemstack
		end
	end,
})

minetest.register_craftitem("pickets:watering_can_full", {
	description = "Full Watering Can",
	inventory_image = "flowerbox_watering_can_full.png",
	stack_max = 1,
})

minetest.register_tool("pickets:garden_shovel", {
	description = "Garden Shovel",
	inventory_image = "flowerbox_garden_shovel.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level = 0,
		groupcaps = {
			crumbly = {times={3.00, 1.60, 0.60}, uses=20, maxlevel=1},
		},
		damage_groups = {fleshy=1},
	},
})

for _, flower in ipairs(flowerbox.registered_flowers) do
	minetest.register_craftitem("pickets:seed_" .. flower.id, {
		description = flower.desc .. " Seeds",
		inventory_image = "flowerbox_seeds_" .. flower.id .. ".png",
	})
end

-- =========
-- MATERIALS
-- =========

local materials = {
	{subname = "wood",       texture = "default_wood.png"},
	{subname = "junglewood", texture = "default_junglewood.png"},
	{subname = "pine",       texture = "default_pine_wood.png"},
	{subname = "acacia",     texture = "default_acacia_wood.png"},
	{subname = "aspen",      texture = "default_aspen_wood.png"},
	{subname = "birch",       texture = "pickets_birch_planks.png^[transformR90.png"},
	{subname = "maple",       texture = "pickets_maple_planks.png^[transformR90.png"},
	{subname = "oak",       texture = "pickets_oak_planks.png^[transformR90.png"},
	{subname = "walnut",       texture = "pickets_walnut_planks.png^[transformR90.png"},
	{subname = "willow",       texture = "pickets_willow_planks.png^[transformR90.png"},
}

for _, mat in ipairs(materials) do
	flowerbox.register_box_variant(
		mat.subname,
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		mat.texture,
		"Picket",
		"picketbox",
		picketbox,
		picketbox_full,
		picketbox_flowers,
		selection_box,
		default.node_sound_wood_defaults()
	)

	flowerbox.register_box_variant(
		mat.subname,
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		mat.texture,
		"Window",
		"windowbox",
		windowbox,
		windowbox_full,
		windowbox_flowers,
		windowbox_selection_box,
		default.node_sound_wood_defaults()
	)
end

