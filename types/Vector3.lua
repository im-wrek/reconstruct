return function(options, a: Vector3, excludeLocal: boolean?): string
	local source = not (excludeLocal or (not (options['AppendVariable']) or false)) and `local output = Vector3.new({tostring(a)})` or `Vector3.new({tostring(a)})`
	return source
end