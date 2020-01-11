defmodule PharmaDashWeb.OrderController do
  use PharmaDashWeb, :controller

  import Ecto.Query
  alias PharmaDash.Repo

  alias PharmaDash.Items
  alias PharmaDash.Items.Order
  alias PharmaDashWeb.OrderView

  action_fallback(PharmaDashWeb.FallbackController)

  def index(conn, _params) do
    orders = Items.list_orders()

    conn
    |> put_view(OrderView)
    |> render("index.json", orders: orders)
  end

  def create(conn, %{"order" => order_params}) do
    with {:ok, %Order{} = order} <- Items.create_order(order_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.order_path(conn, :show, order))
      |> put_view(OrderView)
      |> render("show.json", order: order)
    end
  end

  def show(conn, %{"id" => id}) do
    order = Items.get_order!(id)

    conn
    |> put_view(OrderView)
    |> render("show.json", order: order)
  end

  def update(conn, %{"id" => id, "order" => order_params}) do
    order = Items.get_order!(id)

    with {:ok, %Order{} = order} <- Items.update_order(order, order_params) do
      conn
      |> put_view(OrderView)
      |> render("show.json", order: order)
    end
  end

  def delete(conn, %{"id" => id}) do
    order = Items.get_order!(id)

    with {:ok, %Order{}} <- Items.delete_order(order) do
      send_resp(conn, :no_content, "")
    end
  end

  def create_order(conn, params) do
    %{
      "courier_id" => courier_id,
      "order" => order_params,
      "patient_id" => patient_id,
      "pharmacy_id" => pharmacy_id
    } = params

    full_order_params =
      Map.merge(order_params, %{
        "pharmacy_id" => pharmacy_id,
        "patient_id" => patient_id,
        "courier_id" => courier_id
      })

    with {:ok, order} <- Items.create_order(full_order_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.order_path(conn, :show, order))
      |> put_view(OrderView)
      |> render("show.json", order: order)
    end
  end

  def list_pharmacy_orders(conn, %{"pharmacy_id" => pharmacy_id}) do
    orders =
      from(Order, where: [pharmacy_id: ^pharmacy_id])
      |> Repo.all()

    conn
    |> put_view(OrderView)
    |> render("index.json", orders: orders)
  end

  def cancel_order(conn, %{"order_id" => order_id}) do
    order = Items.get_order!(order_id)

    with {:ok, order} <- Items.update_order(order, %{active: false}) do
      conn
      |> put_view(OrderView)
      |> render("show.json", order: order)
    end
  end

  def uncancel_order(conn, %{"order_id" => order_id}) do
    order = Items.get_order!(order_id)

    with {:ok, order} <- Items.update_order(order, %{active: true}) do
      conn
      |> put_view(OrderView)
      |> render("show.json", order: order)
    end
  end

  def set_order_delivered(conn, %{"order_id" => order_id}) do
    order = Items.get_order!(order_id)

    with {:ok, order} <- Items.update_order(order, %{delivered: true}) do
      conn
      |> put_view(OrderView)
      |> render("show.json", order: order)
    end
  end

  def unset_order_delivered(conn, %{"order_id" => order_id}) do
    order = Items.get_order!(order_id)

    with {:ok, order} <- Items.update_order(order, %{delivered: false}) do
      conn
      |> put_view(OrderView)
      |> render("show.json", order: order)
    end
  end

  def set_order_is_deliverable(conn, %{"order_id" => order_id}) do
    order = Items.get_order!(order_id)

    with {:ok, order} <- Items.update_order(order, %{deliverable: true}) do
      conn
      |> put_view(OrderView)
      |> render("show.json", order: order)
    end
  end

  def unset_order_is_deliverable(conn, %{"order_id" => order_id}) do
    order = Items.get_order!(order_id)

    with {:ok, order} <- Items.update_order(order, %{deliverable: false}) do
      conn
      |> put_view(OrderView)
      |> render("show.json", order: order)
    end
  end
end
