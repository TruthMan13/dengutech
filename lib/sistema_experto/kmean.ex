defmodule SistemaExperto.Kmean do

  def cluster(data, k) do
    centroides = Enum.take_random(data,k)




    ciclo(data,centroides)
  end

defp ciclo(datos, centroides) do
      asignacion =asignacion_de_puntos(datos, centroides)
      nuevos_centroides = atualizacion_de_centroide(centroides,asignacion)

      if (centroides ==nuevos_centroides)do
        [nuevos_centroides,asignacion]
      else
        ciclo(datos, nuevos_centroides)
      end
end

def asignacion_de_puntos(puntos, centroides) do
  Enum.map(puntos, fn punto ->[centroide_mas_cercano(punto, centroides),punto]end)
end
def centroide_mas_cercano(punto, centroides) do
  Enum.min_by(centroides, fn centroide->distancia_euclidiana([punto,centroide])end)
end

def distancia_euclidiana([punto1, punto2]) do

  punto2 = List.flatten(punto2)
  IO.inspect(punto2, label: "Punto 2 después de aplanar")
  Enum.zip(punto1, punto2)
  |> Enum.map(fn {x, y} ->
    (x - y) ** 2
  end)
  |> Enum.sum()
  |> :math.sqrt()
end
def atualizacion_de_centroide(centroides, asignacion)do
  actualizacion =  Enum.map(centroides, fn cluster->Enum.filter(asignacion,fn
       [punto,_]-> punto==cluster end)
        |> Enum.map(fn[_,dato]->dato end)
      end)
    Enum.map(actualizacion,fn datos_asignados -> mediana(datos_asignados) end)
  end




def mediana(puntos) do
  Enum.zip(puntos)
  |> Enum.map(&Tuple.to_list/1)
  |> Enum.map(fn cordenada ->Enum.sum(cordenada)/length(cordenada) end)
end

end
