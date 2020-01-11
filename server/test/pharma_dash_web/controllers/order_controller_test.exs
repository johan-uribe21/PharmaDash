defmodule PharmaDashWeb.OrderControllerTest do
  use PharmaDashWeb.ConnCase

  alias PharmaDash.Items
  alias PharmaDash.Items.Order

  alias PharmaDash.Auth
  alias Plug.Test

  alias PharmaDash.Entities
  alias PharmaDash.Entities.Pharmacy

  alias PharmaDash.Deliveries
  alias PharmaDash.Deliveries.Courier

  alias PharmaDash.People
  alias PharmaDash.People.Patient

  @create_pharmacy_attrs %{
    name: "some pharmacy name",
    city: "some city",
    stateAbr: "some stateAbr",
    street: "some street",
    zipcode: "some zipcode"
  }
  @create_courier_attrs %{
    name: "some courier name",
    city: "some city",
    stateAbr: "some stateAbr",
    street: "some street",
    zipcode: "some zipcode"
  }
  @create_patient_attrs %{
    name: "some patient name",
    city: "some city",
    stateAbr: "some stateAbr",
    street: "some street",
    zipcode: "some zipcode"
  }
  @current_user_attrs %{
    email: "some current user email",
    is_active: true,
    password: "some current user password",
    name: "some current user name"
  }
  @create_attrs %{
    active: true,
    deliverable: true,
    delivered: true,
    pickupDate: ~D[2010-04-17],
    pickupTime: ~T[14:00:00],
    rxIds: ["RX123"]
  }
  @update_attrs %{
    active: false,
    deliverable: false,
    delivered: false,
    pickupDate: ~D[2011-05-18],
    pickupTime: ~T[15:01:01],
    rxIds: []
  }
  @invalid_attrs %{
    active: nil,
    deliverable: nil,
    delivered: nil,
    pickupDate: nil,
    pickupTime: nil,
    rxIds: nil
  }

  def fixture(:order) do
    {:ok, order} = Items.create_order(@create_attrs)
    order
  end

  def fixture(:current_user) do
    {:ok, current_user} = Auth.create_user(@current_user_attrs)
    current_user
  end

  def fixture(:pharmacy) do
    {:ok, pharmacy} = Entities.create_pharmacy(@create_pharmacy_attrs)
    pharmacy
  end

  def fixture(:courier) do
    {:ok, courier} = Deliveries.create_courier(@create_courier_attrs)
    courier
  end

  def fixture(:patient) do
    {:ok, patient} = People.create_patient(@create_patient_attrs)
    patient
  end

  setup %{conn: conn} do
    {:ok, conn: conn} = setup_current_user_session(conn)
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all orders", %{conn: conn} do
      conn = get(conn, Routes.order_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create order associate with pharmacy, courier, and patient" do
    setup [:create_pharmacy, :create_courier, :create_patient]

    test "renders order when data is valid", %{
      conn: conn,
      pharmacy: %Pharmacy{id: pharmacy_id},
      courier: %Courier{id: courier_id},
      patient: %Patient{id: patient_id}
    } do
      conn =
        post(conn, Routes.order_path(conn, :create_order, pharmacy_id, courier_id, patient_id),
          order: @create_attrs
        )

      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.order_path(conn, :show, id))

      assert %{
               "id" => id,
               "active" => true,
               "deliverable" => true,
               "delivered" => true,
               "pickupDate" => "2010-04-17",
               "pickupTime" => "14:00:00",
               "rxIds" => ["RX123"]
             } = json_response(conn, 200)["data"]
    end

    test "renders error when data is invalid", %{
      conn: conn,
      pharmacy: %Pharmacy{id: pharmacy_id},
      courier: %Courier{id: courier_id},
      patient: %Patient{id: patient_id}
    } do
      conn =
        post(conn, Routes.order_path(conn, :create_order, pharmacy_id, courier_id, patient_id),
          order: @invalid_attrs
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update order" do
    setup [:create_order]

    test "renders order when data is valid", %{conn: conn, order: %Order{id: id} = order} do
      conn = put(conn, Routes.order_path(conn, :update, order), order: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      # conn = get(conn, Routes.order_path(conn, :show, id))

      assert %{
               "id" => id,
               "active" => false,
               "deliverable" => false,
               "delivered" => false,
               "pickupDate" => "2011-05-18",
               "pickupTime" => "15:01:01",
               "rxIds" => []
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, order: order} do
      conn = put(conn, Routes.order_path(conn, :update, order), order: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "cancel order" do
    setup [:create_order]

    test "renders order flipped between active true/false", %{
      conn: conn,
      order: %Order{id: id}
    } do
      conn = patch(conn, Routes.order_path(conn, :cancel_order, id))
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      assert %{
               "id" => id,
               "active" => false,
               "deliverable" => true,
               "delivered" => true,
               "pickupDate" => "2010-04-17",
               "pickupTime" => "14:00:00",
               "rxIds" => ["RX123"],
               "courier_id" => nil,
               "patient_id" => nil
             } = json_response(conn, 200)["data"]

      conn = patch(conn, Routes.order_path(conn, :uncancel_order, id))
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      assert %{
               "id" => id,
               "active" => true,
               "deliverable" => true,
               "delivered" => true,
               "pickupDate" => "2010-04-17",
               "pickupTime" => "14:00:00",
               "rxIds" => ["RX123"],
               "courier_id" => nil,
               "patient_id" => nil
             } = json_response(conn, 200)["data"]
    end
  end

  describe "Set order deliverable true/false" do
    setup [:create_order]

    test "renders order flipped between deliverable and undeliverable", %{
      conn: conn,
      order: %Order{id: id}
    } do
      conn = patch(conn, Routes.order_path(conn, :set_order_is_not_deliverable, id))
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      assert %{
               "id" => id,
               "active" => true,
               "deliverable" => false,
               "delivered" => true,
               "pickupDate" => "2010-04-17",
               "pickupTime" => "14:00:00",
               "rxIds" => ["RX123"],
               "courier_id" => nil,
               "patient_id" => nil
             } = json_response(conn, 200)["data"]

      conn = patch(conn, Routes.order_path(conn, :set_order_is_deliverable, id))
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      assert %{
               "id" => id,
               "active" => true,
               "deliverable" => true,
               "delivered" => true,
               "pickupDate" => "2010-04-17",
               "pickupTime" => "14:00:00",
               "rxIds" => ["RX123"],
               "courier_id" => nil,
               "patient_id" => nil
             } = json_response(conn, 200)["data"]
    end
  end

  describe "Set order delivered true/false" do
    setup [:create_order]

    test "renders order flipped between delivered true and false", %{
      conn: conn,
      order: %Order{id: id}
    } do
      conn = patch(conn, Routes.order_path(conn, :set_order_not_delivered, id))
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      assert %{
               "id" => id,
               "active" => true,
               "deliverable" => true,
               "delivered" => false,
               "pickupDate" => "2010-04-17",
               "pickupTime" => "14:00:00",
               "rxIds" => ["RX123"],
               "courier_id" => nil,
               "patient_id" => nil
             } = json_response(conn, 200)["data"]

      conn = patch(conn, Routes.order_path(conn, :set_order_delivered, id))
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      assert %{
               "id" => id,
               "active" => true,
               "deliverable" => true,
               "delivered" => true,
               "pickupDate" => "2010-04-17",
               "pickupTime" => "14:00:00",
               "rxIds" => ["RX123"],
               "courier_id" => nil,
               "patient_id" => nil
             } = json_response(conn, 200)["data"]
    end
  end

  defp setup_current_user_session(conn) do
    current_user = fixture(:current_user)

    {:ok, conn: Test.init_test_session(conn, current_user_id: current_user.id)}
  end

  defp create_order(_) do
    order = fixture(:order)
    {:ok, order: order}
  end

  defp create_pharmacy(_) do
    pharmacy = fixture(:pharmacy)
    {:ok, pharmacy: pharmacy}
  end

  defp create_courier(_) do
    courier = fixture(:courier)
    {:ok, courier: courier}
  end

  defp create_patient(_) do
    patient = fixture(:patient)
    {:ok, patient: patient}
  end
end
