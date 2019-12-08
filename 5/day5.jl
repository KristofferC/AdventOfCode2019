using OffsetArrays

function read_program()
    file_content = read(joinpath(@__DIR__, "input.txt"), String)
    codes = parse.(Int, split(file_content, ','))
    return OffsetVector(codes, 0:(length(codes)-1))
end

function day_5_part_one()
    program = read_program()
    return run_program(program)
end

function run_program(program)
    pc = 0
    output = 0
    while true
        opcode = program[pc]
        opcode == 99 && break
        if !(output == nothing || output == 0)
            @show output
            error("intmachine not working properly")
        end
        pc, output = handle_opcode(program, pc, opcode)
    end
    return output
end


function extract_value(program, pc, mode)
    instr = program[pc]
    return mode == 0 ? program[instr] : instr
end

function extract_value(program, pc, mode)
    instr = program[pc]
    return mode == 0 ? program[instr] : instr
end

extract_mode(digs, c) = checkbounds(Bool, digs, c) ? digs[c] : 0

function handle_opcode(program, pc, macro_op)
    # Use digits!
    digs = digits(macro_op)
    opcode = extract_mode(digs, 1) + extract_mode(digs, 2) * 10
    if opcode == 1
        mode_a, mode_b = extract_mode(digs, 3), extract_mode(digs, 4)
        val_a, val_b, pos_res = extract_value(program, pc+1, mode_a), extract_value(program, pc+2, mode_b), extract_value(program, pc+3, 1)
        program[pos_res] = val_a + val_b
        return pc + 4, nothing
    elseif opcode == 2
        mode_a, mode_b = extract_mode(digs, 3), extract_mode(digs, 4)
        val_a, val_b, pos_res = extract_value(program, pc+1, mode_a), extract_value(program, pc+2, mode_b), extract_value(program, pc+3, 1)
        program[pos_res] = val_a * val_b
        return pc + 4, nothing
    elseif opcode == 3
        @assert length(digs) ==1
         print("Give input: ")
         l = readline(stdin)
         v = parse(Int, l)
        #v = 5
        pos_res = extract_value(program, pc+1, 1)
        program[pos_res] = v
        return pc + 2, nothing
    elseif opcode == 4
        mode_a = extract_mode(digs, 3)
        val_a = extract_value(program, pc+1, mode_a)
        return pc+2, val_a
    elseif opcode == 5
        mode_a, mode_b = extract_mode(digs, 3), extract_mode(digs, 4)
        val_a, val_b = extract_value(program, pc+1, mode_a), extract_value(program, pc+2, mode_b)
        if val_a != 0
            return val_b, nothing
        else
            return pc+3, nothing
        end
    elseif opcode == 6
        mode_a, mode_b = extract_mode(digs, 3), extract_mode(digs, 4)
        val_a, val_b = extract_value(program, pc+1, mode_a), extract_value(program, pc+2, mode_b)
        if val_a == 0
            return val_b, nothing
        else
            return pc+3, nothing
        end
    elseif opcode == 7
        mode_a, mode_b = extract_mode(digs, 3), extract_mode(digs, 4)
        val_a, val_b, pos_res = extract_value(program, pc+1, mode_a), extract_value(program, pc+2, mode_b), extract_value(program, pc+3, 1)
        if val_a < val_b
            program[pos_res] = 1
        else
            program[pos_res] = 0
        end
        return pc+4, nothing
    elseif opcode == 8
        mode_a, mode_b = extract_mode(digs, 3), extract_mode(digs, 4)
        val_a, val_b, pos_res = extract_value(program, pc+1, mode_a), extract_value(program, pc+2, mode_b), extract_value(program, pc+3, 1)
        if val_a == val_b
            program[pos_res] = 1
        else
            program[pos_res] = 0
        end
        return pc+4, nothing
    else
        error("unknown opcode ", opcode)
    end
end

