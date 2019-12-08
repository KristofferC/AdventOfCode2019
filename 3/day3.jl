function read_wire(wire_string::String)
    instructions = Tuple{Char, Int}[]
    for v in split(wire_string, ",")
        dir, amount = v[1], v[2:end]
        push!(instructions, (dir, parse(Int, amount)))
    end
    current_pos = (0, 0)
    locations = Vector{Tuple{Int, Int}}([current_pos])
    for instr in instructions
        dir, amount = instr
        dx, dy = dir == 'R' ?  (1,0)   :
                 dir == 'L' ?  (-1,0)  :
                 dir == 'U' ?  (0, 1)  :
                 dir == 'D' ?  (0,-1) :
                 error("unknown dir ", dir)
        for _ in 1:amount
            current_pos = current_pos .+ (dx, dy)
            push!(locations, current_pos)
        end
    end
    return locations
end

function read_input()
    l = readlines(joinpath(@__DIR__, "input.txt"))
    wire1 = read_wire(l[1])
    wire2 = read_wire(l[2])
    return wire1, wire2
end

function day_three_part_one()
    wire1, wire2 = read_input()
    crosses = intersect(Set(wire1), Set(wire2))
    min_d = typemax(Int)
    for cross in crosses
        d = abs(cross[1]) + abs(cross[2])
        d == 0 && continue
        min_d = min(min_d, d)
    end
    return min_d
end

function day_three_part_two()
    wire1, wire2 = read_input()
    crosses = intersect(Set(wire1), Set(wire2))
    min_t = typemax(Int)
    for cross in crosses
        times_1 = minimum(findall(==(cross), wire1))
        times_2 = minimum(findall(==(cross), wire2))
        # -1 to account for indexing starting at 1
        t = (times_1-1) + (times_2-1)
        t == 0 && continue
        min_t = min(min_t, t)
    end
    return min_t
end
