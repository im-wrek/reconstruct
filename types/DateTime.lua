return function(options, a: DateTime, excludeLocal: boolean?): string
	local source = not (excludeLocal or (not (options['AppendVariable']) or false)) and `local output = DateTime.fromUnixTimestampMillis(` or `DateTime.fromUnixTimestampMillis(`
	source ..= a.UnixTimestampMillis
	source ..= ")"
	return source
end