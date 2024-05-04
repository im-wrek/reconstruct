return function(options, a: Font, excludeLocal: boolean): string
	local source = not (excludeLocal or (not (options['AppendVariable']) or false)) and `local output = Font.new(` or `Font.new(`
	source ..= `{a.Family or "nil"}{a.Weight and ", Enum.FontWeight." .. a.Weight.Name or "nil"}{a.Style and ", Enum.FontStyle." .. a.Style.Name or "nil"}`
	source ..= ")"
	return source
end