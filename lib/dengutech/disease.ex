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
  def is_table_empty? do
    Repo.aggregate(Case, :count, :id) == 0
  end


  def execute_learning_and_save do
    data =
      [
        {[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.35, 0.07], [0, 1, 0]},

        {[1.0, 1.0, 1.0, 1.0, 0.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.28, 0.08], [0, 1, 0]},

        {[1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.42, 0.07], [0, 1, 0]},

        {[1.0, 1.0, 1.0, 0.0, 1.0, 1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.25, 0.08], [0, 1, 0]},

        {[1.0, 1.0, 1.0, 1.0, 1.0, 0.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.31, 0.01], [0, 1, 0]},

        {[1.0, 0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.48, 0.07], [0, 1, 0]},

        {[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.22, 0.08], [0, 1, 0]},

        {[1.0, 1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.39, 0.01], [0, 1, 0]},

        {[1.0, 1.0, 1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.29, 0.07], [0, 1, 0]},
        {[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.45, 0.08], [0, 1, 0]},
        {[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.33, 0.01], [0, 1, 0]},
        {[1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.26, 0.07], [0, 1, 0]},
        {[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.41, 0.08], [0, 1, 0]},
        {[1.0, 1.0, 1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.37, 0.01], [0, 1, 0]},
        {[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.24, 0.07], [0, 1, 0]},
        {[1.0, 1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.49, 0.08], [0, 1, 0]},
        {[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.30, 0.01], [0, 1, 0]},
        {[1.0, 0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.50, 0.07], [0, 1, 0]},
        {[1.0, 1.0, 1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.21, 0.08], [0, 1, 0]},
        {[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.10, 0.01], [0, 1, 0]},
        {[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.08, 0.01], [0, 1, 0]},
        {[1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.55, 0.01], [1, 0, 0]},
        {[1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.62, 0.02], [1, 0, 0]},
        {[1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.58, 0.03], [1, 0, 0]},
        {[1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.70, 0.04], [1, 0, 0]},
        {[1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.53, 0.05], [1, 0, 0]},
        {[1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.61, 0.06], [1, 0, 0]},
        {[1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.57, 0.07], [1, 0, 0]},
        {[1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.65, 0.08], [1, 0, 0]},
        {[1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.59, 0.09], [1, 0, 0]},
        {[1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.72, 0.10], [1, 0, 0]},
        {[1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.54, 0.01], [1, 0, 0]},
        {[1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.63, 0.02], [1, 0, 0]},
        {[1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.60, 0.03], [1, 0, 0]},
        {[1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.71, 0.04], [1, 0, 0]},
        {[1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.56, 0.05], [1, 0, 0]},
        {[1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.64, 0.06], [1, 0, 0]},
        {[1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.66, 0.07], [1, 0, 0]},
        {[1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.67, 0.08], [1, 0, 0]},
        {[1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.68, 0.09], [1, 0, 0]},
        {[1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.69, 0.10], [1, 0, 0]},
        {[1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.73, 0.01], [1, 0, 0]}

      ]


    case Repo.aggregate(Case, :count, :id) do
      count when count < 21 ->
        IO.puts("La tabla contiene menos de tres registros o está vacía.")

          # Llamar a la función `learning`
          learning_result = SistemaExperto.Learning.learn(data, 3)

          # Imprimir el resultado del aprendizaje
          IO.inspect(learning_result, label: "Resultado del aprendizaje")

          # Guardar el resultado en la base de datos
          Knowledge.save_learning_result(learning_result)
      _ ->
        # Obtener los datos de `Case` como lista de tuplas
        data_tuples = get_cases_as_tuples()

        # Imprimir los datos que se están pasando
        IO.inspect(data_tuples, label: "Datos obtenidos de la tabla 'cases'")

        # Llamar a la función `learning`
        learning_result = SistemaExperto.Learning.learn(data_tuples, 3)

        # Imprimir el resultado del aprendizaje
        IO.inspect(learning_result, label: "Resultado del aprendizaje")

        # Guardar el resultado en la base de datos
        Knowledge.save_learning_result(learning_result)
    end
  end



end
