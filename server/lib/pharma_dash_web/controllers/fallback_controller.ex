defmodule PharmaDashWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use PharmaDashWeb, :controller

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(PharmaDashWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, %Ecto.Changeset{errors: error_message}}) do
    # IO.inspect(error_message)

    conn
    |> put_status(:unprocessable_entity)
    |> put_view(PharmaDashWeb.ErrorView)
    |> render(:"422_detail_message", error_message)
  end

  def call(conn, {:error, %Ecto.Changeset{}}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(PharmaDashWeb.ErrorView)
    |> render(:"422")
  end
end
