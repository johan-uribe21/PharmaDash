defmodule PharmaDash.Repo.Migrations.AddUniqueNamePatients do
  use Ecto.Migration

  def change do
    create(unique_index(:patients, [:name]))
  end
end
