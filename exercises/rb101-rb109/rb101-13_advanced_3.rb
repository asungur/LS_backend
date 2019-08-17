=begin
Write a method that takes a 3 x 3 matrix in Array of Arrays format and
returns the transpose of the original matrix. Note that there is a
Array#transpose method that does this -- you may not use it for this exercise. 
You also are not allowed to use the Matrix class from the standard library.
Your task is to do this yourself.
=end


matrix = [
  [1, 5, 8],
  [4, 7, 2],
  [3, 9, 6]
]

def transpose(mtrx)
  row = mtrx.length
  col = mtrx[0].length
  col_check = mtrx.select { |l| l.length != col}
  return "ERROR!" if col_check != []
  new = []
  col.times do |i|
    temp_row = []
    row.times do |j|
      temp_row << mtrx[j][i]
    end
    new << temp_row
  end
  new
end

new_matrix = transpose(matrix)

p new_matrix == [[1, 4, 3], [5, 7, 9], [8, 2, 6]]
p matrix == [[1, 5, 8], [4, 7, 2], [3, 9, 6]]