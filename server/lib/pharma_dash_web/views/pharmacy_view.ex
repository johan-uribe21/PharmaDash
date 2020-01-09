defmodule PharmaDashWeb.PharmacyView do
  use PharmaDashWeb, :view
  alias PharmaDashWeb.PharmacyView

  def render("index.json", %{pharmacies: pharmacies}) do
    %{data: render_many(pharmacies, PharmacyView, "pharmacy.json")}
  end

  def render("show.json", %{pharmacy: pharmacy}) do
    %{data: render_one(pharmacy, PharmacyView, "pharmacy.json")}
  end

  def render("pharmacy.json", %{pharmacy: pharmacy}) do
    %{
      id: pharmacy.id,
      name: pharmacy.name,
      street: pharmacy.street,
      city: pharmacy.city,
      stateAbr: pharmacy.stateAbr,
      zipcode: pharmacy.zipcode
    }
  end
end
