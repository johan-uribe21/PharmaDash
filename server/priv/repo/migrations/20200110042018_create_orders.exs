defmodule PharmaDash.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add(:rxIds, {:array, :string})
      add(:pickupDate, :date)
      add(:pickupTime, :time)
      add(:active, :boolean, default: false, null: false)
      add(:delivered, :boolean, default: false, null: false)
      add(:deliverable, :boolean, default: false, null: false)
      add(:patient_id, references(:patients, on_delete: :nothing))
      add(:courier_id, references(:couriers, on_delete: :nothing))
      add(:pharmacy_id, references(:pharmacies, on_delete: :nothing))

      timestamps()
    end

    create(index(:orders, [:patient_id]))
    create(index(:orders, [:courier_id]))
    create(index(:orders, [:pharmacy_id]))

    create(index(:pharmacies, [:courier_id]))
    create(index(:couriers, [:pharmacy_id]))
  end
end
