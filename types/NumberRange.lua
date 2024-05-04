return function(options, a: NumberRange, excludeLocal: boolean): string
	local source = not (excludeLocal or (not (options['AppendVariable']) or false)) and `local output = NumberRange.new(` or `NumberRange.new(`
	local min, max = tostring(a.Min), tostring(a.Max)

	source ..= min == max and max or `{min == "inf" and "math.huge" or min == "-inf" and "-math.huge" or min}, {max == "inf" and "math.huge" or max == "-inf" and "-math.huge" or max}`
	source ..= ")"
	return source
end