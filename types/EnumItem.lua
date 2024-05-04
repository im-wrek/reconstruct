return function(options, a: EnumItem, excludeLocal: boolean?): string
	local source = not (excludeLocal or (not (options['AppendVariable']) or false)) and `local output = Enum.{a.EnumType}.` or `Enum.{a.EnumType}.`
	source ..= a.Name
	return source
end