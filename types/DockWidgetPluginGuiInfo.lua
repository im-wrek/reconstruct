local split, insert, concat = string.split, table.insert, table.concat
return function(options, a: DockWidgetPluginGuiInfo, excludeLocal: boolean?): string
	local source = not (excludeLocal or (not (options['AppendVariable']) or false)) and `local output = DockWidgetPluginGuiInfo.new(` or `DockWidgetPluginGuiInfo.new(`
	local props = split(tostring(a), " ")

	local properties = {}

	for _, prop in props do
		local actualProp = split(prop, ":")
		local prop = actualProp[2]
		if actualProp[1] == "InitialDockState" then
			prop = "Enum.InitialDockState." .. prop
		end
		if actualProp[1] == "InitialEnabled" or actualProp[1] == "InitialEnabledShouldOverrideRestore" then
			prop = prop == "1" and "true" or "false"
		end
		insert(properties, prop)
	end

	source ..= concat(properties,", ")
	source ..= ")"
	return source
end