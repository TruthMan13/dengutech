defmodule Dengutech.KnowledgeFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Dengutech.Knowledge` context.
  """

  @doc """
  Generate a base_conocimiento.
  """
  def base_conocimiento_fixture(attrs \\ %{}) do
    {:ok, base_conocimiento} =
      attrs
      |> Enum.into(%{
        data: %{}
      })
      |> Dengutech.Knowledge.create_base_conocimiento()

    base_conocimiento
  end
end
