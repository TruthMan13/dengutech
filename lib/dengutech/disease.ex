defmodule Dengutech.Disease do
  @moduledoc """
  The Disease context.
  """

  import Ecto.Query, warn: false
  alias Dengutech.Knowledge
  alias Dengutech.Repo

  alias Dengutech.Disease.Case

  @doc """
  Returns the list of cases.

  ## Examples

      iex> list_cases()
      [%Case{}, ...]

  """
  def list_cases do
    Repo.all(Case)
  end

  @doc """
  Gets a single case.

  Raises `Ecto.NoResultsError` if the Case does not exist.

  ## Examples

      iex> get_case!(123)
      %Case{}

      iex> get_case!(456)
      ** (Ecto.NoResultsError)

  """
  def get_case!(id), do: Repo.get!(Case, id)



  def list_cases_without_diagnosis_and_date do
    from(c in Case,
      select: %{
        id: c.id,
        fever: c.fever,
        headache: c.headache,
        muscle_pain: c.muscle_pain,
        joint_pain: c.joint_pain,
        nausea: c.nausea,
        retrocular_pain: c.retrocular_pain,
        fatigue: c.fatigue,
        swollen_glands: c.swollen_glands,
        abdominal_pain: c.abdominal_pain,
        vomiting: c.vomiting,
        bleeding: c.bleeding,
        respiratory_distress: c.respiratory_distress,
        lethargy: c.lethargy,
        age: c.age,
        region: c.region,
        diagnosis: c.diagnosis
      }
    )
    |> Repo.all()
  end

  @doc """
  Creates a case.

  ## Examples

      iex> create_case(%{field: value})
      {:ok, %Case{}}

      iex> create_case(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_case(attrs \\ %{}) do
    %Case{}
    |> Case.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a case.

  ## Examples

      iex> update_case(case, %{field: new_value})
      {:ok, %Case{}}

      iex> update_case(case, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_case(%Case{} = case, attrs) do
    case
    |> Case.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a case.

  ## Examples

      iex> delete_case(case)
      {:ok, %Case{}}

      iex> delete_case(case)
      {:error, %Ecto.Changeset{}}

  """
  def delete_case(%Case{} = case) do
    Repo.delete(case)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking case changes.

  ## Examples

      iex> change_case(case)
      %Ecto.Changeset{data: %Case{}}

  """
  def change_case(%Case{} = case, attrs \\ %{}) do
    Case.changeset(case, attrs)
  end

  def get_cases_as_tuples do

    # Obtener todos los casos de la tabla `cases`
    cases = list_cases()

    # Procesar cada caso en una tupla
    Enum.map(cases, fn case ->
      diagnosis = case.diagnosis
      rest_of_values   = case
      |> Map.from_struct() # Convierte el struct en un mapa simple, eliminando metadatos.
      |> Map.delete(:__meta__)
      |> Map.drop([:diagnosis, :id, :date_of_onset, :updated_at, :inserted_at]) # Filtra solo los campos necesarios.



      diagnosis_list = List.duplicate(0, 3)

      diagnosis_list = List.replace_at(diagnosis_list, diagnosis, 1)

      {
        Map.values(rest_of_values) |> Enum.map(&(&1 * 1.0)),
        diagnosis_list
      }
    end)
  end
  def execute_learning_and_save do
    # Obtener los datos de `Case` como lista de tuplas
    data_tuples = get_cases_as_tuples()

    # Entero que necesitas para la función learning
   # IO.inspect(data_tuples)

    # Llamar a la función `learning`
    learning_result =SistemaExperto.Learning.learn(data_tuples, 3)
    IO.inspect(learning_result, label: "Estas pasando esto")
    # Guardar el resultado en la base de datos
    Knowledge.save_learning_result(learning_result)
  end
end
