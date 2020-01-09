defmodule PharmaDash.EntitiesTest do
  use PharmaDash.DataCase

  alias PharmaDash.Entities

  describe "pharmacies" do
    alias PharmaDash.Entities.Pharmacy

    @valid_attrs %{
      city: "some city",
      name: "some name",
      stateAbr: "some stateAbr",
      street: "some street",
      zipcode: "some zipcode"
    }
    @update_attrs %{
      city: "some updated city",
      name: "some updated name",
      stateAbr: "some updated stateAbr",
      street: "some updated street",
      zipcode: "some updated zipcode"
    }
    @invalid_attrs %{city: nil, name: nil, stateAbr: nil, street: nil, zipcode: nil}

    def pharmacy_fixture(attrs \\ %{}) do
      {:ok, pharmacy} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Entities.create_pharmacy()

      pharmacy
    end

    test "list_pharmacies/0 returns all pharmacies" do
      pharmacy = pharmacy_fixture()
      assert Entities.list_pharmacies() == [pharmacy]
    end

    test "get_pharmacy!/1 returns the pharmacy with given id" do
      pharmacy = pharmacy_fixture()
      assert Entities.get_pharmacy!(pharmacy.id) == pharmacy
    end

    test "create_pharmacy/1 with valid data creates a pharmacy" do
      assert {:ok, %Pharmacy{} = pharmacy} = Entities.create_pharmacy(@valid_attrs)
      assert pharmacy.city == "some city"
      assert pharmacy.name == "some name"
      assert pharmacy.stateAbr == "some stateAbr"
      assert pharmacy.street == "some street"
      assert pharmacy.zipcode == "some zipcode"
    end

    test "create_pharmacy/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Entities.create_pharmacy(@invalid_attrs)
    end

    test "update_pharmacy/2 with valid data updates the pharmacy" do
      pharmacy = pharmacy_fixture()
      assert {:ok, %Pharmacy{} = pharmacy} = Entities.update_pharmacy(pharmacy, @update_attrs)
      assert pharmacy.city == "some updated city"
      assert pharmacy.name == "some updated name"
      assert pharmacy.stateAbr == "some updated stateAbr"
      assert pharmacy.street == "some updated street"
      assert pharmacy.zipcode == "some updated zipcode"
    end

    test "update_pharmacy/2 with invalid data returns error changeset" do
      pharmacy = pharmacy_fixture()
      assert {:error, %Ecto.Changeset{}} = Entities.update_pharmacy(pharmacy, @invalid_attrs)
      assert pharmacy == Entities.get_pharmacy!(pharmacy.id)
    end

    test "delete_pharmacy/1 deletes the pharmacy" do
      pharmacy = pharmacy_fixture()
      assert {:ok, %Pharmacy{}} = Entities.delete_pharmacy(pharmacy)
      assert_raise Ecto.NoResultsError, fn -> Entities.get_pharmacy!(pharmacy.id) end
    end

    test "change_pharmacy/1 returns a pharmacy changeset" do
      pharmacy = pharmacy_fixture()
      assert %Ecto.Changeset{} = Entities.change_pharmacy(pharmacy)
    end
  end
end
