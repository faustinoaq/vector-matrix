require "linalg"

include LA

M2 = GMat[
  [1, 2, 3, 5],
  [4, 7, 1, 2],
]

B = GMat[
  [1, 2],
  [3, 4],
  [2, 1],
  [6, 1],
]

puts "Resultado usando librería LAPACK para matrices:"
puts
pp M2 * B
