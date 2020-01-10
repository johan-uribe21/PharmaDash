defmodule PharmaDash.ItemsTest do
  use PharmaDash.DataCase

  alias PharmaDash.Items

  describe "orders" do
    alias PharmaDash.Items.Order

    @valid_attrs %{active: true, deliverable: true, delivered: true, pickupDate: ~D[2010-04-17], pickupTime: ~T[14:00:00], rxIds: []}
    @update_attrs %{active: false, deliverable: false, delivered: false, pickupDate: ~D[2011-05-18], pickupTime: ~T[15:01:01], rxIds: []}
    @invalid_attrs %{active: nil, deliverable: nil, delivered: nil, pickupDate: nil, pickupTime: nil, rxIds: nil}

    def order_fixture(attrs \\ %{}) do
      {:ok, order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Items.create_order()

      order
    end

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Items.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Items.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      assert {:ok, %Order{} = order} = Items.create_order(@valid_attrs)
      assert order.active == true
      assert order.deliverable == true
      assert order.delivered == true
      assert order.pickupDate == ~D[2010-04-17]
      assert order.pickupTime == ~T[14:00:00]
      assert order.rxIds == []
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Items.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      assert {:ok, %Order{} = order} = Items.update_order(order, @update_attrs)
      assert order.active == false
      assert order.deliverable == false
      assert order.delivered == false
      assert order.pickupDate == ~D[2011-05-18]
      assert order.pickupTime == ~T[15:01:01]
      assert order.rxIds == []
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Items.update_order(order, @invalid_attrs)
      assert order == Items.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Items.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Items.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Items.change_order(order)
    end
  end
end
