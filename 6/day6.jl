function read_input(debug=false)
    all_planets = Dict{String, Union{Nothing, String}}()
    for line in readlines(joinpath(@__DIR__, "input" * (debug ? "_debug" : "") * ".txt"))
        center, orbiter = split(line, ")")
        all_planets[orbiter] = center
        if !(haskey(all_planets, center))
            all_planets[center] = nothing
        end
    end
    return all_planets
end

function count_orbits(all_planets, planet)
    s = 0
    while planet !== nothing
        planet = all_planets[planet]
        s += 1
    end
    return s
end

function day_6_part_one(debug=true)
    planets = read_input(debug)
    s = 0
    # This recalculates things a bunch of time but whatever
    for (planet, _) in planets
        v = count_orbits(planets, planet)
        s += v-1
    end
    return s
end

function collect_to_root(all_planets, planet)
    path = String[]
    while planet !== nothing
        planet = all_planets[planet]
        if planet !== nothing
            push!(path, planet)
        end
    end
    return path
end

# First find the earliest common orbitroot
function day_6_part_two(debug=true)
    planets = read_input(debug)
    my_path = collect_to_root(planets, "YOU")
    sant_path = collect_to_root(planets, "SAN")
    sant_path_set = Set(sant_path)
    local common, len
    for (idx, path) in enumerate(my_path)
        if path in sant_path_set
            common = path
            len = idx
            break
        end
    end

    len2 = findfirst(isequal(common), sant_path)
    return len + len2 - 2
end
