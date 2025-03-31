defmodule Dengutech.Knowledge.BaseConocimiento do
  use Ecto.Schema
  import Ecto.Changeset

  schema "base_conocimientos" do
    field :data, :map

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(base_conocimiento, attrs) do
    base_conocimiento
    |> cast(attrs, [:data])
    |> validate_required([:data])
  end
end
