#!/usr/bin/env blue

val input = read('input.txt');
val lines = input.split("\n");

###
Appreciative of your help yesterday, one Elf gives you an encrypted strategy guide
 (your puzzle input) that they say will be sure to help you win. 
 "The first column is what your opponent is going to play: A for Rock, B for Paper,
  and C for Scissors. The second column--" Suddenly, the Elf is called away to help
   with someone's tent.

The second column, you reason, must be what you should play in response: X for Rock,
 Y for Paper, and Z for Scissors. Winning every time would be suspicious, so the
  responses must have been carefully chosen.

The winner of the whole tournament is the player with the highest score.
 Your total score is the sum of your scores for each round. The score for a single
  round is the score for the shape you selected (1 for Rock, 2 for Paper, and 3
   for Scissors) plus the score for the outcome of the round (0 if you lost, 3
    if the round was a draw, and 6 if you won).
###

# A, X == Rock
# B, Y == Paper
# C, Z == Scissors
val points_map = {'A': 1, 'X': 1, 'B': 2, 'Y': 2, 'C': 3, 'Z': 3};

fun get_points(them, me) {
    val meee = points_map[me];
    # win
    if ((them == 'A' and me == 'Y') or (them == 'B' and me == 'Z') or (them == 'C' and me == 'X')) {
        return meee+6;
    }
    # lose
    if ((me == 'X' and them == 'B') or (me == 'Y' and them == 'C') or (me == 'Z' and them == 'A')) {
        return meee;
    }
    # draw
    if (meee == points_map[them]) {
        return meee+3;
    }
}

fun part1(lines) {
    var total = 0;
    for (line in lines) {
        val them_me = line.split(" ");
        val them = them_me[0];
        val me = them_me[1];
        println("them_me = #{them_me}");
        val points = get_points(them, me);
        println("points = #{points}");
        total += points;
    }
    println("total = #{total}");
}

#part1(lines);

###
The Elf finishes helping with the tent and sneaks back
 over to you. "Anyway, the second column says how the
  round needs to end: X means you need to lose, Y means
   you need to end the round in a draw, and Z means you
    need to win. Good luck!"

The total score is still calculated in the same way, but
 now you need to figure out what shape to choose so the
  round ends as indicated. The example above now goes
   like this:

    In the first round, your opponent will choose Rock (A),
     and you need the round to end in a draw (Y), so you also
      choose Rock. This gives you a score of 1 + 3 = 4.
    In the second round, your opponent will choose Paper (B),
     and you choose Rock so you lose (X) with a score of 1 + 0 = 1.
    In the third round, you will defeat your opponent's Scissors
     with Rock for a score of 1 + 6 = 7.

Now that you're correctly decrypting the ultra top secret strategy guide, you would get a total score of 12.
###


fun get_points_pt2(them, me) {
    # me = X - need to lose
    if (me == 'X') {
        match them {
            'A' => {
                return points_map['C'];
            },
            'B' => {
                return points_map['A'];
            },
            'C' => {
                return points_map['B'];
            },
        };
    }
    # me = Y - need to draw
    if (me == 'Y') {
        return points_map[them]+3;
    }
    # me = Z - need to win
    if (me == 'Z') {
        match them {
            'A' => {
                return points_map['B']+6;
            },
            'B' => {
                return points_map['C']+6;
            },
            'C' => {
                return points_map['A']+6;
            },
        };
    }
}

fun part2(lines) {
    var total = 0;
    for (line in lines) {
        val them_me = line.split(" ");
        val them = them_me[0];
        val me = them_me[1];
        println("them_me = #{them_me}");
        val points = get_points_pt2(them, me);
        println("points = #{points}");
        total += points;
    }
    println("total = #{total}");
}

part2(lines);