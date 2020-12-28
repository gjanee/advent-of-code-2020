# --- Day 20: Jurassic Jigsaw ---
#
# The high-speed train leaves the forest and quickly carries you
# south.  You can even see a desert in the distance!  Since you have
# some spare time, you might as well see if there was anything
# interesting in the image the Mythical Information Bureau satellite
# captured.
#
# After decoding the satellite messages, you discover that the data
# actually contains many small images created by the satellite's
# camera array.  The camera array consists of many cameras; rather
# than produce a single square image, they produce many smaller square
# image tiles that need to be reassembled back into a single image.
#
# Each camera in the camera array returns a single monochrome image
# tile with a random unique ID number.  The tiles (your puzzle input)
# arrived in a random order.
#
# Worse yet, the camera array appears to be malfunctioning: each image
# tile has been rotated and flipped to a random orientation.  Your
# first task is to reassemble the original image by orienting the
# tiles so they fit together.
#
# To show how the tiles should be reassembled, each tile's image data
# includes a border that should line up exactly with its adjacent
# tiles.  All tiles have this border, and the border lines up exactly
# when the tiles are both oriented correctly.  Tiles at the edge of
# the image also have this border, but the outermost edges won't line
# up with any other tiles.
#
# For example, suppose you have the following nine tiles:
#
# Tile 2311:
# ..##.#..#.
# ##..#.....
# #...##..#.
# ####.#...#
# ##.##.###.
# ##...#.###
# .#.#.#..##
# ..#....#..
# ###...#.#.
# ..###..###
#
# Tile 1951:
# #.##...##.
# #.####...#
# .....#..##
# #...######
# .##.#....#
# .###.#####
# ###.##.##.
# .###....#.
# ..#.#..#.#
# #...##.#..
#
# Tile 1171:
# ####...##.
# #..##.#..#
# ##.#..#.#.
# .###.####.
# ..###.####
# .##....##.
# .#...####.
# #.##.####.
# ####..#...
# .....##...
#
# Tile 1427:
# ###.##.#..
# .#..#.##..
# .#.##.#..#
# #.#.#.##.#
# ....#...##
# ...##..##.
# ...#.#####
# .#.####.#.
# ..#..###.#
# ..##.#..#.
#
# Tile 1489:
# ##.#.#....
# ..##...#..
# .##..##...
# ..#...#...
# #####...#.
# #..#.#.#.#
# ...#.#.#..
# ##.#...##.
# ..##.##.##
# ###.##.#..
#
# Tile 2473:
# #....####.
# #..#.##...
# #.##..#...
# ######.#.#
# .#...#.#.#
# .#########
# .###.#..#.
# ########.#
# ##...##.#.
# ..###.#.#.
#
# Tile 2971:
# ..#.#....#
# #...###...
# #.#.###...
# ##.##..#..
# .#####..##
# .#..####.#
# #..#.#..#.
# ..####.###
# ..#.#.###.
# ...#.#.#.#
#
# Tile 2729:
# ...#.#.#.#
# ####.#....
# ..#.#.....
# ....#..#.#
# .##..##.#.
# .#.####...
# ####.#.#..
# ##.####...
# ##..#.##..
# #.##...##.
#
# Tile 3079:
# #.#.#####.
# .#..######
# ..#.......
# ######....
# ####.#..#.
# .#...#.##.
# #.#####.##
# ..#.###...
# ..#.......
# ..#.###...
#
# By rotating, flipping, and rearranging them, you can find a square
# arrangement that causes all adjacent borders to line up:
#
# #...##.#.. ..###..### #.#.#####.
# ..#.#..#.# ###...#.#. .#..######
# .###....#. ..#....#.. ..#.......
# ###.##.##. .#.#.#..## ######....
# .###.##### ##...#.### ####.#..#.
# .##.#....# ##.##.###. .#...#.##.
# #...###### ####.#...# #.#####.##
# .....#..## #...##..#. ..#.###...
# #.####...# ##..#..... ..#.......
# #.##...##. ..##.#..#. ..#.###...
#
# #.##...##. ..##.#..#. ..#.###...
# ##..#.##.. ..#..###.# ##.##....#
# ##.####... .#.####.#. ..#.###..#
# ####.#.#.. ...#.##### ###.#..###
# .#.####... ...##..##. .######.##
# .##..##.#. ....#...## #.#.#.#...
# ....#..#.# #.#.#.##.# #.###.###.
# ..#.#..... .#.##.#..# #.###.##..
# ####.#.... .#..#.##.. .######...
# ...#.#.#.# ###.##.#.. .##...####
#
# ...#.#.#.# ###.##.#.. .##...####
# ..#.#.###. ..##.##.## #..#.##..#
# ..####.### ##.#...##. .#.#..#.##
# #..#.#..#. ...#.#.#.. .####.###.
# .#..####.# #..#.#.#.# ####.###..
# .#####..## #####...#. .##....##.
# ##.##..#.. ..#...#... .####...#.
# #.#.###... .##..##... .####.##.#
# #...###... ..##...#.. ...#..####
# ..#.#....# ##.#.#.... ...##.....
#
# For reference, the IDs of the above tiles are:
#
# 1951    2311    3079
# 2729    1427    2473
# 2971    1489    1171
#
# To check that you've assembled the image correctly, multiply the IDs
# of the four corner tiles together.  If you do this with the
# assembled tiles from the example above, you get
# 1951 * 3079 * 2971 * 1171 = 20899048083289.
#
# Assemble the tiles into an image.  What do you get if you multiply
# together the IDs of the four corner tiles?
#
# --------------------
#
# Corner tiles have 2 shared borders, edge tiles have 3, and interior
# tiles have 4.

T, B, L, R = 0, 1, 2, 3 # sides: top, bottom, left, right

class Tile

  @@all = []

  def Tile.all
    @@all
  end

  # border_matches: border => [Tile, ...]
  # (both a border and its reverse are indexed)
  @@border_matches = Hash.new {|h,k| h[k] = [] }

  attr_reader :id, :image, :borders

  def initialize(description)
    d = description.split("\n")
    @id = d[0].match(/^Tile (\d+):$/)[1].to_i
    @image = d[1..-1]
    @borders = [
      @image[0],                       # T
      @image[-1],                      # B
      @image.map {|row| row[0] }.join, # L
      @image.map {|row| row[-1] }.join # R
    ]
    @borders.each do |b|
      @@border_matches[b] << self
      @@border_matches[b.reverse] << self
    end
    # cut borders off of image for part 2
    @image = @image[1..-2].map {|row| row[1..-2] }
    @@all << self
  end

  def num_shared_borders
    @borders.count {|b| @@border_matches[b].length > 1 }
  end

end

open("20.in").read.split("\n\n").each do |description|
  Tile.new(description)
end

corners = Tile.all.select {|t| t.num_shared_borders == 2 }
puts corners.map(&:id).reduce(:*)

# --- Part Two ---
#
# Now, you're ready to check the image for sea monsters.
#
# The borders of each tile are not part of the actual image; start by
# removing them.
#
# In the example above, the tiles become:
#
# .#.#..#. ##...#.# #..#####
# ###....# .#....#. .#......
# ##.##.## #.#.#..# #####...
# ###.#### #...#.## ###.#..#
# ##.#.... #.##.### #...#.##
# ...##### ###.#... .#####.#
# ....#..# ...##..# .#.###..
# .####... #..#.... .#......
#
# #..#.##. .#..###. #.##....
# #.####.. #.####.# .#.###..
# ###.#.#. ..#.#### ##.#..##
# #.####.. ..##..## ######.#
# ##..##.# ...#...# .#.#.#..
# ...#..#. .#.#.##. .###.###
# .#.#.... #.##.#.. .###.##.
# ###.#... #..#.##. ######..
#
# .#.#.### .##.##.# ..#.##..
# .####.## #.#...## #.#..#.#
# ..#.#..# ..#.#.#. ####.###
# #..####. ..#.#.#. ###.###.
# #####..# ####...# ##....##
# #.##..#. .#...#.. ####...#
# .#.###.. ##..##.. ####.##.
# ...###.. .##...#. ..#..###
#
# Remove the gaps to form the actual image:
#
# .#.#..#.##...#.##..#####
# ###....#.#....#..#......
# ##.##.###.#.#..######...
# ###.#####...#.#####.#..#
# ##.#....#.##.####...#.##
# ...########.#....#####.#
# ....#..#...##..#.#.###..
# .####...#..#.....#......
# #..#.##..#..###.#.##....
# #.####..#.####.#.#.###..
# ###.#.#...#.######.#..##
# #.####....##..########.#
# ##..##.#...#...#.#.#.#..
# ...#..#..#.#.##..###.###
# .#.#....#.##.#...###.##.
# ###.#...#..#.##.######..
# .#.#.###.##.##.#..#.##..
# .####.###.#...###.#..#.#
# ..#.#..#..#.#.#.####.###
# #..####...#.#.#.###.###.
# #####..#####...###....##
# #.##..#..#...#..####...#
# .#.###..##..##..####.##.
# ...###...##...#...#..###
#
# Now, you're ready to search for sea monsters!  Because your image is
# monochrome, a sea monster will look like this:
#
#                   #
# #    ##    ##    ###
#  #  #  #  #  #  #
#
# When looking for this pattern in the image, the spaces can be
# anything; only the # need to match.  Also, you might need to rotate
# or flip your image before it's oriented correctly to find sea
# monsters.  In the above image, after flipping and rotating it to the
# appropriate orientation, there are two sea monsters (marked with O):
#
# .####...#####..#...###..
# #####..#..#.#.####..#.#.
# .#.#...#.###...#.##.O#..
# #.O.##.OO#.#.OO.##.OOO##
# ..#O.#O#.O##O..O.#O##.##
# ...#.#..##.##...#..#..##
# #.##.#..#.#..#..##.#.#..
# .###.##.....#...###.#...
# #.####.#.#....##.#..#.#.
# ##...#..#....#..#...####
# ..#.##...###..#.#####..#
# ....#.##.#.#####....#...
# ..##.##.###.....#.##..#.
# #...#...###..####....##.
# .#.##...#.##.#.#.###...#
# #.###.#..####...##..#...
# #.###...#.##...#.##O###.
# .O##.#OO.###OO##..OOO##.
# ..O#.O..O..O.#O##O##.###
# #.#..##.########..#..##.
# #.#####..#.#...##..#....
# #....##..#.#########..##
# #...#.....#..##...###.##
# #..###....##.#...##.##.#
#
# Determine how rough the waters are in the sea monsters' habitat by
# counting the number of # that are not part of a sea monster.  In the
# above example, the habitat's water roughness is 273.
#
# How many # are not part of a sea monster?

Matching_side = { T => B, B => T, L => R, R => L }

TD = Tile.all.first.image.length     # tile dimension in pixels
GD = Math.sqrt(Tile.all.length).to_i # grid dimension in tiles
ID = GD*TD                           # final image dimension in pixels

def generic_rotate90(image)
  # Rotates a square image 90 degrees clockwise.
  d = image.length
  new_image = d.times.map { "x"*d }
  (0...d).each do |r|
    (0...d).each do |c|
      new_image[c][d-1-r] = image[r][c]
    end
  end
  new_image
end

class Tile

  def rotate90
    @image = generic_rotate90(@image)
    @borders[T], @borders[B], @borders[L], @borders[R] =
      @borders[L].reverse, @borders[R].reverse, @borders[B], @borders[T]
  end

  def flip_tb
    @image.reverse!
    @borders[T], @borders[B], @borders[L], @borders[R] =
      @borders[B], @borders[T], @borders[L].reverse, @borders[R].reverse
  end

  def flip_lr
    @image.each do |row|
      row.reverse!
    end
    @borders[T], @borders[B], @borders[L], @borders[R] =
      @borders[T].reverse, @borders[B].reverse, @borders[R], @borders[L]
  end

  def unmatched_sides
    [T, B, L, R].select {|s| @@border_matches[@borders[s]].length == 1 }
  end

  def Tile.adjacent(to, side)
    # Returns the tile adjacent to the indicated side of tile `to`.
    # The returned tile is oriented to match the border on the side of
    # `to`.
    b = to.borders[side]
    t = @@border_matches[b].find {|t| t.id != to.id }
    while ![b, b.reverse].member?(t.borders[Matching_side[side]])
      t.rotate90
    end
    if t.borders[Matching_side[side]] != b
      if side == T || side == B
        t.flip_lr
      else
        t.flip_tb
     end
    end
    t
  end

end

grid = GD.times.map { [nil]*GD } # grid of tiles

# Pick any corner, and orient it to serve as the upper left corner.
grid[0][0] = corners[0]
grid[0][0].flip_tb if !grid[0][0].unmatched_sides.member?(T)
grid[0][0].flip_lr if !grid[0][0].unmatched_sides.member?(L)

# Fill out the remainder of the grid in reading order.
(0...GD).each do |r|
  if r > 0
    grid[r][0] = Tile.adjacent(grid[r-1][0], B)
  end
  (1...GD).each do |c|
    grid[r][c] = Tile.adjacent(grid[r][c-1], R)
  end
end

# Form the final image.
image = []
grid.each do |row| # for each row in grid
  TD.times do |r|  # for each row of pixels within tile
    image << row.map {|t| t.image[r] }.join
  end
end

Monster = [
  "                  # ",
  "#    ##    ##    ###",
  " #  #  #  #  #  #   "
]
MH, MW = Monster.length, Monster[0].length # monster height, width

Mask = Monster.each_with_index.flat_map {|row,r|
  row.chars.each_with_index.flat_map {|char,c| char == "#" ? [[r,c]] : [] }
}

# Try all image orientations to find the monsters.  The dihedral group
# D_4 can be cycled through by successively rotating the image 90
# degrees, inserting a flip midway.
8.times do |i|
  count = 0
  (0...ID-MH+1).each do |r|
    (0...ID-MW+1).each do |c|
      # We assume sea monsters don't overlap.
      if Mask.all? {|dr,dc| image[r+dr][c+dc] == "#" }
        count += 1
        Mask.each do |dr,dc|
          image[r+dr][c+dc] = "O"
        end
      end
    end
  end
  break if count > 0
  if i == 3
    image.reverse!
  else
    image = generic_rotate90(image)
  end
end

puts image.map {|row| row.count("#") }.reduce(:+)
