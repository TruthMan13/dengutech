defmodule Dengutech.DiseaseFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Dengutech.Disease` context.
  """

  @doc """
  Generate a case.
  """
  def case_fixture(attrs \\ %{}) do
    {:ok, case} =
      attrs
      |> Enum.into(%{
        abdominal_pain: 42,
        age: 120.5,
        bleeding: 42,
        date_of_onset: ~D[2025-03-19],
        diagnosis: 42,
        fatigue: 42,
        fever: 42,
        headache: 42,
        joint_pain: 42,
        lethargy: 42,
        muscle_pain: 42,
        nausea: 42,
        region: 120.5,
        respiratory_distress: 42,
        retrocular_pain: 42,
        swollen_glands: 42,
        vomiting: 42
      })
      |> Dengutech.Disease.create_case()

    case
  end
end
