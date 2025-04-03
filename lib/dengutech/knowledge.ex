defmodule Dengutech.Knowledge do


  import Ecto.Query, warn: false
  alias Dengutech.Repo

  alias Dengutech.Knowledge.BaseConocimiento


  def list_base_conocimientos do
    Repo.all(BaseConocimiento)
  end


  def get_base_conocimiento!(id), do: Repo.get!(BaseConocimiento, id)


  def create_base_conocimiento(attrs \\ %{}) do
    %BaseConocimiento{}
    |> BaseConocimiento.changeset(attrs)
    |> Repo.insert()
  end


  def update_base_conocimiento(%BaseConocimiento{} = base_conocimiento, attrs) do
    base_conocimiento
    |> BaseConocimiento.changeset(attrs)
    |> Repo.update()
  end


  def delete_base_conocimiento(%BaseConocimiento{} = base_conocimiento) do
    Repo.delete(base_conocimiento)
  end

  def change_base_conocimiento(%BaseConocimiento{} = base_conocimiento, attrs \\ %{}) do
    BaseConocimiento.changeset(base_conocimiento, attrs)
  end
  def save_learning_result({matrix1, matrix2}) do

    %BaseConocimiento{}
    |> BaseConocimiento.changeset(%{
      data: %{
        "matrix1" => matrix1,
        "matrix2" => matrix2
      }
    })
    |> Repo.insert()
  end

  def get_first_record_from_base do
    case Repo.one(from b in BaseConocimiento, limit: 1) do
      nil ->
        {:error, "No se encontraron registros en la tabla base_de_conocimiento"}
      entity ->
        IO.inspect(entity, label: "Registro obtenido desde la base de datos")
        {:ok, entity}
    end
  end
  def transform_record_to_tuple(entity) do
    IO.puts("estamos aqui")

    data = Map.get(entity, :data) || %{}

    IO.puts("Y ahora aqui")
    pesos = Map.get(data, "matrix1") || []

    IO.puts("tambien aqui")
    centros =
      Map.get(data, "matrix2", [])

      IO.puts("He aqui el problema")
    IO.inspect(pesos, label: "Pesos procesados (matrix1)")
    IO.inspect(centros, label: "Centros procesados como listas de listas (matrix2)")

    if is_list(pesos) and is_list(centros) do
      {pesos, centros}
    else
      {:error, "Los datos no están en el formato esperado"}
    end
  end


  def fetch_and_transform_data do
    case get_first_record_from_base() do
      {:error, reason} ->
        IO.inspect(reason, label: "Error en la Base de Conocimiento")
        {:error, reason}

      {:ok, entity} ->
        transform_record_to_tuple(entity)
    end
  end
end
