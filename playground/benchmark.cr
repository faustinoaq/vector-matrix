require "benchmark"
require "../src/matriz"

M1 = Matriz[
  1, 2, 3, 5,
  4, 7, 1, 2,
  columnas: 4,
  nombre: "M1",
  log: false]

A = Matriz[1, 2, 3, 4, 2, 1, 6, 1, columnas: 2, nombre: "A", log: false]

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

Benchmark.ips do |x|
  x.report("vectores") { M1 * A }
  x.report("LAPACK") { M2 * B }
end
