defmodule PharmaDash.Repo.Migrations.AddPharmacyFkToPatients do
  use Ecto.Migration

  def change do
    alter table(:patients) do
      add(:pharmacy_id, references(:pharmacies))
    end
  end
end
