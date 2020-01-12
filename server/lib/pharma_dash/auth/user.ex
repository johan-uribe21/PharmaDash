defmodule PharmaDash.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:email, :string)
    field(:is_active, :boolean, default: true)
    field(:password, :string, virtual: true)
    field(:name, :string)
    field(:password_hash, :string)
    field(:is_pharmacy, :boolean, default: false)
    field(:is_courier, :boolean, default: false)
    field(:pharmacy_id, :integer)
    field(:courier_id, :integer)
    has_one(:pharmacy, PharmaDash.Entities.Pharmacy)
    has_one(:courier, PharmaDash.Deliveries.Courier)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :email,
      :is_active,
      :name,
      :password,
      :is_pharmacy,
      :pharmacy_id,
      :is_courier,
      :courier_id
    ])
    |> validate_required([:email, :is_active, :name, :password])
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, password_hash: Bcrypt.hash_pwd_salt(password))
  end

  defp put_password_hash(changeset) do
    changeset
  end
end
