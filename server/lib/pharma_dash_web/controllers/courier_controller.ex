defmodule PharmaDashWeb.CourierController do
  use PharmaDashWeb, :controller

  import Ecto.Query

  alias PharmaDash.Repo
  alias PharmaDash.Entities
  alias PharmaDash.Entities.Pharmacy
  alias PharmaDash.Deliveries
  alias PharmaDash.Deliveries.Courier
  alias PharmaDashWeb.CourierView

  action_fallback(PharmaDashWeb.FallbackController)

  def index(conn, _params) do
    couriers = Deliveries.list_couriers()

    conn
    |> put_view(CourierView)
    |> render("index.json", couriers: couriers)
  end

  def create(conn, %{"courier" => courier_params}) do
    with {:ok, %Courier{} = courier} <- Deliveries.create_courier(courier_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.courier_path(conn, :show, courier))
      |> put_view(CourierView)
      |> render("show.json", courier: courier)
    end
  end

  def show(conn, %{"id" => id}) do
    courier = Deliveries.get_courier!(id)

    conn
    |> put_view(CourierView)
    |> render("show.json", courier: courier)
  end

  def update(conn, %{"id" => id, "courier" => courier_params}) do
    courier = Deliveries.get_courier!(id)

    with {:ok, %Courier{} = courier} <- Deliveries.update_courier(courier, courier_params) do
      conn
      |> put_view(CourierView)
      |> render("show.json", courier: courier)
    end
  end

  def delete(conn, %{"id" => id}) do
    courier = Deliveries.get_courier!(id)

    with {:ok, %Courier{}} <- Deliveries.delete_courier(courier) do
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
      |> put_resp_header("location", Routes.courier_path(conn, :show, courier))
      |> put_view(CourierView)
      |> render("show.json", courier: courier)
    end
  end

  def get_couriers(conn, %{"pharmacy_id" => id}) do
    couriers =
      from(Courier, where: [pharmacy_id: ^id])
      |> Repo.all()

    conn
    |> put_view(CourierView)
    |> render("index.json", couriers: couriers)
  end
end
