dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
local radius = 56

local t_w = EntityGetInRadiusWithTag( x, y, radius, "waterstone" )
local t_f = EntityGetInRadiusWithTag( x, y, radius, "brimstone" )
local t_a = EntityGetInRadiusWithTag( x, y, radius, "thunderstone" )
local t_e = EntityGetInRadiusWithTag( x, y, radius, "stonestone" )
local t_p = EntityGetInRadiusWithTag( x, y, radius, "poopstone" )
local t_g = EntityGetInRadiusWithTag( x, y, radius, "gourd" )
local t_eye = EntityGetInRadiusWithTag( x, y, radius, "evil_eye")

local w = (#t_w > 0)
local f = (#t_f > 0)
local a = (#t_a > 0)
local e = (#t_e > 0)
local p = (#t_p > 0)
local g = (#t_g > 0)
local eye = (#t_eye > 0)

local essences_list = ""
local comp = EntityGetFirstComponent( entity_id, "VariableStorageComponent", "sunbaby_essences_list" )
local comp2 = EntityGetFirstComponent( entity_id, "SpriteComponent", "sunbaby_sprite" )

local found = 0

if ( comp ~= nil ) and ( comp2 ~= nil ) then
	essences_list = ComponentGetValue2( comp, "value_string" )

	if w then
		if ( string.find( essences_list, "water" ) == nil ) then
			EntitySetComponentsWithTagEnabled( entity_id, "water", true )
			ComponentSetValue2( comp2, "image_file", "data/props_gfx/sun_small_purple.png" )
			essences_list = essences_list .. "water,"
			EntityLoad("data/entities/projectiles/deck/explosion_giga.xml", x, y)
			GameScreenshake( 30, x, y )
		end
			
		for i,v in ipairs( t_w ) do
			EntityKill( v )
		end
	end
	
	if f then
		if ( string.find( essences_list, "fire" ) == nil ) then
			EntitySetComponentsWithTagEnabled( entity_id, "fire", true )
			EntitySetComponentsWithTagEnabled( entity_id, "fire_disable", false )
			ComponentSetValue2( comp2, "image_file", "data/props_gfx/sun_small_red.png" )
			essences_list = essences_list .. "fire,"
			EntityLoad("data/entities/projectiles/deck/explosion_giga.xml", x, y)
			GameScreenshake( 30, x, y )
		end
			
		for i,v in ipairs( t_f ) do
			EntityKill( v )
		end
	end
	
	if a then
		if ( string.find( essences_list, "air" ) == nil ) then
			EntitySetComponentsWithTagEnabled( entity_id, "air", true )
			ComponentSetValue2( comp2, "image_file", "data/props_gfx/sun_small_blue.png" )
			essences_list = essences_list .. "air,"
			EntityLoad("data/entities/projectiles/deck/explosion_giga.xml", x, y)
			GameScreenshake( 30, x, y )
		end
			
		for i,v in ipairs( t_a ) do
			EntityKill( v )
		end
	end
	
	if e then
		if ( string.find( essences_list, "earth" ) == nil ) then
			EntitySetComponentsWithTagEnabled( entity_id, "earth", true )
			EntitySetComponentsWithTagEnabled( entity_id, "earth_disable", false )
			local eid = EntityLoad( "data/entities/misc/loose_ground_permanent.xml", x, y )
			EntityAddChild( entity_id, eid )
			
			ComponentSetValue2( comp2, "image_file", "data/props_gfx/sun_small_green.png" )
			essences_list = essences_list .. "earth,"
			EntityLoad("data/entities/projectiles/deck/explosion_giga.xml", x, y)
			GameScreenshake( 30, x, y )
		end
			
		for i,v in ipairs( t_e ) do
			EntityKill( v )
		end
	end
	
	if p then
		if ( string.find( essences_list, "poop" ) == nil ) then
			EntitySetComponentsWithTagEnabled( entity_id, "poop", true )
			ComponentSetValue2( comp2, "image_file", "data/props_gfx/sun_small_orange.png" )
			essences_list = essences_list .. "poop,"
			EntityLoad("data/entities/projectiles/deck/explosion_giga.xml", x, y)
			GameScreenshake( 30, x, y )
		end
			
		for i,v in ipairs( t_p ) do
			EntityKill( v )
		end
	end

    if g then
        if ( string.find( essences_list, "gourd" ) == nil ) then
            EntitySetComponentsWithTagEnabled( entity_id, "gourd", true )
			ComponentSetValue2( comp2, "image_file", "mods/thesunmod/files/sprites/sun_small_gourd.png" )
			essences_list = essences_list .. "gourd,"
			EntityLoad("data/entities/projectiles/deck/explosion_giga.xml", x, y)
			GameScreenshake( 30, x, y )
        end

        for i,v in ipairs( t_g ) do
			EntityKill( v )
		end
    end

	if eye then 
		if ( string.find( essences_list, "eye" ) == nil ) then
            EntitySetComponentsWithTagEnabled( entity_id, "eye", true )
			ComponentSetValue2( comp2, "image_file", "mods/thesunmod/files/sprites/sun_small_gourd.png" )
			essences_list = essences_list .. "eye,"
			EntityLoad("data/entities/projectiles/deck/explosion_giga.xml", x, y)
			GameScreenshake( 30, x, y )
        end

        for i,v in ipairs( t_eye ) do
			EntityKill( v )
		end
	end
	
	local ohno = false
    local ohg = false
	local eyefound = false
	if ( string.find( essences_list, "water" ) ~= nil ) then
		found = found + 1
	end
	
	if ( string.find( essences_list, "fire" ) ~= nil ) then
		found = found + 1
	end
	
	if ( string.find( essences_list, "air" ) ~= nil ) then
		found = found + 1
	end
	
	if ( string.find( essences_list, "earth" ) ~= nil ) then
		found = found + 1
	end
	
	if ( string.find( essences_list, "poop" ) ~= nil ) then
		ohno = true
	end

    if ( string.find( essences_list, "gourd" ) ~= nil ) then
		ohg = true
	end

	if ( string.find( essences_list, "eye" ) ~= nil ) then
		eyefound = true
	end
	
	if ( found > 0 ) then
		EntitySetComponentsWithTagEnabled( entity_id, "sunbaby_stage_1", false )
	end
	
	if ( found > 2 ) then
		EntitySetComponentsWithTagEnabled( entity_id, "sunbaby_stage_2", false )
	end
	
	if ( found == 4 ) then
		if ohno == true then
            local sun = EntityLoad("data/entities/items/pickup/sun/newsun_dark.xml", x, y)
            EntityAddTag(sun, "sun")
			GamePrintImportant( "The Dark Sun rises...", "" )
			AddFlagPersistent( "progress_darksun" )
        elseif ohg == true then
            local sun = EntityLoad("mods/thesunmod/files/entities/newsun_gourd.xml", x, y)
            EntityAddTag(sun, "sun")
			GamePrintImportant( "The Green Sun rises...", "" )
		elseif eyefound == true then
			local sun = EntityLoad("mods/thesunmod/files/entities/newsun_digging.xml", x, y)
            EntityAddTag(sun, "sun")
			GamePrintImportant( "The Green Sun rises...", "" )
		else
            local sun = EntityLoad("data/entities/items/pickup/sun/newsun.xml", x, y)
            EntityAddTag(sun, "sun")
			GamePrintImportant( "The New Sun rises...", "" )
			AddFlagPersistent( "progress_sun" )
        end
		
		GameTriggerMusicFadeOutAndDequeueAll( 3.0 )
		GameTriggerMusicEvent( "music/oneshot/dark_01", true, x, y )
		GameScreenshake( 80, x, y )
		EntityLoad("data/entities/projectiles/deck/explosion_giga.xml", x, y)
		EntityKill(entity_id)
	end
	
	ComponentSetValue2( comp, "value_string", essences_list )
end