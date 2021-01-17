extends VBoxContainer


var BuildOption = preload("res://UserInterface/BuildOption.tscn")

# When setting tile_type, they must correspond to a tile in TileSet in Map
var building_from_xml
var modifier_from_xml

func _ready():
	# Location has interaction with resource multipliers
	building_from_xml = generate_config_options("res://Config/BuildingOptions.xml", "buildingOptions", "buildOption")
	modifier_from_xml = generate_config_options("res://Config/TileModifier.xml", "tileModifiers", "modifier")
	var tile_type = get_tree().current_scene.get_player_tile()
	for build in building_from_xml:
		var build_option =  BuildOption.instance()
		build_option.init(build, modifier_from_xml[tile_type])
		add_child(build_option)


func generate_config_options(file_path, top_layer, lower_layer):
	var config_string = read_file(file_path)
	var regex = RegEx.new()
	var tmp_string = ""
	var inside_building_options = false
	var tmp_build_options = []
	
	# Pulls the data in the building options tag
	regex.compile("<" + top_layer + ">")
	for line in config_string.split("\n"):
		if regex.search(line):
			inside_building_options = false
		if inside_building_options:
			tmp_string = tmp_string + line
		if regex.search(line):
			inside_building_options = true
			regex.compile("</" + top_layer + ">")
	
	# Takes the string that contains only the single build option
	regex.compile("(?<=<" + lower_layer + " ).*?(?=<\/" + lower_layer + ">)")
	var results = regex.search_all(tmp_string)
	if results:
		for result in results:
			var buildingData = {}
			# Takes the build options name
			regex.compile("(?<=^name=\").*?(?=\")")
			buildingData["Name"] = regex.search(result.get_string()).get_string()
			
			regex.compile("(?<=id=\").*?(?=\")")
			buildingData["ID"] = int(regex.search(result.get_string()).get_string())
			
			# Takes each attribute for the build option
			for attribute in ["cost", "upkeep", "production"]:
				regex.compile("(?<=<" + attribute + ">).*?(?=<\/" + attribute + ">)")
				buildingData[attribute] = {}
				var attribute_result = regex.search(result.get_string())
				for resource in ["food", "wood", "gold"]:
					regex.compile("(?<=<" + resource + ">).*?(?=<\/" + resource + ">)")
					var resource_result = regex.search(attribute_result.get_string())
					if resource_result:
						buildingData[attribute][resource] = int(resource_result.get_string())
			regex.compile("(?<=<icon>).*?(?=<\/icon>)")
			buildingData["icon"] = regex.search(result.get_string()).get_string()
			tmp_build_options.append(buildingData)
	for tmp in tmp_build_options:
		print(tmp)
	return tmp_build_options


func read_file(file_path):
	var file = File.new()
	file.open(file_path, File.READ)
	var content = file.get_as_text()
	file.close()
	return content
