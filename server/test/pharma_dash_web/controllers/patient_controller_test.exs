defmodule PharmaDashWeb.PatientControllerTest do
  use PharmaDashWeb.ConnCase

  alias PharmaDash.People
  alias PharmaDash.People.Patient

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

  def fixture(:patient) do
    {:ok, patient} = People.create_patient(@create_attrs)
    patient
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all patients", %{conn: conn} do
      conn = get(conn, Routes.patient_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create patient" do
    test "renders patient when data is valid", %{conn: conn} do
      conn = post(conn, Routes.patient_path(conn, :create), patient: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.patient_path(conn, :show, id))

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
      conn = post(conn, Routes.patient_path(conn, :create), patient: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update patient" do
    setup [:create_patient]

    test "renders patient when data is valid", %{conn: conn, patient: %Patient{id: id} = patient} do
      conn = put(conn, Routes.patient_path(conn, :update, patient), patient: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.patient_path(conn, :show, id))

      assert %{
               "id" => id,
               "city" => "some updated city",
               "name" => "some updated name",
               "stateAbr" => "some updated stateAbr",
               "street" => "some updated street",
               "zipcode" => "some updated zipcode"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, patient: patient} do
      conn = put(conn, Routes.patient_path(conn, :update, patient), patient: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  defp create_patient(_) do
    patient = fixture(:patient)
    {:ok, patient: patient}
  end
end
