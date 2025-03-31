defmodule Dengutech.Knowledge do
  @moduledoc """
  The Knowledge context.
  """

  import Ecto.Query, warn: false
  alias Dengutech.Repo

  alias Dengutech.Knowledge.BaseConocimiento

  @doc """
  Returns the list of base_conocimientos.

  ## Examples

      iex> list_base_conocimientos()
      [%BaseConocimiento{}, ...]

  """
  def list_base_conocimientos do
    Repo.all(BaseConocimiento)
  end

  @doc """
  Gets a single base_conocimiento.

  Raises `Ecto.NoResultsError` if the Base conocimiento does not exist.

  ## Examples

      iex> get_base_conocimiento!(123)
      %BaseConocimiento{}

      iex> get_base_conocimiento!(456)
      ** (Ecto.NoResultsError)

  """
  def get_base_conocimiento!(id), do: Repo.get!(BaseConocimiento, id)

  @doc """
  Creates a base_conocimiento.

  ## Examples

      iex> create_base_conocimiento(%{field: value})
      {:ok, %BaseConocimiento{}}

      iex> create_base_conocimiento(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_base_conocimiento(attrs \\ %{}) do
    %BaseConocimiento{}
    |> BaseConocimiento.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a base_conocimiento.

  ## Examples

      iex> update_base_conocimiento(base_conocimiento, %{field: new_value})
      {:ok, %BaseConocimiento{}}

      iex> update_base_conocimiento(base_conocimiento, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_base_conocimiento(%BaseConocimiento{} = base_conocimiento, attrs) do
    base_conocimiento
    |> BaseConocimiento.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a base_conocimiento.

  ## Examples

      iex> delete_base_conocimiento(base_conocimiento)
      {:ok, %BaseConocimiento{}}

      iex> delete_base_conocimiento(base_conocimiento)
      {:error, %Ecto.Changeset{}}

  """
  def delete_base_conocimiento(%BaseConocimiento{} = base_conocimiento) do
    Repo.delete(base_conocimiento)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking base_conocimiento changes.

  ## Examples

      iex> change_base_conocimiento(base_conocimiento)
      %Ecto.Changeset{data: %BaseConocimiento{}}

  """
  def change_base_conocimiento(%BaseConocimiento{} = base_conocimiento, attrs \\ %{}) do
    BaseConocimiento.changeset(base_conocimiento, attrs)
  end
  def save_learning_result({matrix1, matrix2}) do
    # Crear un nuevo registro en la tabla base_conocimiento
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
    data = Map.get(entity, :data) || %{}

    # Extraer matrix1 como pesos
    pesos = Map.get(data, "matrix1") || []

    # Transformar matrix2 en listas de listas
    centros =
      Map.get(data, "matrix2", [])
      |> Enum.map(fn %{"data" => valores, "result" => resultado} -> [valores, resultado] end)

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
