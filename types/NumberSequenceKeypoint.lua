return function(options, a: NumberSequenceKeypoint, excludeLocal: boolean?): string
	local source = not (excludeLocal or (not (options['AppendVariable']) or false)) and "local output = NumberSequenceKeypoint.new(" or "NumberSequenceKeypoint.new("

	source ..=`{a.Time or "nil"}{a.Value and `, {a.Value}` or ", nil"}{a.Envelope and `, {a.Envelope}` or ", nil"})`
	return source
end