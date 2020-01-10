defmodule PharmaDash.Deliveries.Courier do
  use Ecto.Schema
  import Ecto.Changeset

  schema "couriers" do
    field(:city, :string)
    field(:name, :string)
    field(:stateAbr, :string)
    field(:street, :string)
    field(:zipcode, :string)
    has_many(:orders, PharmaDash.Items.Order)
    belongs_to(:pharmacy, PharmaDash.Entities.Pharmacy)
    belongs_to(:order, PharmaDash.Items.Order)

    timestamps()
  end

  @doc false
  def changeset(courier, attrs) do
    courier
    |> cast(attrs, [:name, :street, :city, :stateAbr, :zipcode])
    |> validate_required([:name, :street, :city, :stateAbr, :zipcode])
    |> unique_constraint(:name, message: "Company names must be unique")
  end
end
