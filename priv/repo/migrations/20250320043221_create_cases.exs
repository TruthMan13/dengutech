defmodule Dengutech.Repo.Migrations.CreateCases do
  use Ecto.Migration

  def change do
    create table(:cases) do
      add :fever, :integer
      add :headache, :integer
      add :muscle_pain, :integer
      add :joint_pain, :integer
      add :nausea, :integer
      add :retrocular_pain, :integer
      add :fatigue, :integer
      add :swollen_glands, :integer
      add :abdominal_pain, :integer
      add :vomiting, :integer
      add :bleeding, :integer
      add :respiratory_distress, :integer
      add :lethargy, :integer
      add :age, :float
      add :region, :float
      add :date_of_onset, :date
      add :diagnosis, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
