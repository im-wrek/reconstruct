return function(options, a: FloatCurveKey, excludeLocal: boolean): string
	local source = not (excludeLocal or (not (options['AppendVariable']) or false)) and `local output = FloatCurveKey.new(` or `FloatCurveKey.new(`
	source ..= `{a.Time or "nil"}{a.Value and ", " .. a.Value or "nil"}{a.Interpolation and ", Enum.KeyInterpolationMode." .. a.Interpolation.Name or "nil"}`
	source ..= ")"
	return source
end