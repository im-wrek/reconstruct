local insert, concat = table.insert, table.concat

return function(options, a: Axes, excludeLocal: boolean?): string
	local source = not (excludeLocal or (not (options['AppendVariable']) or false)) and `local output = Axes.new(` or `Axes.new(`

	local properties = {}

	if a.X then
		insert(properties, `Enum.NormalId.Left`)
		insert(properties, `Enum.NormalId.Right`)
	end
	if a.Y then
		insert(properties, `Enum.NormalId.Top`)
		insert(properties, `Enum.NormalId.Bottom`)
	end
	if a.Z then
		insert(properties, `Enum.NormalId.Front`)
		insert(properties, `Enum.NormalId.Back`)
	end

	source ..= concat(properties,", ")
	source ..=")"
	return source
end