function setcombos(mem, floatmask, position, register, value)
	if position == 36 then											--if bit 36, set value at register and finish
		mem[register] = value
		return
	elseif (floatmask & ( 1 << position )) >> position == 1 then	--if mask is floating at position
		setcombos(mem, floatmask, position + 1, register & ~(1 << position), value)	--set all combinations with bit 0 at position
		setcombos(mem, floatmask, position + 1, register | (1 << position),  value)	--set all combinations with bit 1 at position
	else
		setcombos(mem, floatmask, position + 1, register, value)	--else, continue
	end
end

function solve(part, filename)
	local input = io.open(filename, "rb"):read("*a")
	local mem = {}
	local zeromask, onemask, floatmask = 0, 0, 0
	for line in input:gmatch("[^\r\n]+") do
		if line:match("mask = ") then
			onemask, zeromask, floatmask = 0, 0, 0				--reset all masks
			local position = 35
			line:match("mask = ([X01]+)"):gsub(".", function(c)	--for each char in mask from MSB TO LSB
				if c == "0" then
					zeromask = zeromask | (1 << position)		--if 0, set bit in zeroes mask
				elseif c == "1" then
					onemask = onemask | (1 << position)			--if 1, set bit in ones mask
				elseif part == 2 and c == "X" then
					floatmask = floatmask | (1 << position)		--if X, set bit on floating bits mask (part 2 only)
				end
				position = position - 1
			end)
		else --mem
			local register, value = line:match("mem%[(%d+)%] = (%d+)")
			register, value = tonumber(register), tonumber(value)
			if part == 1 then
				mem[register] = (value | onemask) & ~zeromask
			else
				setcombos(mem, floatmask, 0, register | onemask, value)
			end
		end
	end
	return mem
end

function sum(table)
	local total = 0
	for _, value in pairs(table) do
		total = total + value
	end
	return total
end

-- print("Part 1:",sum(solve(1, "day14-p1sample.txt")))
-- print("Part 2:",sum(solve(2, "day14-p2sample.txt")))
print("Part 1:",sum(solve(1, "day14.txt")))
print("Part 2:",sum(solve(2, "day14.txt")))