# For the purpose of this challenge, the N queens problem consists of putting one queen on every column (labeled a, b, c, ...) of an NxN chessboard, such that no two queens are in the same row or diagonal. An example valid solution for N = 6 is:

# 6  . . Q . . .

# 5  . . . . . Q

# 4  . Q . . . .

# 3  . . . . Q .

# 2  Q . . . . .

# 1  . . . Q . .

#    a b c d e f

# arr =
# [[n0, n1, n2, n3],
#  [n0, n1, n2, n3],
#  [n0, n1, n2, n3],
#  [n0, n1, n2, n3]]
# valid queen positon: arr[0][n3]
# invalid-- all other indexes in the same inner array-- arr[0],
# diagonol: arr[1][2], arr[2][1], arr[3][0]

# check the inner array using .one?
# check for diagonol: note the index of the queen in the first array
# from 1 up to the length of the nested array
# set a counter at 1
# check if the queen position - counter is false
# increment the counter until the queen position - the counter is < 0

# In chess notation, the squares with queens in this solution are called a2, b4, c6, d1, e3, and f5. We'll represent solutions by listing the rows that each column's queen appears in from left to right, so this solution is represented as the array [2, 4, 6, 1, 3, 5].

# problem: given an array of n length, check if the integers in the array represent a valid row number where each queen can reside for that column position (array index), without the queen being repeated in any row or any diagonal
# given an array of n length, create an array of arrays (nested array with two dimensions), where the inner arrays represent a row of the board and indexes that are the same represent columns in a board
# represent a queen with a value of true
def create_board(array)
  num = array.length
  board = Array.new(num) { Array.new(num, false) }
  array.each_with_index { |board_position, row| board[row][board_position - 1] = true }
  board
end

def q_check(array)
  board = create_board(array)
  true_indexes = board.map { |row| row.index(true) }
  return false unless true_indexes.uniq.length == true_indexes.length
  first_queen_index = board[0].index(true)
  counter = 1
  # left diagonal check
  board[1..-1].each do |row|
    return false if row[first_queen_index - counter]
    counter += 1
    break if first_queen_index - counter < 0
  end
  # right diagonal check
  counter = 1
  board[1..-1].each do |row|
    return false if row[first_queen_index + counter]
    counter += 1
    break if first_queen_index + counter == board.length
  end
  true
end

# p create_board([4, 2, 7, 3, 6, 8, 5, 1])

# [[n0, n1, n2, q, n4, n5, n6, n7],
#  [n0, n1, n2, n3, n4, n5, n6, n7],
#  [n0, n1, n2, n3, n4, n5, n6, n7],
#  [n0, n1, n2, n3, n4, n5, n6, n7],
#  [n0, n1, n2, n3, n4, n5, n6, n7],
#  [n0, n1, n2, n3, n4, n5, n6, n7],
#  [n0, n1, n2, n3, n4, n5, n6, n7],
#  [n0, n1, n2, n3, n4, n5, n6, n7]]

# 8  . q . . . . . .

# 7  . . . . q . . .

# 6  . . . . . . . q

# 5  q . . . . . . .

# 4  . . . q . . . .

# 3  . . . . . . q .

# 2  . . q . . . . .

# 1  . . . . . q . .

#    a b c d e f g h

# p q_check([4, 2, 7, 3, 6, 8, 5, 1]) == true
# p q_check([2, 5, 7, 4, 1, 8, 6, 3]) == true
# p q_check([5, 3, 1, 4, 2, 8, 6, 3]) == false
p q_check([5, 8, 2, 4, 7, 1, 3, 6]) == false
# p q_check([4, 3, 1, 8, 1, 3, 5, 2]) == false
