#!/usr/bin/env blue

val input = read('input.txt');
val lines = input.split("\n");

fun part1(lines) {
    var total = 0;
    for (line in lines) {
        val split_line = line.split(",");
        val section1 = split_line[0].split("-"); 
        val section1_lb = section1[0].to_num();
        val section1_ub = section1[1].to_num();
        val section2 = split_line[1].split("-");
        val section2_lb = section2[0].to_num();
        val section2_ub = section2[1].to_num();
        println("section1 = #{section1}, section2 = #{section2}")
        val section1_set = eval("set(#{section1_lb}..#{section1_ub})");
        val section2_set = eval("set(#{section2_lb}..#{section2_ub})");
        println("section1_set = #{section1_set}, section2_set = #{section2_set}")
        val intersect = section1_set & section2_set;
        println("intersect = #{intersect}");
        if (section1_set == intersect or section2_set == intersect) {
            total += 1;
        }
    }
    println("total pairs = #{total}")
}

fun part2(lines) {
    var total = 0;
    for (line in lines) {
        val split_line = line.split(",");
        val section1 = split_line[0].split("-"); 
        val section1_lb = section1[0].to_num();
        val section1_ub = section1[1].to_num();
        val section2 = split_line[1].split("-");
        val section2_lb = section2[0].to_num();
        val section2_ub = section2[1].to_num();
        println("section1 = #{section1}, section2 = #{section2}")
        val section1_set = eval("set(#{section1_lb}..#{section1_ub})");
        val section2_set = eval("set(#{section2_lb}..#{section2_ub})");
        println("section1_set = #{section1_set}, section2_set = #{section2_set}")
        val intersect = section1_set & section2_set;
        println("intersect = #{intersect}");
        if (intersect != set([])) {
            total += 1;
        }
    }
    println("total pairs = #{total}")
}

#part1(lines);
part2(lines);