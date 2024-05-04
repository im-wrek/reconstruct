return function(options, a: BrickColor, excludeLocal: boolean?): string
	local source = not (excludeLocal or (not (options['AppendVariable']) or false)) and `local output = BrickColor.new({a.Name})` or `BrickColor.new({a.Name})`
	return source
end