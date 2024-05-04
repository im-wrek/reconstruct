return function(options, a: nil, excludeLocal: boolean?): string
	local source = not (excludeLocal or (not (options['AppendVariable']) or false)) and `local output = nil` or `nil`
	return source
end