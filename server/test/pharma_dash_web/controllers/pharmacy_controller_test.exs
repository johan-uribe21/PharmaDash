defmodule PharmaDashWeb.PharmacyControllerTest do
  use PharmaDashWeb.ConnCase

  alias PharmaDash.Entities
  alias PharmaDash.Entities.Pharmacy

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

  def fixture(:pharmacy) do
    {:ok, pharmacy} = Entities.create_pharmacy(@create_attrs)
    pharmacy
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all pharmacies", %{conn: conn} do
      conn = get(conn, Routes.pharmacy_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create pharmacy" do
    test "renders pharmacy when data is valid", %{conn: conn} do
      conn = post(conn, Routes.pharmacy_path(conn, :create), pharmacy: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.pharmacy_path(conn, :show, id))

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
      conn = post(conn, Routes.pharmacy_path(conn, :create), pharmacy: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update pharmacy" do
    setup [:create_pharmacy]

    test "renders pharmacy when data is valid", %{
      conn: conn,
      pharmacy: %Pharmacy{id: id} = pharmacy
    } do
      conn = put(conn, Routes.pharmacy_path(conn, :update, pharmacy), pharmacy: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.pharmacy_path(conn, :show, id))

      assert %{
               "id" => id,
               "city" => "some updated city",
               "name" => "some updated name",
               "stateAbr" => "some updated stateAbr",
               "street" => "some updated street",
               "zipcode" => "some updated zipcode"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, pharmacy: pharmacy} do
      conn = put(conn, Routes.pharmacy_path(conn, :update, pharmacy), pharmacy: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete pharmacy" do
    setup [:create_pharmacy]

    test "deletes chosen pharmacy", %{conn: conn, pharmacy: pharmacy} do
      conn = delete(conn, Routes.pharmacy_path(conn, :delete, pharmacy))
      assert response(conn, 204)

      assert_error_sent(404, fn ->
        get(conn, Routes.pharmacy_path(conn, :show, pharmacy))
      end)
    end
  end

  defp create_pharmacy(_) do
    pharmacy = fixture(:pharmacy)
    {:ok, pharmacy: pharmacy}
  end
end
