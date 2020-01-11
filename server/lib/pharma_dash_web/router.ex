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
    post("/users/pharmacies/:id", UserController, :create_pharmacy_user)
    post("/users/couriers/:id", UserController, :create_courier_user)
  end

  scope "/api", PharmaDashWeb do
    pipe_through([:api, :api_auth])

    resources("/users", UserController, except: [:create, :new, :edit, :delete])
    resources("/couriers", CourierController, except: [:new, :edit, :delete])
    resources("/patients", PatientController, except: [:new, :edit, :delete])
    resources("/orders", OrderController, except: [:new, :edit, :delete])
    resources("/pharmacies", PharmacyController, except: [:new, :edit, :delete])
  end

  scope "/api/orders", PharmaDashWeb do
    pipe_through([:api, :api_auth])

    get(
      "/couriers/:courier_id",
      OrderController,
      :show_courier_orders
    )

    post(
      "/pharmacies/:pharmacy_id/couriers/:courier_id/patients/:patient_id",
      OrderController,
      :create_order
    )

    get(
      "/pharmacies/:pharmacy_id",
      OrderController,
      :list_pharmacy_orders
    )
  end

  scope "/api/couriers", PharmaDashWeb do
    # TODO: Only pharmacy users should have access to their /pharmacies/ endpoints. Create plug verify_pharmacy, add to new pipeline
    pipe_through([:api, :api_auth])
    post("/pharmacies/:pharmacy_id", CourierController, :create_courier)
    get("/pharmacies/:pharmacy_id", CourierController, :get_couriers)
  end

  scope "/api/patients", PharmaDashWeb do
    # TODO: Only pharmacy users should have access to their /pharmacies/ endpoints. Create plug verify_pharmacy, add to new pipeline
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
