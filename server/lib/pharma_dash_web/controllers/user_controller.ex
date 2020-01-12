defmodule PharmaDashWeb.UserController do
  use PharmaDashWeb, :controller

  alias PharmaDash.Auth
  alias PharmaDash.Auth.User
  alias PharmaDashWeb.UserView

  action_fallback(PharmaDashWeb.FallbackController)

  def index(conn, _params) do
    users = Auth.list_users()

    conn
    |> put_view(UserView)
    |> render("index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Auth.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> put_view(UserView)
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Auth.get_user!(id)

    conn
    |> put_view(UserView)
    |> render("show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Auth.get_user!(id)

    with {:ok, %User{} = user} <- Auth.update_user(user, user_params) do
      conn
      |> put_view(UserView)
      |> render("show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Auth.get_user!(id)

    with {:ok, %User{}} <- Auth.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def sign_in(conn, %{"email" => email, "password" => password}) do
    case PharmaDash.Auth.authenticate_user(email, password) do
      {:ok, user} ->
        conn
        |> put_session(:current_user_id, user.id)
        |> put_status(:ok)
        |> put_view(UserView)
        |> render("sign_in.json", user: user)

      {:error, message} ->
        conn
        |> delete_session(:current_user_id)
        |> put_status(:unauthorized)
        |> put_view(PharmaDashWeb.ErrorView)
        |> render("401.json", message: message)
    end
  end

  def signout(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> send_resp(:no_content, "")
  end

  def create_pharmacy_user(conn, %{"user" => user_params, "id" => id}) do
    new_user_params = Map.merge(user_params, %{"pharmacy_id" => id, "is_pharmacy" => true})

    with {:ok, %User{} = user} <- Auth.create_user(new_user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> put_view(UserView)
      |> render("user_pharmacy.json", user: user)
    end
  end

  def create_courier_user(conn, %{"user" => user_params, "id" => id}) do
    new_user_params = Map.merge(user_params, %{"courier_id" => id, "is_courier" => true})

    with {:ok, %User{} = user} <- Auth.create_user(new_user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> put_view(UserView)
      |> render("user_courier.json", user: user)
    end
  end
end
