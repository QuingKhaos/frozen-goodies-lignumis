local khaoslib_item = require("__khaoslib__.item")
local khaoslib_recipe = require("__khaoslib__.recipe")
local khaoslib_technology = require("__khaoslib__.technology")

local frozen_goodies = {
  {
    name = "fg-frozen-cupriavidus-necator",
    item = "cupriavidus-necator",
    tech = "plastics",
    icon = "__lignumis-assets__/graphics/icons/cupriavidus-necator-1.png",
    scale = 0.35,
    shift = {0, -4},
  },
}

for _, goodie in pairs(frozen_goodies) do
  khaoslib_item:load {
    type = "item",
    name = goodie.name,
    subgroup = "fg-frozen",
    weight = 2000,
    order = "f[" .. goodie.name .. "]",
    stack_size = 100,
  } :add_icon {icon = "__space-age__/graphics/icons/ice.png", icon_size = 64}
    :add_icon {icon = goodie.icon, icon_size = 64, scale = goodie.scale, shift = goodie.shift}
    :add_icon {icon = "__frozen-goodies-base-assets__/graphics/icons/ice-open.png", icon_size = 64}
    :commit()

  khaoslib_recipe:load {
    type = "recipe",
    name = goodie.name,
    category = "advanced-crafting",
    auto_recycle = false,
    enabled = false,
    energy_required = 0.5,
  } :add_ingredient {type = "item", name = goodie.item, amount = 1}
    :add_ingredient {type = "item", name = "ice", amount = 1}
    :add_result {type = "item", name = goodie.name, amount = 1}
    :commit()

  khaoslib_recipe:load {
    type = "recipe",
    name = goodie.name .. "-melt",
    category = "advanced-crafting",
    subgroup = "fg-unfrozen",
    auto_recycle = false,
    enabled = false,
    energy_required = 0.5,
  } :add_icon {icon = "__space-age__/graphics/icons/ice.png", icon_size = 64}
    :add_icon {icon = goodie.icon, icon_size = 64, scale = goodie.scale, shift = goodie.shift}
    :add_icon {icon = "__frozen-goodies-base-assets__/graphics/icons/ice-open.png", icon_size = 64}
    :add_icon {icon = "__frozen-goodies-base-assets__/graphics/icons/fire.png", icon_size = 64, scale = 0.3, shift = {-10, -10}}
    :add_ingredient {type = "item", name = goodie.name, amount = 1}
    :add_result {type = "item", name = goodie.item, amount = 1}
    :add_result {type = "item", name = "fg-ice-shards", amount_min = 1, amount_max = 3, probability = 0.2}
    :commit()

  khaoslib_technology:load(goodie.tech)
    :add_unlock_recipe(goodie.name)
    :add_unlock_recipe(goodie.name .. "-melt")
    :commit()
end
