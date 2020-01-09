defmodule PharmaDash.Repo.Migrations.CreateCouriers do
  use Ecto.Migration

  def change do
    create table(:couriers) do
      add(:name, :string)
      add(:street, :string)
      add(:city, :string)
      add(:stateAbr, :string)
      add(:zipcode, :string)

      timestamps()
    end

    create(unique_index(:couriers, [:name]))
  end
end
