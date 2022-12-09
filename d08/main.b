#!/usr/bin/env blue

val input = read('input.txt');
val lines = input.split("\n");

fun make_grid(lines) {
    var grid = [];
    var index = 0;
    for (line in lines) {
        var l = [to_num(c) for (c in line)];
        grid[index] = l;
        index += 1;
    }
    return grid;
}


fun left_side_is_good(grid, row, col, height) {
    #println("left_side_is_good: row = #{row}, col = #{col}, height = #{height}")
    for (i in 0..<row) {
        #var point = grid[i][col];
        #println("point(#{i},#{col}) = #{point}, height = #{height}")
        var ok = grid[i][col] < height;
        if (not ok) {
            return false;
        }
    }
    return true;
}

fun right_side_is_good(grid, row, rows, col, height) {
    if (row+1 == rows) {
        return false
    }
    for (i in (row+1)..<rows) {
        var ok = grid[i][col] < height;
        if (not ok) {
            return false;
        }
    }
    return true;
}

fun top_to_tree_is_good(grid, col, row, height) {
    if (col == 0) {
        return false;
    }
    for (i in 0..<col) {
        var ok = grid[row][i] < height;
        if (not ok) {
            return false;
        }
    }
    return true;
}

fun bottom_to_tree_is_good(grid, col, cols, row, height) {
    if (col+1 == cols) {
        return false;
    }
    for (i in (col+1)..<cols) {
        var ok = grid[row][i] < height;
        if (not ok) {
            return false;
        }
    }
    return true;
}

#part 2

fun up_trees(grid, row, col, height) {
    var result = 0;
    for (i in (row-1)..0) {
        var point = grid[i][col];
        println("up_trees: (#{i},#{col}) = #{point}, cur_height = #{height}");
        var ok = grid[i][col] < height;
        result += 1;
        if (not ok) {
            break;
        }
    }
    println("returning #{result}")
    return result;
}

fun down_trees(grid, row, rows, col, height) {
    #if (row+1 == rows) {
    #    return false
    #}
    var result = 0;
    for (i in (row+1)..<rows) {
        var point = grid[i][col];
        println("down_trees: (#{i},#{col}) = #{point}, cur_height = #{height}");
        var ok = grid[i][col] < height;
        result += 1;
        if (not ok) {
            break;
        }
    }
    return result;
}

fun left_trees(grid, col, row, height) {
    #if (col == 0) {
    #    return false;
    #}
    var result = 0;
    for (i in (col-1)..0) {
        var point = grid[row][i];
        println("left_trees: (#{row},#{i}) = #{point}, cur_height = #{height}");
        var ok = grid[row][i] < height;
        result += 1;
        if (not ok) {
            break;
        }
    }
    return result;
}

fun right_trees(grid, col, cols, row, height) {
    #if (col+1 == cols) {
    #    return false;
    #}
    var result = 0;
    for (i in (col+1)..<cols) {
        var point = grid[row][i];
        println("right_trees: (#{row},#{i}) = #{point}, cur_height = #{height}");
        var ok = grid[row][i] < height;
        result += 1;
        if (not ok) {
            break;
        }
    }
    return result;
}

fun part1(lines) {
    val grid = make_grid(lines);
    for (g in grid) {
        println(g)
    }
    # these are the outside ones
    # index 0 and len(grid) are always visible
    # inside each, 0 and len(line) are always visible
    val rows = len(grid);
    val cols = len(grid[0]);
    #println("rows = #{rows}, cols = #{cols}");
    var result = 0;
    for (row in 0..<rows) {
        for (col in 0..<cols) {
            var height = grid[row][col];
            println("row = #{row}, col = #{col}, height = #{height}");
            if (row == 0 or col == 0 or row+1 == rows or col+1 == cols) {
                result += 1;
                #println("took short path");
            } else {
                println("row = #{row}, col = #{col}, height = #{height}");
                if(left_side_is_good(grid, row, col, height) 
                    or right_side_is_good(grid, row, rows, col, height)
                    or top_to_tree_is_good(grid, col, row, height)
                    or bottom_to_tree_is_good(grid, col, cols, row, height)) {
                    result += 1;
                }
            }
        }
    }
    println(result);
}

fun part2(lines) {
    val grid = make_grid(lines);
    for (g in grid) {
        println(g)
    }
    val rows = len(grid);
    val cols = len(grid[0]);
    #println("rows = #{rows}, cols = #{cols}");
    var result_map = {};
    for (row in 0..<rows) {
        for (col in 0..<cols) {
            var height = grid[row][col];
            var m = "#{row},#{col}";
            println("row = #{row}, col = #{col}, height = #{height}");
            if (row == 0 or col == 0 or row+1 == rows or col+1 == cols) {
                # continue here doesnt get it to the last line
                #result_map[m] = 0;
                println("took short path");
            } else {
                println("row = #{row}, col = #{col}, height = #{height}");
                var up = up_trees(grid, row, col, height);
                var down = down_trees(grid, row, rows, col, height);
                var left = left_trees(grid, col, row, height);
                var right = right_trees(grid, col, cols, row, height);
                println("up = #{up}, down = #{down}, left = #{left}, right = #{right}")
                var scenic_score = up * down * left * right;
                println("m = #{m}, scenic_score = #{scenic_score}")
                result_map[m] = scenic_score;
                #println("result_map = #{result_map}");
            }
        }
    }
    println("result_map = #{result_map}");
    var max = 0;
    for ([k, v] in result_map) {
        if (v > max) {
            max = v;
        }
    }
    println("MAX = #{max}")
}

#part1(lines);
part2(lines);