#!/usr/bin/env blue

val input = read('input.txt');
val lines = input.split("\n");


fun get_marker(line) {
    for (i in 0..(len(line)-4)) {
        val l = line[i..<(i+4)];
        println("l = #{l}");
        var m = {};
        m[l[0]] = true;
        m[l[1]] = true;
        m[l[2]] = true;
        m[l[3]] = true;
        if (len(m) == 4) {
            return i+4;
        }
    }
}

fun get_som_marker(line) {
    val marker_count = 14;
    for (i in 0..(len(line)-marker_count)) {
        val l = line[i..<(i+marker_count)];
        println("l = #{l}");
        var m = {};
        m[l[0]] = true;
        m[l[1]] = true;
        m[l[2]] = true;
        m[l[3]] = true;
        m[l[4]] = true;
        m[l[5]] = true;
        m[l[6]] = true;
        m[l[7]] = true;
        m[l[8]] = true;
        m[l[9]] = true;
        m[l[10]] = true;
        m[l[11]] = true;
        m[l[12]] = true;
        m[l[13]] = true;
        if (len(m) == marker_count) {
            return i+marker_count;
        }
    }
}

fun part1(lines) {
    for (line in lines) {
        println("line = #{line}");
        var marker = get_marker(line);
        println("marker = #{marker}")
    }
}

fun part2(lines) {
    for (line in lines) {
        println("line = #{line}");
        var marker = get_som_marker(line);
        println("som marker = #{marker}")
    }
}

#part1(lines);
part2(lines);