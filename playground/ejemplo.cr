require "./matriz"

M1 = Matriz[
  1, 2, 3, 5,
  4, 7, 1, 2,
  columnas: 4,
  nombre: "M1",
  log: true]

A = Matriz[1, 2, 3, 4, 2, 1, 6, 1, columnas: 2, nombre: "A", log: true]

puts "Resultado usando vectores:"

M1 * A
