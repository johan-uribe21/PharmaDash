defmodule PharmaDashWeb.PatientController do
  use PharmaDashWeb, :controller

  import Ecto.Query
  alias PharmaDash.Repo
  alias PharmaDash.People
  alias PharmaDash.People.Patient
  alias PharmaDashWeb.PatientView

  action_fallback(PharmaDashWeb.FallbackController)

  def index(conn, _params) do
    patients = People.list_patients()

    conn
    |> put_view(PatientView)
    |> render("index.json", patients: patients)
  end

  def create(conn, %{"patient" => patient_params}) do
    with {:ok, %Patient{} = patient} <- People.create_patient(patient_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.patient_path(conn, :create))
      |> put_view(PatientView)
      |> render("show.json", patient: patient)
    end
  end

  def show(conn, %{"id" => id}) do
    patient = People.get_patient!(id)

    conn
    |> put_view(PatientView)
    |> render("show.json", patient: patient)
  end

  def update(conn, %{"id" => id, "patient" => patient_params}) do
    patient = People.get_patient!(id)

    with {:ok, %Patient{} = patient} <- People.update_patient(patient, patient_params) do
      conn
      |> put_view(PatientView)
      |> render("show.json", patient: patient)
    end
  end

  def delete(conn, %{"id" => id}) do
    patient = People.get_patient!(id)

    with {:ok, %Patient{}} <- People.delete_patient(patient) do
      send_resp(conn, :no_content, "")
    end
  end

  def list_pharmacy_patients(conn, %{"pharmacy_id" => pharmacy_id}) do
    patients =
      from(Patient, where: [pharmacy_id: ^pharmacy_id])
      |> Repo.all()

    conn
    |> put_view(PatientView)
    |> render("index.json", patients: patients)
  end

  def create_patient_with_pharmacy(conn, %{
        "pharmacy_id" => pharmacy_id,
        "patient" => patient_params
      }) do
    full_patient_params = Map.merge(patient_params, %{"pharmacy_id" => pharmacy_id})

    with {:ok, patient} <- People.create_patient(full_patient_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.patient_path(conn, :show, patient))
      |> put_view(PatientView)
      |> render("show.json", patient: patient)
    end
  end
end
