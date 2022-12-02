#!/usr/bin/env blue

val input = read('input.txt');
val lines = input.split("\n");

var elf_calories = {};
var cur_elf = 1;

println("len(lines) = #{len(lines)}");
for (line in lines) {
    println("type(line) = #{type(line)}, type(lines) = #{type(lines)}");
    if (line == '') {
        cur_elf+=1;
        println("hit continue")
        continue;
    }
    if (elf_calories[cur_elf] == null) {
        elf_calories[cur_elf] = 0;
    }
    elf_calories[cur_elf] = elf_calories[cur_elf] + line.to_num();
    println("line = #{line}");
}

println("elf_calories = #{elf_calories}");

var max = 0;
var max1 = 0;
var max2 = 0;
var maxes = []
for ([elf, calories] in elf_calories) {
    if (calories > max2) {
        if (calories > max1) {
            if (calories > max) {
                var tmp = max;
                max = calories;
                max2 = max1;
                max1 = tmp;
                println("elf = #{elf}, calories = #{calories}");
                continue;
            }
            var tmp = max1;
            max1 = calories;
            println("elf = #{elf}, calories = #{calories}");
            max2 = tmp;
            continue;
        }
        max2 = calories;
        println("elf = #{elf}, calories = #{calories}");
    }
}
println("max = #{max}, max1 = #{max1}, max2 = #{max2}")
#import math
#println(math.sum([max, max1, max2]));

println(max+max1+max2);