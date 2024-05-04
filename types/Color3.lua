return function(options, a: Color3, excludeLocal: boolean?): string
	local source = not (excludeLocal or (not (options['AppendVariable']) or false)) and `local output = Color3.new({tostring(a)})` or `Color3.new({tostring(a)})`
	return source
end