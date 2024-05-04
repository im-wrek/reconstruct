local split, concat = string.split, table.concat

return function(options, a: Faces, excludeLocal: boolean?): string
	local source = not (excludeLocal or (not (options['AppendVariable']) or false)) and `local output = Faces.new(` or `Faces.new(`
	local props = split(tostring(a), ", ")
	for i, v in props do
		props[i] = "Enum.NormalId." .. v
	end
	source ..= concat(props,", ")
	source ..= ")"
	return source
end