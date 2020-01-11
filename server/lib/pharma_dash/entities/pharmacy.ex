defmodule PharmaDash.Entities.Pharmacy do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pharmacies" do
    field(:name, :string)
    field(:city, :string)
    field(:stateAbr, :string)
    field(:street, :string)
    field(:zipcode, :string)
    has_many(:couriers, PharmaDash.Deliveries.Courier)
    has_many(:orders, PharmaDash.Items.Order)
    has_many(:patients, PharmaDash.People.Patient)
    has_many(:users, PharmaDash.Auth.User)

    timestamps()
  end

  @doc false
  def changeset(pharmacy, attrs) do
    pharmacy
    |> cast(attrs, [:name, :street, :city, :stateAbr, :zipcode])
    |> validate_required([:name, :street, :city, :stateAbr, :zipcode])
    |> unique_constraint(:name,
      message: "Entity names must be unique"
    )
  end
end
