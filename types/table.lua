local types = script.Parent

local gsub, format, rep, find = string.gsub, string.format, string.rep, string.find
local insert, remove = table.insert, table.remove
local percentQ = "%q"
local percentQ_ = "[%q]"

function formatName(Inst: Instance): string
	if Inst == game then
		return "game"
	end
	return find(Inst.Name, " ") and format(percentQ_, Inst.Name) or "." .. Inst.Name
end

function getFullName(Inst: Instance, UseWaitForChild: boolean?): string
	if Inst then
		local name = UseWaitForChild and `:WaitForChild({format(percentQ, Inst.Name)})` or formatName(Inst)
		local Parent = Inst

		local ancestors = {}

		repeat
			Parent = Parent.Parent
			insert(ancestors, Parent)
		until Parent == game or Parent == nil

		local previousAncestor;
		for index, ancestor in ancestors do
			if ancestor == game then
				name = "game" .. name
			else
				name = (UseWaitForChild and (ancestor ~= workspace and `:WaitForChild({format(percentQ, ancestor.Name)})` or "." .. workspace.Name) or formatName(ancestor)) .. name
			end

			if ancestor == game then
				name = gsub(name, `game%.{workspace.Name}`, "workspace")
			end

			previousAncestor = ancestor
		end

		return name
	end

	return ""
end

local any = require(types.any)

function formatTableValue(options, a: any, isKey: boolean?, recursed: number?, appendVars: {}?): string
	local Type = typeof(a)
	local module = types:FindFirstChild(Type)

	if Type == "string" then
		return isKey and format(percentQ_, a) or format(percentQ, a)
	elseif Type == "number" then
		return isKey and format("[%i]", a) or a
	elseif Type == "table" then
		return Table(options, a, true, (recursed or 1) - 1)
	elseif Type == "Instance" then
		return getFullName(a, options['IsClient'])
	elseif types:FindFirstChild(Type) and not isKey then
		if module:GetAttribute("VariableRequired") == true then
			local var, s = require(module)(options, a, true, recursed)
			insert(appendVars, s)
			return var
		else
			return require(module)(options, a, true, recursed)
		end
	else
		return isKey and format(percentQ_, any(options, a, true)) or format(percentQ, any(options, a, true))
	end
end

function Table(options, a: {any}, excludeLocal: boolean?, recursed: number?, appendVars: {}?): string
	local appendVars = appendVars or {}
	local source = not (excludeLocal or (not (options['AppendVariable']) or false)) and "local output = {" or "{"

	local recursed = recursed or 1
	local indent = rep("\t", recursed)
	local indent_ = rep("\t", recursed-1)
	local hasKeys = false
	
	for key, value in a do
		hasKeys = true
		value = formatTableValue(options, value, false, recursed + 2, appendVars)
		
		if (options['WrapKeysInBrackets'] == nil and true or options['WrapKeysInBrackets']) then
			key = formatTableValue(options, key, true, recursed + 2) .. " = "
		else
			if typeof(key) ~= "number" then
				key = formatTableValue(options, key, true, recursed + 2) .. " = "
			else
				key = ""
			end
		end
		
		source ..= "\n" .. indent .. key .. value .. `,`
	end

	source ..= `{hasKeys and '\n' or ''}{indent_}}`
	
	return source, (hasKeys and appendVars)
end

return Table
