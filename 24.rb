# --- Day 24: Lobby Layout ---
#
# Your raft makes it to the tropical island; it turns out that the
# small crab was an excellent navigator.  You make your way to the
# resort.
#
# As you enter the lobby, you discover a small problem: the floor is
# being renovated.  You can't even reach the check-in desk until
# they've finished installing the new tile floor.
#
# The tiles are all hexagonal; they need to be arranged in a hex grid
# with a very specific color pattern.  Not in the mood to wait, you
# offer to help figure out the pattern.
#
# The tiles are all white on one side and black on the other.  They
# start with the white side facing up.  The lobby is large enough to
# fit whatever pattern might need to appear there.
#
# A member of the renovation crew gives you a list of the tiles that
# need to be flipped over (your puzzle input).  Each line in the list
# identifies a single tile that needs to be flipped by giving a series
# of steps starting from a reference tile in the very center of the
# room.  (Every line starts from the same reference tile.)
#
# Because the tiles are hexagonal, every tile has six neighbors: east,
# southeast, southwest, west, northwest, and northeast.  These
# directions are given in your list, respectively, as e, se, sw, w,
# nw, and ne.  A tile is identified by a series of these directions
# with no delimiters; for example, esenee identifies the tile you land
# on if you start at the reference tile and then move one tile east,
# one tile southeast, one tile northeast, and one tile east.
#
# Each time a tile is identified, it flips from white to black or from
# black to white.  Tiles might be flipped more than once.  For
# example, a line like esew flips a tile immediately adjacent to the
# reference tile, and a line like nwwswee flips the reference tile
# itself.
#
# Here is a larger example:
#
# sesenwnenenewseeswwswswwnenewsewsw
# neeenesenwnwwswnenewnwwsewnenwseswesw
# seswneswswsenwwnwse
# nwnwneseeswswnenewneswwnewseswneseene
# swweswneswnenwsewnwneneseenw
# eesenwseswswnenwswnwnwsewwnwsene
# sewnenenenesenwsewnenwwwse
# wenwwweseeeweswwwnwwe
# wsweesenenewnwwnwsenewsenwwsesesenwne
# neeswseenwwswnwswswnw
# nenwswwsewswnenenewsenwsenwnesesenew
# enewnwewneswsewnwswenweswnenwsenwsw
# sweneswneswneneenwnewenewwneswswnese
# swwesenesewenwneswnwwneseswwne
# enesenwswwswneneswsenwnewswseenwsese
# wnwnesenesenenwwnenwsewesewsesesew
# nenewswnwewswnenesenwnesewesw
# eneswnwswnwsenenwnwnwwseeswneewsenese
# neswnwewnwnwseenwseesewsenwsweewe
# wseweeenwnesenwwwswnew
#
# In the above example, 10 tiles are flipped once (to black), and 5
# more are flipped twice (to black, then back to white).  After all of
# these instructions have been followed, a total of 10 tiles are
# black.
#
# Go through the renovation crew's list and determine which tiles they
# need to flip.  After all of the instructions have been followed, how
# many tiles are left with the black side up?
#
# --------------------
#
# We employ the tripartite coordinate system from
# https://www.redblobgames.com/grids/hexagons/#neighbors-cube.

Deltas = {
  "e"  => [1, -1, 0],
  "se" => [0, -1, 1],
  "sw" => [-1, 0, 1],
  "w"  => [-1, 1, 0],
  "nw" => [0, 1, -1],
  "ne" => [1, 0, -1]
}

black = Hash.new(false) # coordinate => true if black

open("24.in").each do |l|
  pos = [0, 0, 0]
  l.scan(/e|se|sw|w|nw|ne/).each do |dir|
    pos[0] += Deltas[dir][0]
    pos[1] += Deltas[dir][1]
    pos[2] += Deltas[dir][2]
  end
  black[pos] = !black[pos]
end

puts black.values.count(true)

# --- Part Two ---
#
# The tile floor in the lobby is meant to be a living art exhibit.
# Every day, the tiles are all flipped according to the following
# rules:
#
# - Any black tile with zero or more than 2 black tiles immediately
#   adjacent to it is flipped to white.
# - Any white tile with exactly 2 black tiles immediately adjacent to
#   it is flipped to black.
#
# Here, tiles immediately adjacent means the six tiles directly
# touching the tile in question.
#
# The rules are applied simultaneously to every tile; put another way,
# it is first determined which tiles need to be flipped, then they are
# all flipped at the same time.
#
# In the above example, the number of black tiles that are facing up
# after the given number of days has passed is as follows:
#
# Day 1: 15
# Day 2: 12
# Day 3: 25
# Day 4: 14
# Day 5: 23
# Day 6: 28
# Day 7: 41
# Day 8: 37
# day 9: 49
# day 10: 37
#
# Day 20: 132
# Day 30: 259
# Day 40: 406
# Day 50: 566
# Day 60: 788
# Day 70: 1106
# Day 80: 1373
# Day 90: 1844
# Day 100: 2208
#
# After executing this process a total of 100 times, there would be
# 2208 black tiles facing up.
#
# How many tiles will be black after 100 days?
#
# --------------------
#
# This part is a repeat of day 17 and the logic described there
# applies here as well.  We change the representation of black tiles
# from a hash that maps coordinates to true/false values, to a set
# that stores the coordinates of black tiles (only).

require "set"

def cycle(black)
  counts = Hash.new(0)
  black.each do |coord|
    Deltas.values.each do |delta|
      n = [coord[0]+delta[0], coord[1]+delta[1], coord[2]+delta[2]]
      counts[n] += 1
    end
  end
  new_black = Set.new
  counts.each do |coord,v|
    if black.member?(coord)
      new_black << coord if v == 1 || v == 2
    else
      new_black << coord if v == 2
    end
  end
  new_black
end

black = Set.new(black.select {|coord,tf| tf }.map(&:first))
100.times do
  black = cycle(black)
end
puts black.length
