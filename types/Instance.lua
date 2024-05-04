return function(options, a: Instance, excludeLocal: boolean?): string
	local source = not (excludeLocal or (not (options['AppendVariable']) or false)) and `local output = Instance.new({a.Name})` or `Instance.new({a.Name})`
	return source
end