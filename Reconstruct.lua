--[[
THIS MODULE IS RECOMMENDED FOR USE IN STUDIOS COMMAND BAR, YOU DONT HAVE TO THOUGH

Information
	Reconstruct
	Version : V.0.1
	Author : 3F1VE
	Description : Reconstructs data-types into a readable, useable format.
	Date : April 27th, 2024
	Liscensing : distribute this however you want, i dont care
Documentation
	local module = require(path.to.module)

	local options = {
		IsClient = false, -- this only changes WaitForChild when Instances in tables are reconstructed.
		AppendVariable = true -- decides whether "local output = " is appended or not
	}

	local Reconstructor = module.new(options)

	local Reconstruct = Reconstructor:Reconstruct({["User"] = {AccountAge = 14, Gold = 5, Location = Vector3.new(1, 1, 1), Spawn = game.Workspace.SpawnLocation}})

	print(Reconstruct) -- outputs "local output = {
		["User"] = {
			["Location"] = Vector3.new(1, 1, 1),
			["Spawn"] = workspace.SpawnLocation,
			["Gold"] = 5,
			["AccountAge"] = 14,
		},"
Use Cases
	This would be best to convert tables to actual code (e.g if you want to get data from an external website and save it instead of using GetAsync() each time)
	
	You could also use this to create a system that could convert data into a format that could be easily read by a human.
]]

local types = script.types

local insert, unpack, sort, remove = table.insert, table.unpack, table.sort, table.remove

local module = {}
module.__index = module

export type ReconstructorOptions = {
	IsClient: boolean?, -- default, false
	AppendVariable: boolean?, -- default, true
	VariableNames: string?, -- ONLY CHANGES CERTAIN TYPES
	-- default, "%type_", to format it differently, just include "%type" in your final string. 
	WrapKeysInBrackets: boolean? -- default, true
	-- when false, tables wont have their key values with brackets
}

function module.new(options: ReconstructorOptions?): Reconstructor
	local Reconstructor = setmetatable({}, module)
	Reconstructor.Options = options or {}
	return Reconstructor
end

local any = types.any

function module.Reconstruct(self: Reconstructor | {[string]: boolean?}, ...: any): (string)
	if not self then return "" end
	local options = self.Options or self
	local t = {...}
	local output = {}

	for index, val in t do
		local Type = typeof(val)
		local type_ = require(types:FindFirstChild(Type) or any)
		if types:FindFirstChild(Type) and types:FindFirstChild(Type):GetAttribute("VariableRequired") then
			local var, source = type_(options, val)
			insert(output, source)
		else
			local source = type_(options, val)
			insert(output, source)
		end
	end

	return unpack(output)
end

function module.SetOptions(self: Reconstructor, options: ReconstructorOptions): ()
	if not self then error("No 'Reconstructor' found!", 2) end
	
	self.Options = options
end

export type Reconstructor = {
	Reconstruct: typeof(module.Reconstruct),
	Options: ReconstructorOptions,
	SetOptions: typeof(module.SetOptions)
}
return module
