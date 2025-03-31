defmodule Dengutech.Disease.Case do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cases" do
    field :fever, :integer
    field :headache, :integer
    field :muscle_pain, :integer
    field :joint_pain, :integer
    field :nausea, :integer
    field :retrocular_pain, :integer
    field :fatigue, :integer
    field :swollen_glands, :integer
    field :abdominal_pain, :integer
    field :vomiting, :integer
    field :bleeding, :integer
    field :respiratory_distress, :integer
    field :lethargy, :integer
    field :age, :float
    field :region, :float
    field :date_of_onset, :date
    field :diagnosis, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(case, attrs) do
    case
    |> cast(attrs, [:fever, :headache, :muscle_pain, :joint_pain, :nausea, :retrocular_pain, :fatigue, :swollen_glands, :abdominal_pain, :vomiting, :bleeding, :respiratory_distress, :lethargy, :age, :region, :date_of_onset, :diagnosis])
    |> validate_required([:fever, :headache, :muscle_pain, :joint_pain, :nausea, :retrocular_pain, :fatigue, :swollen_glands, :abdominal_pain, :vomiting, :bleeding, :respiratory_distress, :lethargy, :age, :region, :date_of_onset, :diagnosis])
  end
end
