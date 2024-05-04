return function(options, a: boolean, excludeLocal: boolean?): string
	local source = not (excludeLocal or (not (options['AppendVariable']) or false)) and `local output = {a}` or `{a}`
	return source
end