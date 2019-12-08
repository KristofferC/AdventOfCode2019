using OffsetArrays

function read_program()
    file_content = read(joinpath(@__DIR__, "input.txt"), String)
    codes = parse.(Int, split(file_content, ','))
    return OffsetVector(codes, 0:(length(codes)-1))
end

function day_two_part_one()
    program = read_program()
    program[1] = 12
    program[2] = 2
    return run_program(program)
end

function day_two_part_two(target=19690720)
    original_program = read_program()
    for noun in 0:99
        for verb in 0:99
            program = copy(original_program)
            program[1] = noun
            program[2] = verb
            result = run_program(program)
            if result == target
                return 100*noun + verb
            end
        end
    end
    error("no verb+nount pair found that yields ", target)
end

function run_program(program)
    pc = 0
    while true
        opcode = program[pc]
        opcode == 99 && return program[0]
        pc = handle_opcode(program, pc, opcode)
    end
end

function handle_opcode(program, pc, opcode)
    pos_a, pos_b, pos_res = program[pc+1], program[pc+2], program[pc+3]
    val_a, val_b = program[pos_a], program[pos_b]
    if opcode == 1
        program[pos_res] = val_a + val_b
    elseif opcode == 2
        program[pos_res] = val_a * val_b
    else
        error("unknown opcode ", opcode)
    end
    return pc + 4
end

