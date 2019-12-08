check_streak(streak, max_strak) = streak >= 2 && streak <= max_streak

function ismatch(n, max_streak)
    digs = digits(n)
    length(digs) == 6 || return false

    same_adjacent = false
    prev_dig = last(digs)

    streak = 1
    matching_digit = prev_dig

    for d in Iterators.drop(Iterators.reverse(digs), 1)
        d < prev_dig && return false
        if d == prev_dig
            streak += 1
        else
            same_adjacent &= check_streak(streak, max_streak)
            streak = 1
        end
        prev_dig = d
    end
    same_adjacent &= check_streak(streak, max_streak)
    return same_adjacent
end

day_four_part_one(input="153517-630395") = run(input, 6)
day_four_part_two(input="153517-630395") = run(input, 2)

function run(input, max_streak)
    min, max = parse.(Int, split(input, '-'))
    n_matches = 0
    for n in min:max
        n_matches += ismatch_v2(n, max_streak)
    end
    return n_matches
end
