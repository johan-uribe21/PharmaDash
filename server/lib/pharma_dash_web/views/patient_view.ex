defmodule PharmaDashWeb.PatientView do
  use PharmaDashWeb, :view
  alias PharmaDashWeb.PatientView

  def render("index.json", %{patients: patients}) do
    %{data: render_many(patients, PatientView, "patient.json")}
  end

  def render("show.json", %{patient: patient}) do
    %{data: render_one(patient, PatientView, "patient.json")}
  end

  def render("patient.json", %{patient: patient}) do
    %{id: patient.id,
      name: patient.name,
      street: patient.street,
      city: patient.city,
      stateAbr: patient.stateAbr,
      zipcode: patient.zipcode}
  end
end
