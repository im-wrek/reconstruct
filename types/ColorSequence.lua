local ColorSequenceKeypoint_ = require(script.Parent.ColorSequenceKeypoint)

local table_ = require(script.Parent.table)

local gsub = string.gsub

return function(options, a: ColorSequence, excludeLocal: boolean?, recursed: number?): string
	local recursed = recursed or 1
	local source = not (excludeLocal or (not (options['AppendVariable']) or false)) and "local output = ColorSequence.new({" or "ColorSequence.new({"
	local convertedSequence = a.Keypoints

	for i, sequence in convertedSequence do
		convertedSequence[i] = ColorSequenceKeypoint_(options, sequence, true)
	end

	source ..= gsub(gsub(table_(options, convertedSequence, true, recursed - 1), `"`, ""), "{(.*)}", "%1")

	source ..= "})"
	return source
end