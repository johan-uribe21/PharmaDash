defmodule PharmaDashWeb.CourierControllerTest do
  use PharmaDashWeb.ConnCase

  alias PharmaDash.Deliveries
  alias PharmaDash.Deliveries.Courier

  @create_attrs %{
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

  def fixture(:courier) do
    {:ok, courier} = Deliveries.create_courier(@create_attrs)
    courier
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all couriers", %{conn: conn} do
      conn = get(conn, Routes.courier_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create courier" do
    test "renders courier when data is valid", %{conn: conn} do
      conn = post(conn, Routes.courier_path(conn, :create), courier: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.courier_path(conn, :show, id))

      assert %{
               "id" => id,
               "city" => "some city",
               "name" => "some name",
               "stateAbr" => "some stateAbr",
               "street" => "some street",
               "zipcode" => "some zipcode"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.courier_path(conn, :create), courier: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update courier" do
    setup [:create_courier]

    test "renders courier when data is valid", %{conn: conn, courier: %Courier{id: id} = courier} do
      conn = put(conn, Routes.courier_path(conn, :update, courier), courier: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.courier_path(conn, :show, id))

      assert %{
               "id" => id,
               "city" => "some updated city",
               "name" => "some updated name",
               "stateAbr" => "some updated stateAbr",
               "street" => "some updated street",
               "zipcode" => "some updated zipcode"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, courier: courier} do
      conn = put(conn, Routes.courier_path(conn, :update, courier), courier: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete courier" do
    setup [:create_courier]

    test "deletes chosen courier", %{conn: conn, courier: courier} do
      conn = delete(conn, Routes.courier_path(conn, :delete, courier))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.courier_path(conn, :show, courier))
      end
    end
  end

  defp create_courier(_) do
    courier = fixture(:courier)
    {:ok, courier: courier}
  end
end
