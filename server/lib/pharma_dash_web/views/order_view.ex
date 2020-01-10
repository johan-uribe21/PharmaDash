defmodule PharmaDashWeb.OrderView do
  use PharmaDashWeb, :view
  alias PharmaDashWeb.OrderView

  def render("index.json", %{orders: orders}) do
    %{data: render_many(orders, OrderView, "order.json")}
  end

  def render("show.json", %{order: order}) do
    %{data: render_one(order, OrderView, "order.json")}
  end

  def render("order.json", %{order: order}) do
    %{id: order.id,
      rxIds: order.rxIds,
      pickupDate: order.pickupDate,
      pickupTime: order.pickupTime,
      active: order.active,
      delivered: order.delivered,
      deliverable: order.deliverable}
  end
end
