defmodule PharmaDash.Repo.Migrations.CreatePharmacies do
  use Ecto.Migration

  def change do
    create table(:pharmacies) do
      add(:name, :string)
      add(:street, :string)
      add(:city, :string)
      add(:stateAbr, :string)
      add(:zipcode, :string)

      timestamps()
    end

    create(unique_index(:pharmacies, [:name]))
  end
end
