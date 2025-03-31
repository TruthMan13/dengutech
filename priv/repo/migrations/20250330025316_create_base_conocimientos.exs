defmodule Dengutech.Repo.Migrations.CreateBaseConocimientos do
  use Ecto.Migration

  def change do
    create table(:base_conocimientos) do
      add :data, :jsonb

      timestamps(type: :utc_datetime)
    end
  end
end
