defmodule PharmaDashWeb.PharmacyController do
  use PharmaDashWeb, :controller

  alias PharmaDash.Entities
  alias PharmaDash.Entities.Pharmacy

  action_fallback(PharmaDashWeb.FallbackController)

  def index(conn, _params) do
    pharmacies = Entities.list_pharmacies()
    render(conn, "index.json", pharmacies: pharmacies)
  end

  def create(conn, %{"pharmacy" => pharmacy_params}) do
    with {:ok, %Pharmacy{} = pharmacy} <- Entities.create_pharmacy(pharmacy_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.pharmacy_path(conn, :show, pharmacy))
      |> render("show.json", pharmacy: pharmacy)
    end
  end

  def show(conn, %{"id" => id}) do
    pharmacy = Entities.get_pharmacy!(id)
    render(conn, "show.json", pharmacy: pharmacy)
  end

  def update(conn, %{"id" => id, "pharmacy" => pharmacy_params}) do
    pharmacy = Entities.get_pharmacy!(id)

    with {:ok, %Pharmacy{} = pharmacy} <- Entities.update_pharmacy(pharmacy, pharmacy_params) do
      render(conn, "show.json", pharmacy: pharmacy)
    end
  end

  def delete(conn, %{"id" => id}) do
    pharmacy = Entities.get_pharmacy!(id)

    with {:ok, %Pharmacy{}} <- Entities.delete_pharmacy(pharmacy) do
      send_resp(conn, :no_content, "")
    end
  end
end
