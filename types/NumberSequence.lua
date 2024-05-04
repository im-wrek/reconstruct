local table_ = require(script.Parent.table)

local NumberSequenceKeypoint_ = require(script.Parent.NumberSequenceKeypoint)
local gsub = string.gsub

return function(options, a: NumberSequence, excludeLocal: boolean?, recursed: number?): string
	local recursed = recursed or 1
	local source = not (excludeLocal or (not (options['AppendVariable']) or false)) and "local output = NumberSequence.new({" or "NumberSequence.new({"

	local convertedSequence = a.Keypoints

	for i, sequence in convertedSequence do
		convertedSequence[i] = NumberSequenceKeypoint_(options, sequence, true)
	end

	source ..= gsub(gsub(table_(options, convertedSequence, true, recursed - 1), `"`, ""), "{(.*)}", "%1")

	source ..= "})"
	return source
end