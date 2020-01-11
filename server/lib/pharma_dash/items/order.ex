defmodule PharmaDash.Items.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field(:active, :boolean, default: true)
    field(:deliverable, :boolean, default: true)
    field(:delivered, :boolean, default: false)
    field(:pickupDate, :date)
    field(:pickupTime, :time)
    field(:rxIds, {:array, :string})
    field(:patient_id, :integer)
    field(:courier_id, :integer)
    field(:pharmacy_id, :integer)
    has_one(:patient, PharmaDash.People.Patient)
    has_one(:courier, PharmaDash.Deliveries.Courier)
    has_one(:pharmacy, PharmaDash.Entities.Pharmacy)

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [
      :rxIds,
      :pickupDate,
      :pickupTime,
      :active,
      :delivered,
      :deliverable,
      :patient_id,
      :courier_id,
      :pharmacy_id
    ])
    |> validate_required([
      :rxIds,
      :pickupDate,
      :pickupTime,
      :active,
      :delivered,
      :deliverable
      # :pharmacy_id,
      # :patient_id
    ])
  end
end
