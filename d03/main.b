#!/usr/bin/env blue

val input = read('input.txt');
val lines = input.split("\n");

val PRIORITY_ALPHABET = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

fun get_dup_letter(cpt1, cpt2) {
    var x = {};
    for (l in cpt1) {
        x[l] = 0;
    }
    #println('x = #{x}');
    for (l in cpt2) {
        var abc = x[l];
        if (abc == 0) {
            #println("l = #{l}")
            return l;
        }
        #println("abc = #{abc}");
    }
}

fun get_dup_letter_for_group(group) {
    var maps = [];
    for (rucksack in group) {
        var y = {};
        for (l in rucksack) {
            var abc = y[l];
            if (abc == null) {
                y[l] = 0;
            }
        }
        #println("y = #{y}");
        maps = append(maps, y);
    }
    var m1 = maps[0];
    var m2 = maps[1]; 
    var m3 = maps[2];
    for ([k, v] in m1) {
        if (m2[k] != null) {
            if (m3[k] != null) {
                return k;
            }
        }
    }
}

fun part1(lines) {
    var total = 0;
    for (line in lines) {
        val middle = len(line)/2;
        val cpt1 = line.substr(end=middle);
        val cpt2 = line.substr(start=middle);
        println("cpt1 = #{cpt1}, cpt2 = #{cpt2}");
        val dup_letter = get_dup_letter(cpt1, cpt2);
        println("dup_letter = #{dup_letter}");
        val priority_index = PRIORITY_ALPHABET.index_of(dup_letter);
        println("priority_index = #{priority_index}");
        total += priority_index;
    }
    println("total = #{total}")
}

fun part2(lines) {
    val group_count = len(lines)/3;
    println("group_count = #{group_count}");
    var groups = [];
    var i = 0;
    for (true) {
        var group = lines[i..<(i+3)];
        i += 3;
        if (len(groups) == group_count) {
            break;
        }
        groups = append(groups, group);
    }
    var total = 0;
    for (group in groups) {
        println("group = #{group}")
        val dup_letter_for_group = get_dup_letter_for_group(group);
        println("dup_letter_for_group = #{dup_letter_for_group}");
        val indx = PRIORITY_ALPHABET.index_of(dup_letter_for_group);
        total += indx;
    }
    println("total = #{total}")
}

#part1(lines);
part2(lines)