defmodule PharmaDash.People.Patient do
  use Ecto.Schema
  import Ecto.Changeset

  schema "patients" do
    field :city, :string
    field :name, :string
    field :stateAbr, :string
    field :street, :string
    field :zipcode, :string

    timestamps()
  end

  @doc false
  def changeset(patient, attrs) do
    patient
    |> cast(attrs, [:name, :street, :city, :stateAbr, :zipcode])
    |> validate_required([:name, :street, :city, :stateAbr, :zipcode])
  end
end
