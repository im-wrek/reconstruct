local properties = {
	"SearchKeyword",
	"MinPrice",
	"MaxPrice",
	"SortType",
	"SortAggregation",
	"CategoryFilter",
	"SalesTypeFilter",
	"BundleTypes",
	"AssetTypes",
	"IncludeOffSale",
	"CreatorName",
	"Limit"
}

local defaultProperties = {
	["BundleTypes"] = {},
	["SalesTypeFilter"] = Enum.SalesTypeFilter.All,
	["SortAggregation"] = Enum.CatalogSortAggregation.AllTime,
	["SortType"] = Enum.CatalogSortType.Relevance,
	["IncludeOffSale"] = false,
	["CreatorName"] = "",
	["Limit"] = 30,
	["MaxPrice"] = 2147483647,
	["CategoryFilter"] = Enum.CatalogCategoryFilter.None,
	["MinPrice"] = 0,
	["AssetTypes"] = {},
	["SearchKeyword"] = "",
}

local percentQ = "%q"

local format, gsub = string.format, string.gsub

local table_ = require(script.Parent.table)

function process(options, a: any): string
	local t = type(a)

	if t == "EnumItem" then
		return `Enum.{a.EnumType.Name}.{a.Name}`
	elseif t == "string" then
		return format(percentQ, a)
	elseif t == "table" then
		return table_(options, a, true)
	end

	return tostring(a)
end

return function(options: {}, a: CatalogSearchParams): string
	local varName = gsub(options['VariableNames'] and options['VariableNames'] or "%type_", "%%type", typeof(a))
	local source = `local {varName} = CatalogSearchParams.new()`

	if options['ReconstructInstances'] ~= false then
		for _, v in properties do
			local prop = a[v]

			if prop and (prop ~= 0 or prop ~= "") and (defaultProperties[v] ~= prop) then
				source ..= "\n" .. `{varName}.` .. v .. " = "..process(options, prop)
			end
		end
	end

	return varName, source
end