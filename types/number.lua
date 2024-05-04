local format = string.format
local percentQ = "%q"

return function(options, a: any, excludeLocal: boolean?): string
	local source = not (excludeLocal or (not (options['AppendVariable']) or false)) and `local output = ` or ``
	source ..= format(percentQ, tostring(a))
	return source
end