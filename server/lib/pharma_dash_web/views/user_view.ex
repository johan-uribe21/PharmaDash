defmodule PharmaDashWeb.UserView do
  use PharmaDashWeb, :view
  alias PharmaDashWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id, email: user.email, is_active: user.is_active, name: user.name}
  end

  def render("user_pharmacy.json", %{user: user}) do
    %{
      data: %{
        id: user.id,
        email: user.email,
        is_active: user.is_active,
        name: user.name,
        pharmacy_id: user.pharmacy_id
      }
    }
  end

  def render("user_courier.json", %{user: user}) do
    %{
      data: %{
        id: user.id,
        email: user.email,
        is_active: user.is_active,
        name: user.name,
        courier_id: user.courier_id
      }
    }
  end

  def render("sign_in.json", %{user: user}) do
    %{
      data: %{
        id: user.id,
        email: user.email,
        name: user.name,
        is_pharmacy: user.is_pharmacy,
        pharmacy_id: user.pharmacy_id,
        is_courier: user.is_courier,
        courier_id: user.courier_id
      }
    }
  end
end
