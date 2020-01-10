defmodule PharmaDashWeb.CourierView do
  use PharmaDashWeb, :view
  alias PharmaDashWeb.CourierView

  def render("index.json", %{couriers: couriers}) do
    %{data: render_many(couriers, CourierView, "courier.json")}
  end

  def render("show.json", %{courier: courier}) do
    %{data: render_one(courier, CourierView, "courier.json")}
  end

  def render("courier.json", %{courier: courier}) do
    %{
      id: courier.id,
      name: courier.name,
      street: courier.street,
      city: courier.city,
      stateAbr: courier.stateAbr,
      zipcode: courier.zipcode
    }
  end
end
