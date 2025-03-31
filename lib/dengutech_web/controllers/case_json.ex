defmodule DengutechWeb.CaseJSON do
  alias Dengutech.Disease.Case

  @doc """
  Renders a list of cases.
  """
  def index(%{cases: cases}) do
    %{data: for(case <- cases, do: data(case))}
  end

  @doc """
  Renders a single case.
  """
  def show(%{case: case}) do
    %{data: data(case)}
  end

  defp data(%Case{} = case) do
    %{
      id: case.id,
      fever: case.fever,
      headache: case.headache,
      muscle_pain: case.muscle_pain,
      joint_pain: case.joint_pain,
      nausea: case.nausea,
      retrocular_pain: case.retrocular_pain,
      fatigue: case.fatigue,
      swollen_glands: case.swollen_glands,
      abdominal_pain: case.abdominal_pain,
      vomiting: case.vomiting,
      bleeding: case.bleeding,
      respiratory_distress: case.respiratory_distress,
      lethargy: case.lethargy,
      age: case.age,
      region: case.region,
      date_of_onset: case.date_of_onset,
      diagnosis: case.diagnosis
    }
  end
end
