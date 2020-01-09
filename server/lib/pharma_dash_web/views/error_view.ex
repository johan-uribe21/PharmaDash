defmodule PharmaDashWeb.ErrorView do
  use PharmaDashWeb, :view

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".
  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end

  def render("401.json", %{message: message}) do
    %{errors: %{detail: message}}
  end

  def render("422_detail_message.json", %{name: message}) do
    IO.inspect(message)
    %{errors: %{detail: elem(message, 0)}}
  end
end

# errors: [
#   name: {"Entity names must be unique",
#    [constraint: :unique, constraint_name: "pharmacies_name_index"]}
# ],
