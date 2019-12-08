function read_input(debug, size_x, size_y)
    layers = Matrix{Int}[]
    file = joinpath(@__DIR__, "input" * (debug ? "_debug" : "") * ".txt")
    n_layers = 1
    io = IOBuffer(chomp(read(file, String)))
    while !eof(io)
        layer = zeros(Int, size_x, size_y)
        for y in 1:size_y
            for x in 1:size_x
                layer[x, y] = parse(Int, read(io, Char))
            end
        end
        push!(layers, layer)
        n_layers += 1
    end
    return layers
end

function day_8_part_one()
    layers = read_input(false, 25, 6)
    min_zeros = typemax(Int)
    local min_layer
    for layer in layers
        n_zeros = count(iszero, layer)
        if n_zeros < min_zeros
            min_layer = layer
            min_zeros = n_zeros
        end
    end
    return count(isone, min_layer) * count(==(2), min_layer)
end

function day_8_part_two(debug)
    size_x, size_y = 25, 6
    layers = read_input(debug, size_x, size_y)
    final_image = fill(2, size(layers[1]))
    for layer in 1:length(layers)
        for y in 1:size_y
            for x in 1:size_x
                curr_color = layers[layer][x, y]
                if final_image[x, y] == 2
                    final_image[x, y] = curr_color
                end
            end
        end
    end
    data = map(x -> x == 0 ? ' ' : '█', final_image)
    for y in 1:size(data, 2)
        for x in 1:size(data, 1)
            print(data[x, y])
        end
        println()
    end

end

