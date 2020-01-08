defmodule PharmaDash.Repo.Migrations.CreatePatients do
  use Ecto.Migration

  def change do
    create table(:patients) do
      add :name, :string
      add :street, :string
      add :city, :string
      add :stateAbr, :string
      add :zipcode, :string

      timestamps()
    end

  end
end
