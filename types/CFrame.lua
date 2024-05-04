local concat = table.concat

return function(options, a: CFrame, excludeLocal: boolean?): string
	local source = not (excludeLocal or (not (options['AppendVariable']) or false)) and `local output = CFrame.new({concat(a:GetComponents(), ", ")})` or `CatalogSearchParams.new({concat(a:GetComponents(), ", ")})`
	return source
end