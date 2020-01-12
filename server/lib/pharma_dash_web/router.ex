defmodule PharmaDashWeb.Router do
  use PharmaDashWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
    plug(:fetch_session)
    plug(PharmaDashWeb.Plugs.SetUser)
  end

  pipeline :api_auth do
    plug(:ensure_authenticated)
  end

  # TODO: Add validation to only give users access to resources owned by their pharmacy/courier
  scope "/api", PharmaDashWeb do
    pipe_through(:api)
  end

  scope "/api", PharmaDashWeb do
    pipe_through([:api, :api_auth])

    resources("/users", UserController, only: [:show, :index, :update])
    resources("/couriers", CourierController, except: [:new, :edit, :delete])
    resources("/patients", PatientController, except: [:new, :edit, :delete])
    resources("/orders", OrderController, only: [:show, :index, :update])
    resources("/pharmacies", PharmacyController, except: [:new, :edit, :delete])
  end

  scope "/api/users", PharmaDashWeb do
    pipe_through([:api])

    post("/sign_in", UserController, :sign_in)
    post("/pharmacies/:id", UserController, :create_pharmacy_user)
    post("/couriers/:id", UserController, :create_courier_user)
  end

  scope "/api/orders", PharmaDashWeb do
    pipe_through([:api, :api_auth])

    get("/couriers/:courier_id", OrderController, :show_courier_orders)
    get("/pharmacies/:pharmacy_id", OrderController, :list_pharmacy_orders)

    post(
      "/pharmacies/:pharmacy_id/couriers/:courier_id/patients/:patient_id",
      OrderController,
      :create_order
    )

    patch("/:order_id/cancel", OrderController, :cancel_order)
    patch("/:order_id/uncancel", OrderController, :uncancel_order)
    patch("/:order_id/delivered", OrderController, :set_order_delivered)
    patch("/:order_id/undelivered", OrderController, :set_order_not_delivered)
    patch("/:order_id/deliverable", OrderController, :set_order_is_deliverable)
    patch("/:order_id/undeliverable", OrderController, :set_order_is_not_deliverable)
  end

  scope "/api/couriers", PharmaDashWeb do
    pipe_through([:api, :api_auth])
    post("/pharmacies/:pharmacy_id", CourierController, :create_courier)
    get("/pharmacies/:pharmacy_id", CourierController, :get_couriers)
  end

  scope "/api/patients", PharmaDashWeb do
    pipe_through([:api, :api_auth])

    post(
      "/pharmacies/:pharmacy_id",
      PatientController,
      :create_patient_with_pharmacy
    )

    get(
      "/pharmacies/:pharmacy_id",
      PatientController,
      :list_pharmacy_patients
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
