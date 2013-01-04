# 532146
# 416253
# 653412
# 125364
# 241635
# 364521

HEIGTHS = [
  [5,3,2,1,4,6],
  [4,1,6,2,5,3],
  [6,5,3,4,1,2],
  [1,2,5,3,6,4],
  [2,4,1,6,3,5],
  [3,6,4,5,2,1],
]

COORDS = {
  1 => [[0,3],[1,1],[2,4],[3,0],[4,2],[5,5]],
  2 => [[0,2],[1,3],[2,5],[3,1],[4,0],[5,4]],
  3 => [[0,1],[1,5],[2,2],[3,3],[4,4],[5,0]],
  4 => [[0,4],[1,0],[2,3],[3,5],[4,1],[5,2]],
  5 => [[0,0],[1,4],[2,1],[3,2],[4,5],[5,3]],
  6 => [[0,5],[1,2],[2,0],[3,4],[4,3],[5,1]],
}

blocks = %w[
  P1 P2 P3 P4 P5 P6
  R1 R2 R3 R4 R5 R6
  G1 G2 G3 G4 G5 G6
  Y1 Y2 Y3 Y4 Y5 Y6
  B1 B2 B3 B4 B5 B6
  O1 O2 O3 O4 O5 O6
]

board = Array.new(6) { Array.new(6) }

# Special case for towers fitting where they should not - no solution without it
board[1][2] = 'Y5' 
board[3][2] = 'O6'

blocks = %w[
  P1 P2 P3 P4 P5 P6
  R1 R2 R3 R4 R5 R6
  G1 G2 G3 G4 G5 G6
  Y1 Y2 Y3 Y4 Y6
  B1 B2 B3 B4 B5 B6
  O1 O2 O3 O4 O5
]

def color(piece)
  piece.nil? ? '-': piece[0]
end

def height(piece)
  piece[1].to_i
end

def print_board(board)
  board.each do |row|
    puts row.map { |pos| pos.nil? ? '--' : pos }.join('')
  end
end

def available_coords(height, board)
  COORDS[height].select { |r,c| board[r][c].nil? }
end

def valid?(board, row, col, color)
  row_colors = board[row].map { |e| color(e) }
  col_colors = board.transpose[col].map { |e| color(e) }

  !(row_colors + col_colors).include?(color)
end

def duplicate(board)
  board.map do |row|
    row.dup
  end
end

def solve(board, blocks)
  if blocks.empty?
    puts 'SOLUTION'
    print_board(board)
    # exit(0)
  else
    new_blocks = blocks.dup
    next_piece = new_blocks.shift

    available_coords(height(next_piece), board).each do |r,c|
      if valid?(board, r, c, color(next_piece))
        new_board = duplicate(board)
        new_board[r][c] = next_piece
        solve(new_board, new_blocks)
      end
    end
  end
end

solve(board, blocks)
