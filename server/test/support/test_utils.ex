# defmodule PharmaDashWeb.TestUtils do
#   # use PharmaDashWeb.ConnCase

#   alias PharmaDash.Auth
#   alias PharmaDash.Auth.User
#   alias Plug.Test

#   @current_user_attrs %{
#     email: "some current user email",
#     is_active: true,
#     password: "some current user password",
#     name: "some current user name"
#   }

#   defp setup_current_user(conn) do
#     current_user = fixture(:current_user)

#     {:ok,
#      conn: Test.init_test_session(conn, current_user_id: current_user.id),
#      current_user: current_user}
#   end

#   def fixture(:current_user) do
#     {:ok, current_user} = Auth.create_user(@current_user_attrs)
#     current_user
#   end
# end
