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

  def render("sign_in.json", %{user: user}) do
    %{
      data: %{
        user: %{
          id: user.id,
          email: user.email,
          name: user.name
        }
      }
    }
  end
end