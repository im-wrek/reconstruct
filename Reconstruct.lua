--[[
THIS MODULE IS RECOMMENDED FOR USE IN STUDIOS COMMAND BAR, YOU DONT HAVE TO THOUGH

Information
	Reconstruct
	Version : V.0.1
	Author : 3F1VE
	Description : Reconstructs data-types into a readable, useable format.
	Date : May 4th, 2024
	Liscensing : distribute this however you want, i dont care
Use Cases
	This would be best to convert tables to actual code (e.g if you want to get data from an external website and save it instead of using GetAsync() each time)
	
	You could also use this to create a system that could convert data into a format that could be easily read by a human.
]]

local types = script.types

local insert, unpack, sort, remove = table.insert, table.unpack, table.sort, table.remove

local module = {}
module.__index = module

export type ReconstructorOptions = {
	IsClient: boolean?,
	AppendVariable: boolean?,
	VariableNames: string?,
	WrapKeysInBrackets: boolean?,
	ReconstructInstances: boolean?
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
		
		
		local a, b = type_(options, val)
		local source = a
		if b then
			if typeof(b) == "table" then
				for index, var in b do
					source = var .. "\n" .. source
				end
				source = "\n" .. source
			else
				source = b
			end
		end

		insert(output, source)
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
