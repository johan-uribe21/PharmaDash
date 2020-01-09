defmodule PharmaDash.DeliveriesTest do
  use PharmaDash.DataCase

  alias PharmaDash.Deliveries

  describe "couriers" do
    alias PharmaDash.Deliveries.Courier

    @valid_attrs %{city: "some city", name: "some name", stateAbr: "some stateAbr", street: "some street", zipcode: "some zipcode"}
    @update_attrs %{city: "some updated city", name: "some updated name", stateAbr: "some updated stateAbr", street: "some updated street", zipcode: "some updated zipcode"}
    @invalid_attrs %{city: nil, name: nil, stateAbr: nil, street: nil, zipcode: nil}

    def courier_fixture(attrs \\ %{}) do
      {:ok, courier} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Deliveries.create_courier()

      courier
    end

    test "list_couriers/0 returns all couriers" do
      courier = courier_fixture()
      assert Deliveries.list_couriers() == [courier]
    end

    test "get_courier!/1 returns the courier with given id" do
      courier = courier_fixture()
      assert Deliveries.get_courier!(courier.id) == courier
    end

    test "create_courier/1 with valid data creates a courier" do
      assert {:ok, %Courier{} = courier} = Deliveries.create_courier(@valid_attrs)
      assert courier.city == "some city"
      assert courier.name == "some name"
      assert courier.stateAbr == "some stateAbr"
      assert courier.street == "some street"
      assert courier.zipcode == "some zipcode"
    end

    test "create_courier/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Deliveries.create_courier(@invalid_attrs)
    end

    test "update_courier/2 with valid data updates the courier" do
      courier = courier_fixture()
      assert {:ok, %Courier{} = courier} = Deliveries.update_courier(courier, @update_attrs)
      assert courier.city == "some updated city"
      assert courier.name == "some updated name"
      assert courier.stateAbr == "some updated stateAbr"
      assert courier.street == "some updated street"
      assert courier.zipcode == "some updated zipcode"
    end

    test "update_courier/2 with invalid data returns error changeset" do
      courier = courier_fixture()
      assert {:error, %Ecto.Changeset{}} = Deliveries.update_courier(courier, @invalid_attrs)
      assert courier == Deliveries.get_courier!(courier.id)
    end

    test "delete_courier/1 deletes the courier" do
      courier = courier_fixture()
      assert {:ok, %Courier{}} = Deliveries.delete_courier(courier)
      assert_raise Ecto.NoResultsError, fn -> Deliveries.get_courier!(courier.id) end
    end

    test "change_courier/1 returns a courier changeset" do
      courier = courier_fixture()
      assert %Ecto.Changeset{} = Deliveries.change_courier(courier)
    end
  end
end
