# --- Day 10: Adapter Array ---
#
# Patched into the aircraft's data port, you discover weather
# forecasts of a massive tropical storm.  Before you can figure out
# whether it will impact your vacation plans, however, your device
# suddenly turns off!
#
# Its battery is dead.
#
# You'll need to plug it in.  There's only one problem: the charging
# outlet near your seat produces the wrong number of jolts.  Always
# prepared, you make a list of all of the joltage adapters in your
# bag.
#
# Each of your joltage adapters is rated for a specific output joltage
# (your puzzle input).  Any given adapter can take an input 1, 2, or 3
# jolts lower than its rating and still produce its rated output
# joltage.
#
# In addition, your device has a built-in joltage adapter rated for 3
# jolts higher than the highest-rated adapter in your bag.  (If your
# adapter list were 3, 9, and 6, your device's built-in adapter would
# be rated for 12 jolts.)
#
# Treat the charging outlet near your seat as having an effective
# joltage rating of 0.
#
# Since you have some time to kill, you might as well test all of your
# adapters.  Wouldn't want to get to your resort and realize you can't
# even charge your device!
#
# If you use every adapter in your bag at once, what is the
# distribution of joltage differences between the charging outlet, the
# adapters, and your device?
#
# For example, suppose that in your bag, you have adapters with the
# following joltage ratings:
#
# 16
# 10
# 15
# 5
# 1
# 11
# 7
# 19
# 6
# 12
# 4
#
# With these adapters, your device's built-in joltage adapter would be
# rated for 19 + 3 = 22 jolts, 3 higher than the highest-rated
# adapter.
#
# Because adapters can only connect to a source 1-3 jolts lower than
# its rating, in order to use every adapter, you'd need to choose them
# like this:
#
# - The charging outlet has an effective rating of 0 jolts, so the
#   only adapters that could connect to it directly would need to have
#   a joltage rating of 1, 2, or 3 jolts.  Of these, only one you have
#   is an adapter rated 1 jolt (difference of 1).
# - From your 1-jolt rated adapter, the only choice is your 4-jolt
#   rated adapter (difference of 3).
# - From the 4-jolt rated adapter, the adapters rated 5, 6, or 7 are
#   valid choices.  However, in order to not skip any adapters, you
#   have to pick the adapter rated 5 jolts (difference of 1).
# - Similarly, the next choices would need to be the adapter rated 6
#   and then the adapter rated 7 (with differences of 1 and 1).
# - The only adapter that works with the 7-jolt rated adapter is the
#   one rated 10 jolts (difference of 3).
# - From 10, the choices are 11 or 12; choose 11 (difference of 1) and
#   then 12 (difference of 1).
# - After 12, the only valid adapter has a rating of 15 (difference of
#   3), then 16 (difference of 1), then 19 (difference of 3).
# - Finally, your device's built-in adapter is always 3 higher than
#   the highest adapter, so its rating is 22 jolts (always a
#   difference of 3).
#
# In this example, when using every adapter, there are 7 differences
# of 1 jolt and 5 differences of 3 jolts.
#
# Here is a larger example:
#
# 28
# 33
# 18
# 42
# 31
# 14
# 46
# 20
# 48
# 47
# 24
# 23
# 49
# 45
# 19
# 38
# 39
# 11
# 1
# 32
# 25
# 35
# 8
# 17
# 7
# 9
# 4
# 2
# 34
# 10
# 3
#
# In this larger example, in a chain that uses all of the adapters,
# there are 22 differences of 1 jolt and 10 differences of 3 jolts.
#
# Find a chain that uses all of your adapters to connect the charging
# outlet to your device's built-in adapter and count the joltage
# differences between the charging outlet, the adapters, and your
# device.  What is the number of 1-jolt differences multiplied by the
# number of 3-jolt differences?

Input = open("10.in").read.split.map(&:to_i).sort

deltas = [Input[0]] + (0...Input.length-1).map {|i| Input[i+1]-Input[i] } + [3]
puts deltas.count(1)*deltas.count(3)

# --- Part Two ---
#
# To completely determine whether you have enough adapters, you'll
# need to figure out how many different ways they can be arranged.
# Every arrangement needs to connect the charging outlet to your
# device.  The previous rules about when adapters can successfully
# connect still apply.
#
# The first example above (the one that starts with 16, 10, 15)
# supports the following arrangements:
#
# (0), 1, 4, 5, 6, 7, 10, 11, 12, 15, 16, 19, (22)
# (0), 1, 4, 5, 6, 7, 10, 12, 15, 16, 19, (22)
# (0), 1, 4, 5, 7, 10, 11, 12, 15, 16, 19, (22)
# (0), 1, 4, 5, 7, 10, 12, 15, 16, 19, (22)
# (0), 1, 4, 6, 7, 10, 11, 12, 15, 16, 19, (22)
# (0), 1, 4, 6, 7, 10, 12, 15, 16, 19, (22)
# (0), 1, 4, 7, 10, 11, 12, 15, 16, 19, (22)
# (0), 1, 4, 7, 10, 12, 15, 16, 19, (22)
#
# (The charging outlet and your device's built-in adapter are shown in
# parentheses.)  Given the adapters from the first example, the total
# number of arrangements that connect the charging outlet to your
# device is 8.
#
# The second example above (the one that starts with 28, 33, 18) has
# many arrangements.  Here are a few:
#
# (0), 1, 2, 3, 4, 7, 8, 9, 10, 11, 14, 17, 18, 19, 20, 23, 24, 25,
# 28, 31, 32, 33, 34, 35, 38, 39, 42, 45, 46, 47, 48, 49, (52)
#
# (0), 1, 2, 3, 4, 7, 8, 9, 10, 11, 14, 17, 18, 19, 20, 23, 24, 25,
# 28, 31, 32, 33, 34, 35, 38, 39, 42, 45, 46, 47, 49, (52)
#
# (0), 1, 2, 3, 4, 7, 8, 9, 10, 11, 14, 17, 18, 19, 20, 23, 24, 25,
# 28, 31, 32, 33, 34, 35, 38, 39, 42, 45, 46, 48, 49, (52)
#
# (0), 1, 2, 3, 4, 7, 8, 9, 10, 11, 14, 17, 18, 19, 20, 23, 24, 25,
# 28, 31, 32, 33, 34, 35, 38, 39, 42, 45, 46, 49, (52)
#
# (0), 1, 2, 3, 4, 7, 8, 9, 10, 11, 14, 17, 18, 19, 20, 23, 24, 25,
# 28, 31, 32, 33, 34, 35, 38, 39, 42, 45, 47, 48, 49, (52)
#
# (0), 3, 4, 7, 10, 11, 14, 17, 20, 23, 25, 28, 31, 34, 35, 38, 39,
# 42, 45, 46, 48, 49, (52)
#
# (0), 3, 4, 7, 10, 11, 14, 17, 20, 23, 25, 28, 31, 34, 35, 38, 39,
# 42, 45, 46, 49, (52)
#
# (0), 3, 4, 7, 10, 11, 14, 17, 20, 23, 25, 28, 31, 34, 35, 38, 39,
# 42, 45, 47, 48, 49, (52)
#
# (0), 3, 4, 7, 10, 11, 14, 17, 20, 23, 25, 28, 31, 34, 35, 38, 39,
# 42, 45, 47, 49, (52)
#
# (0), 3, 4, 7, 10, 11, 14, 17, 20, 23, 25, 28, 31, 34, 35, 38, 39,
# 42, 45, 48, 49, (52)
#
# In total, this set of adapters can connect the charging outlet to
# your device in 19208 distinct arrangements.
#
# You glance back down at your bag and try to remember why you brought
# so many adapters; there must be more than a trillion valid ways to
# arrange them!  Surely, there must be an efficient way to count the
# arrangements.
#
# What is the total number of distinct ways you can arrange the
# adapters to connect the charging outlet to your device?
#
# --------------------
#
# Ordering all adapters, we observe only differences of 1 and 3.
# Adapters that differ by 3 jolts must be used, so the differences of
# 3 must remain.  This leaves disjoint sequences of consecutive
# differences of 1 to manipulate.  Each such sequence produces a
# number of arrangements by selectively removing some or all of the
# corresponding adapters, the product of which numbers yields the
# total number of arrangements.
#
# We noticed that the number of arrangements as a function of sequence
# length n corresponds to OEIS A000073, the Tribonacci numbers
# T_{n-1}.  Specifically, T_0 = 1, T_1 = 2, T_2 = 4, and generally
# T_n = T_{n-1} + T_{n-2} + T_{n-3}.  To see why, notice that each
# arrangement can be represented as a binary string of length n-1 in
# which 0/1 indicates if the corresponding adapter is removed/kept.
# For example:
#
#                     required          required
#                     |                 |
# adapters:     1     4     5     6     7     10
# differences:     3     1     1     1     3
# remove/keep:             0/1   0/1
#
# For a sequence of length 3 there are 4 binary strings, 00, 01, 10,
# and 11, and T_2 = 4.
#
# All binary strings are admissible except those containing three
# consecutive 0s, since those would lead to differences larger than 3.
# Partition admissible strings of length n into three groups by how
# they begin:
#
# A: 1...
# B: 01...
# C: 001...
#
# Let the numbers of strings in these groups be a_n, b_n, and c_n
# respectively, so that T_n = a_n + b_n + c_n.  Any admissible string
# of length n-1 can follow the initial 1 in a string from group A, and
# conversely the string following the initial 1 in any string from
# group A is an admissible string of length n-1, hence
# a_n = a_{n-1} + b_{n-1} + c_{n-1}.  Any string of length n-1
# starting with 1 can follow the initial 0 in group B, hence
# b_n = a_{n-1}, and similarly c_n = a_{n-2}.  These recurrences
# produce the Tribonacci equation above.

raise if deltas.uniq.sort != [1, 3]

def tribonacci(n)
  if n == 0
    1
  elsif n == 1
    2
  elsif n == 2
    4
  else
    tribonacci(n-1) + tribonacci(n-2) + tribonacci(n-3)
  end
end

n1s = 0 # number of 1s
product = 1
deltas.each do |d|
  if d == 1
    n1s += 1
  elsif d == 3 # last delta is 3, so this will be executed for last sequence
    product *= tribonacci(n1s-1) if n1s > 0
    n1s = 0
  end
end
puts product
