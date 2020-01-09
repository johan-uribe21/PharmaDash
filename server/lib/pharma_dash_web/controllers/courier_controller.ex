defmodule PharmaDashWeb.CourierController do
  use PharmaDashWeb, :controller

  alias PharmaDash.Deliveries
  alias PharmaDash.Deliveries.Courier

  action_fallback PharmaDashWeb.FallbackController

  def index(conn, _params) do
    couriers = Deliveries.list_couriers()
    render(conn, "index.json", couriers: couriers)
  end

  def create(conn, %{"courier" => courier_params}) do
    with {:ok, %Courier{} = courier} <- Deliveries.create_courier(courier_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.courier_path(conn, :show, courier))
      |> render("show.json", courier: courier)
    end
  end

  def show(conn, %{"id" => id}) do
    courier = Deliveries.get_courier!(id)
    render(conn, "show.json", courier: courier)
  end

  def update(conn, %{"id" => id, "courier" => courier_params}) do
    courier = Deliveries.get_courier!(id)

    with {:ok, %Courier{} = courier} <- Deliveries.update_courier(courier, courier_params) do
      render(conn, "show.json", courier: courier)
    end
  end

  def delete(conn, %{"id" => id}) do
    courier = Deliveries.get_courier!(id)

    with {:ok, %Courier{}} <- Deliveries.delete_courier(courier) do
      send_resp(conn, :no_content, "")
    end
  end
end
