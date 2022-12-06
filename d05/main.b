#!/usr/bin/env blue

val input = read('input.txt');
val lines = input.split("\n");

fun get_num_stacks(lines) {
    var index = 0;
    for (line in lines) {
        if (line == '') {
            break;
        }
        index += 1;
    }
    var stacks_lines = lines[index-1];
    return to_num(stacks_lines[len(stacks_lines)-2]);
}

fun get_stacks(lines) {
    var stacks = [null];
    var num_stacks = get_num_stacks(lines);
    #println("num_stacks = #{num_stacks}");
    for (i in 1..num_stacks) {
        stacks = append(stacks, []);
    }
    for (line in lines) {
        if (line == '') {
            break;
        }
        for ([i, c] in line) {
            if (c == ' ' or c == '[' or c == ']') {
                continue;
            }
            try {
                to_num(c);
                continue;
            } catch (e) {}
            var stack_index = ((i - 1) / 4)+1;
            stacks[stack_index] = push(stacks[stack_index], c);
            #println("i = #{(i-1) / 4}, c = `#{c}`");
        }
    }
    #println("stacks = #{stacks}");
    return stacks;
}

fun get_move_instructions(lines) {
    var index = 0;
    for (line in lines) {
        if (line == '') {
            break;
        }
        index += 1;
    }
    return lines[(index+1)..<len(lines)]
}

fun parse_move_instructions(move_instructions) {
    var inxs = [];
    for (inx in move_instructions) {
        val items_to_move = to_num(inx.split("move ")[1].split(" ")[0]);
        val index_start = to_num(inx.split("from ")[1].split(" ")[0]);
        val index_end = to_num(inx.split("to ")[1]);
        val element = {'amount_to_move': items_to_move, 'index_start': index_start, 'index_end': index_end}
        inxs = append(inxs, element);
    }
    return inxs;
}

fun pop(list) {
    if (len(list) > 1) {
        val popped_value = list[len(list)-1];
        var new_last_index = len(list)-2;
        if (new_last_index < 1) {
            new_last_index = 0;
        }
        val new_list = list[0..new_last_index]
        return [popped_value, new_list]
    } else {
        return [list[0], []];
    }
}

fun pop_multi(list, qty_to_move) {
    val mid_index = len(list)-qty_to_move;
    var new_list = [];
    if (mid_index > 0) {
        new_list = list[0..<mid_index];
    }
    val popped_value = list[mid_index..<len(list)]
    return [popped_value, new_list];
}

fun part1(lines) {
    var stacks = get_stacks(lines);
    println("stacks = #{stacks}");
    val move_instructions = get_move_instructions(lines);
    #println("move_instructions = #{move_instructions}");
    val move_inxs = parse_move_instructions(move_instructions);
    println("move_inxs = #{move_inxs}");
    for (move_inx in move_inxs) {
        val qty_to_move = move_inx.amount_to_move;
        val from = move_inx.index_start;
        val to = move_inx.index_end;
        for (i in 0..<qty_to_move) {
            println("Moving #{qty_to_move} from #{from}, to #{to}");
            #println("stacks[from] = #{stacks[from]}");
            val value = pop(stacks[from]);
            stacks[from] = value[1];
            #println("after stacks[from] = #{stacks[from]}");
            stacks[to] = append(stacks[to], value[0]);
            #println("stacks = #{stacks}")
        }
    }
    println("stacks after moves = #{stacks}");
    val num_stacks = len(stacks);
    var result = "";
    for (s in 1..<num_stacks) {
        val popped_value = pop(stacks[s]);
        #println("popped_value = #{popped_value[0]}")
        result += popped_value[0];
    }
    println("result = #{result}")
}

fun part2(lines) {
    var stacks = get_stacks(lines);
    println("stacks = #{stacks}");
    val move_instructions = get_move_instructions(lines);
    #println("move_instructions = #{move_instructions}");
    val move_inxs = parse_move_instructions(move_instructions);
    println("move_inxs = #{move_inxs}");
    for (move_inx in move_inxs) {
        val qty_to_move = move_inx.amount_to_move;
        val from = move_inx.index_start;
        val to = move_inx.index_end;
        println("Moving #{qty_to_move} from #{from}, to #{to}");
        val value = pop_multi(stacks[from], qty_to_move);
        stacks[from] = value[1];
        for (e in value[0]) {
            stacks[to] = append(stacks[to], e);
        }
    }
    println("stacks after moves = #{stacks}");
    val num_stacks = len(stacks);
    var result = "";
    for (s in 1..<num_stacks) {
        val popped_value = pop(stacks[s]);
        #println("popped_value = #{popped_value[0]}")
        result += popped_value[0];
    }
    println("result = #{result}")
}

#part1(lines);
part2(lines);