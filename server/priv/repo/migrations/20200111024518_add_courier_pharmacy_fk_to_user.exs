defmodule PharmaDash.Repo.Migrations.AddCourierPharmacyFkToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add(:pharmacy_id, references(:pharmacies))
      add(:is_pharmacy, :boolean, default: false)
      add(:courier_id, references(:couriers))
      add(:is_courier, :boolean, default: false)
    end
  end
end
