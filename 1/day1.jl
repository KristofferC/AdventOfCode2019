weight_function(n) = n ÷ 3 - 2

function day_one_part_one()
    s = sum(eachline("input.txt")) do line
        n = parse(Int, line)
        weight_function(n)
    end
    return s
end

function day_one_part_two()
    s = sum(eachline("input.txt")) do line
        n = parse(Int, line)
        fuel = weight_function(n)
        tot_fuel = fuel
        while true
            fuel = weight_function(fuel)
            fuel <= 0 && break
            tot_fuel += fuel
        end
        tot_fuel
    end
    return s
end

if abspath(PROGRAM_FILE) == @__FILE__
    s = day_one_part_one()
    @show s
    s = day_one_part_two()
    @show s
end
