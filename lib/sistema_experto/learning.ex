defmodule SistemaExperto.Learning do
  alias SistemaExperto.Learning


  def learn(data, k) do
    casos = Learning.formato_caso(data)

    centros_ancho =clusterisacion(casos,k)
    matriz_pesos = matriz_random(k, 15)

    muevo_peso =
      Enum.reduce(1..150, matriz_pesos, fn _, matriz_pesos ->
        casos_de_aprendizaje = Enum.random(data)

        {caso, esperado} = casos_de_aprendizaje
        salida = Learning.matriz_activacion(caso, centros_ancho, matriz_pesos)

        gradiente = calcular_gradiente(salida, esperado)

        actualizacion_matriz(gradiente, esperado, matriz_pesos)
      end)

    {muevo_peso, centros_ancho}
  end


  def predict(caso, centros_ancho, pesos) do
    IO.inspect(caso, label: "Caso recibido")
    IO.inspect(centros_ancho, label: "Centros recibidos")
    IO.inspect(pesos, label: "Pesos recibidos")

    matriz = matriz_activacion(caso, centros_ancho, pesos)
    IO.inspect(matriz, label: "Matriz de Activación")
    max_value = Enum.max(matriz)

    Enum.map(matriz, fn x ->
      if x == max_value do
        1
      else
        0
      end
    end)
  end

  def clusterisacion(caso, k) do
    centros = SistemaExperto.Kmean.cluster(caso, k)
    centros_anchos = SistemaExperto.Learning.calcular_ancho(centros)
    anchos = Enum.map(centros_anchos, fn [_, ancho] -> ancho end)

    # Bucle while que se ejecuta hasta que no haya ceros en 'anchos'
    if Enum.any?(anchos, fn ancho -> ancho == 0 end) do
      IO.puts("Se encontraron ceros en los anchos, recalculando...")
      clusterisacion(caso, k) # Recursión para recalcular
    else
      IO.puts("Anchos válidos encontrados.")
      centros_anchos
    end
  end

  def formato_caso(data) do
    Enum.map(data, fn {caso, _} -> caso end)
  end

  def generacion_neuronas(centros) do
    Enum.map(centros, fn [centroide, _] -> centroide end)
  end

  def generacion_anchos(anchos) do
    Enum.map(anchos, fn [_, anchos] -> anchos end)
  end


  def derivada_funcion_gauseana() do
  end

  def matriz_activacion(caso, centros_anchos, matriz_peso) do
    matriz_activacion =
      for centroAnchos <- centros_anchos do
        Learning.funcion_gauseanada(caso, centroAnchos)
      end

    Learning.maltiplicacion(matriz_peso, matriz_activacion)
  end

  def distancia_euclidia(primer_punto, segundo_punto) do
    Enum.zip(primer_punto, segundo_punto)
    |> Enum.map(fn {x, y} -> (x - y) ** 2 end)
    |> Enum.sum()
    |> :math.sqrt()
  end


  def calcular_ancho(centroides) do
    [clusters, vecinos] = centroides

    Enum.map(clusters, fn centro ->
      SistemaExperto.Learning.vecinos_media(centro, vecinos)
    end)
  end


  def vecinos_media(centro, vecinos) do

    IO.inspect(centro, label: "Centro actual")
    IO.inspect(vecinos, label: "Vecinos recibidos")

    distancias = SistemaExperto.Learning.calcular_mediana(centro, vecinos)
    IO.inspect(distancias, label: "Distancias calculadas")


    if Enum.any?(distancias, &is_list/1) do
      raise "Las distancias contienen listas anidadas: #{inspect(distancias)}"
    end

    distancias_de_kvecinos = Enum.sort(distancias) |> Enum.reverse() |> Enum.take(3)
    IO.inspect(distancias_de_kvecinos, label: "Distancias de k vecinos")

    if length(distancias_de_kvecinos) == 0 do
      raise "No se encontraron distancias válidas para el centro #{inspect(centro)}"
    end

    media = Enum.sum(distancias_de_kvecinos) / length(distancias_de_kvecinos)
    IO.inspect(media, label: "Media calculada para el centro #{inspect(centro)}")

    [centro, media]
  end

  def calcular_mediana(cluster, vecinos) do
    Enum.map(vecinos, fn vecino ->
      SistemaExperto.Kmean.distancia_euclidiana([cluster, vecino])
    end)
  end


  def funcion_gauseanada(data, anchos) do
    [centro, ancho] = anchos

    -(SistemaExperto.Kmean.distancia_euclidiana([data, centro]) ** 2 / (2 * ancho ** 2))
    |> :math.exp()
  end


  def matriz_random(a, b) do
    for _ <- 1..a do
      for _ <- 1..b do
        :rand.uniform()
      end
    end
  end


  def maltiplicacion(lista, activacion) do
    ordenada = Enum.map(lista, fn elemento -> Enum.zip(elemento, activacion) end)

    formato =
      for lista_formato <- ordenada do
        Enum.map(lista_formato, &Tuple.to_list/1)
      end

    for primer <- formato do
      Enum.map(primer, fn fila -> Enum.reduce(fila, 1, fn x, acc -> x * acc end) end)
      |> Enum.sum()
    end
  end


  def croos_entropy(resultado_real, resultado_esperado) do
    resultado =
      Enum.zip(resultado_real, resultado_esperado)
      |> Enum.map(&Tuple.to_list/1)
      |> Enum.map(fn [primero, segundo] -> segundo * :math.log(primero) end)
      |> Enum.sum()

    -resultado
  end


  def calcular_gradiente(matriz_activacion, resultados_esperados) do
    derivada_cross_entropy_loss(matriz_activacion, resultados_esperados)
  end

  def derivada_cross_entropy_loss(matriz_activacion, esperado) do
    Enum.zip(matriz_activacion, esperado)
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(fn [predicho, esperado] -> predicho - esperado end)
  end

  def derivada_funcion_gauseana(centros_anchos, entrada) do
    Enum.map(centros_anchos, fn [centro, ancho] ->
      -1 *
        (distancia_euclidia(centro, entrada) * ancho ** 2 *
           :math.exp(-(distancia_euclidia(centro, entrada) ** 2) / 2 * ancho ** 2))
    end)
  end


  def multipliacion(matriz_grande, matriz_pequeña) do
    Enum.map(matriz_pequeña, fn elemento -> Enum.map(matriz_grande, fn x -> x * elemento end) end)
  end


  def multiplicacion_matriz_escalar(esclara, matriz) do
    for(fila <- matriz) do
      for(columna <- fila) do
        Enum.map(columna, fn elemento -> elemento * esclara end)
      end
    end
  end

  def multiplicacion_escalar(matriz, escalar) do
    Enum.map(matriz, fn fila -> Enum.map(fila, fn elemento -> elemento * escalar end) end)
  end

  def actualizacion_matriz(gradiente, esperado, matriz_peso) do
    casi = Enum.map(gradiente, fn elemento -> elemento * 0.01 end)

    Enum.zip(casi, esperado)
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(fn [x, y] -> x * y end)

    Enum.zip(matriz_peso, casi)
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(fn [x, y] -> Enum.map(x, fn z -> z - y end) end)
  end

  def resta_matrices(matriz1, matriz2) do
    matriz =
      Enum.zip(matriz1, matriz2)
      |> Enum.map(&Tuple.to_list/1)

    Enum.map(matriz, fn [fila1, fila2] ->
      Enum.zip(fila1, fila2)
      |> Enum.map(&Tuple.to_list/1)
      |> Enum.map(fn [elemento1, elemento2] -> elemento1 - elemento2 end)
    end)
  end


end
