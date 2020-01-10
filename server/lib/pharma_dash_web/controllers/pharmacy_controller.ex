defmodule PharmaDashWeb.PharmacyController do
  use PharmaDashWeb, :controller

  import Ecto.Query

  alias PharmaDash.Entities
  alias PharmaDash.Entities.Pharmacy
  alias PharmaDash.Deliveries.Courier
  alias PharmaDash.Repo
  alias PharmaDashWeb.CourierView

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

  def create_courier(conn, %{"courier" => courier_params, "pharmacy_id" => id}) do
    pharmacy = Entities.get_pharmacy!(id)

    new_courier_changeset =
      Ecto.build_assoc(pharmacy, :couriers)
      |> Courier.changeset(courier_params)

    with {:ok, courier} <- Repo.insert(new_courier_changeset) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.pharmacy_path(conn, :create_courier, pharmacy))
      |> render(CourierView, "show.json", courier: courier)
    end
  end

  def get_couriers(conn, %{"pharmacy_id" => id}) do
    couriers =
      from(Courier, where: [pharmacy_id: ^id])
      |> Repo.all()

    conn
    |> render(CourierView, "index.json", couriers: couriers)
  end
end
