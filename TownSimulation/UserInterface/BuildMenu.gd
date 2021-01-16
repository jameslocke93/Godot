extends VBoxContainer


var BuildOption = preload("res://UserInterface/BuildOption.tscn")

# When setting tile_type, they must correspond to a tile in TileSet in Map
var building_from_xml = []

func _ready():
	generate_build_options("res://Config/BuildingOptions.xml")
	for build in building_from_xml:
		var build_option =  BuildOption.instance()
		build_option.init(build)
		add_child(build_option)


func generate_build_options(file_path):
	var config_string = read_file(file_path)
	var regex = RegEx.new()
	var tmp_string = ""
	var inside_building_options = false
	var tmp_build_options = []
	
	# Pulls the data in the building options tag
	regex.compile("<buildingOptions>")
	for line in config_string.split("\n"):
		if regex.search(line):
			inside_building_options = false
		if inside_building_options:
			tmp_string = tmp_string + line
		if regex.search(line):
			inside_building_options = true
			regex.compile("</buildingOptions>")
	
	# Takes the string that contains only the single build option
	regex.compile("(?<=<buildOption ).*?(?=<\/buildOption>)")
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
			building_from_xml.append(buildingData)
	for tmp in building_from_xml:
		print(tmp)


func read_file(file_path):
	var file = File.new()
	file.open(file_path, File.READ)
	var content = file.get_as_text()
	file.close()
	return content
