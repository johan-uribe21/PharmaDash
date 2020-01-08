defmodule PharmaDashWeb.PatientController do
  use PharmaDashWeb, :controller

  alias PharmaDash.People
  alias PharmaDash.People.Patient

  action_fallback PharmaDashWeb.FallbackController

  def index(conn, _params) do
    patients = People.list_patients()
    render(conn, "index.json", patients: patients)
  end

  def create(conn, %{"patient" => patient_params}) do
    with {:ok, %Patient{} = patient} <- People.create_patient(patient_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.patient_path(conn, :show, patient))
      |> render("show.json", patient: patient)
    end
  end

  def show(conn, %{"id" => id}) do
    patient = People.get_patient!(id)
    render(conn, "show.json", patient: patient)
  end

  def update(conn, %{"id" => id, "patient" => patient_params}) do
    patient = People.get_patient!(id)

    with {:ok, %Patient{} = patient} <- People.update_patient(patient, patient_params) do
      render(conn, "show.json", patient: patient)
    end
  end

  def delete(conn, %{"id" => id}) do
    patient = People.get_patient!(id)

    with {:ok, %Patient{}} <- People.delete_patient(patient) do
      send_resp(conn, :no_content, "")
    end
  end
end
