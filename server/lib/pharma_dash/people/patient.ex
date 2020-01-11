defmodule PharmaDash.People.Patient do
  use Ecto.Schema
  import Ecto.Changeset

  schema "patients" do
    field(:city, :string)
    field(:name, :string)
    field(:stateAbr, :string)
    field(:street, :string)
    field(:zipcode, :string)
    field(:pharmacy_id, :integer)
    has_many(:orders, PharmaDash.Items.Order)
    # belongs_to(:pharmacy, PharmaDash.Entities.Pharmacy)
    # has_one(:pharmacy, PharmaDash.Items.Pharmacy)
    # belongs_to(:order, PharmaDash.Items.Order)

    timestamps()
  end

  @doc false
  def changeset(patient, attrs) do
    patient
    |> cast(attrs, [:name, :street, :city, :stateAbr, :zipcode, :pharmacy_id])
    |> validate_required([:name, :street, :city, :stateAbr, :zipcode])
    |> unique_constraint(:name,
      message: "Names must be unique"
    )
  end
end
