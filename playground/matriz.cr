# Copy of src/matrix.cr to do benchmarking
# This version doesn't print to output
record Matriz, vector : Array(Int32), columnas : Int32, filas : Int32, nombre : String do
  def +(otra : Matriz)
    sumar(otra, '+') { |k| vector[k] + otra.vector[k] }
  end

  def -(otra : Matriz)
    sumar(otra, '-') { |k| vector[k] - otra.vector[k] }
  end

  def valida?
    vector.size % columnas == 0
  end

  private def mismo_tamaño?(otra : Matriz)
    vector.size == otra.vector.size && columnas == otra.columnas
  end

  private def compatible?(otra : Matriz)
    columnas == otra.filas
  end

  private def sumar(otra : Matriz, operador)
    v = [] of Int32
    if mismo_tamaño? otra
      k = 0
      while k < vector.size
        v << yield k
        k += 1
      end
    else
      raise "ERROR: matrices deben tener mismo tamaño"
    end
    Matriz.new(v, columnas, filas, @nombre + otra.@nombre)
  end

  def *(otra : Matriz)
    if compatible? otra
      multiplicar(otra)
    else
      raise "ERROR: matriz incompatible"
    end
  end

  private def multiplicar(otra : Matriz)
    otro = Channel(Int32).new
    spawn do
      i = 0
      c = otra.columnas
      f = otra.filas
      while i < filas
        j = 0
        while j < c
          k = 0
          while k < f
            otro.send otra.vector[(k * c) + j]
            k += 1
          end
          j += 1
        end
        i += 1
      end
    end
    r = [] of Int32
    v = [] of Int32
    j = 0
    while j < filas
      i = 0
      while i < otra.columnas
        k = 0
        while k < columnas
          v << vector[(j * columnas) + k] * otro.receive
          k += 1
          if k % columnas == 0
            r << v.sum
            v.clear
          end
        end
        i += 1
      end
      j += 1
    end
    Matriz.new(r, otra.columnas, filas, @nombre + otra.@nombre)
  end

  def self.[](*args, columnas, nombre = "")
    vector = args.to_a
    filas = vector.size / columnas
    Matriz.new(vector, columnas, filas, nombre).tap do |matriz|
      raise "Matriz inválida" unless matriz.valida?
    end
  end
end
