defmodule PharmaDashWeb.Router do
  use PharmaDashWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
    plug(:fetch_session)
  end

  pipeline :api_auth do
    plug(:ensure_authenticated)
  end

  scope "/api", PharmaDashWeb do
    pipe_through(:api)
    post("/users/sign_in", UserController, :sign_in)
  end

  scope "/api", PharmaDashWeb do
    pipe_through([:api, :api_auth])
    resources("/users", UserController, except: [:new, :edit])
    resources("/patients", PatientController)
    resources("/couriers", CourierController)
    resources("/pharmacies", PharmacyController)

    get(
      "/:patient_id/orders",
      OrderController,
      :show_patient_orders
    )

    get(
      "/couriers/:courier_id/orders",
      OrderController,
      :show_courier_orders
    )
  end

  scope "/api/pharmacies", PharmaDashWeb do
    # TODO: Only pharmacy users should have access to their /pharmacies/ endpoints
    pipe_through([:api, :api_auth])
    post("/:pharmacy_id/couriers", PharmacyController, :create_courier)
    get("/:pharmacy_id/couriers", PharmacyController, :get_couriers)

    post(
      "/:pharmacy_id/couriers/:courier_id/patients/:patient_id/orders",
      OrderController,
      :create_order
    )

    get(
      "/:pharmacy_id/orders",
      OrderController,
      :show_courier_orders
    )
  end

  defp ensure_authenticated(conn, _opts) do
    current_user_id = get_session(conn, :current_user_id)

    if current_user_id do
      conn
    else
      conn
      |> put_status(:unauthorized)
      |> render(PharmaDashWeb.ErrorView, "401.json", message: "Unauthenticated user")
      |> halt()
    end
  end
end
