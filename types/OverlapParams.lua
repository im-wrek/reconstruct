local properties = {
	"FilterType",
	"CollisionGroup",
	"FilterDescendantsInstances",
	"MaxParts",
	"RespectCanCollide",
	"BruteForceAllSlow",
}

local defaultProperties = {
	["FilterType"] = Enum.RaycastFilterType.Exclude,
	["CollisionGroup"] = "Default",
	["MaxParts"] = 0,
	["RespectCanCollide"] = true,
	["BruteForceAllSlow"] = false,
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

return function(options: {}, a: OverlapParams): string
	local varName = gsub(options['VariableNames'] and options['VariableNames'] or "%type_", "%%type", typeof(a))
	local source = `local {varName} = OverlapParams.new()`

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