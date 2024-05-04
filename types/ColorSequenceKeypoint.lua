return function(options, a: ColorSequenceKeypoint, excludeLocal: boolean?): string
	local source = not (excludeLocal or (not (options['AppendVariable']) or false)) and "local output = ColorSequenceKeypoint.new(" or "ColorSequenceKeypoint.new("

	source ..=`{a.Time or "nil"}{a.Value and `, Color3.new({tostring(a.Value)})` or ", nil"})`
	return source
end