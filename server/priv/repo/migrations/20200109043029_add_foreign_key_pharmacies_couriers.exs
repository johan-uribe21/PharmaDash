defmodule PharmaDash.Repo.Migrations.AddForeignKeyPharmaciesCouriers do
  use Ecto.Migration

  def change do
    alter table(:pharmacies) do
      add(:courier_id, references(:couriers))
    end

    alter table(:couriers) do
      add(:pharmacy_id, references(:pharmacies))
    end
  end
end
