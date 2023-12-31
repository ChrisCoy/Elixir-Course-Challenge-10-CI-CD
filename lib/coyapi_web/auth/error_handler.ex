defmodule CoyapiWeb.Auth.ErrorHandler do
  @moduledoc false
  alias Plug.Conn
  alias Guardian.Plug.ErrorHandler

  @behaviour ErrorHandler

  def auth_error(conn, {error, _reason}, _opts) do
    body = Jason.encode!(%{message: to_string(error)})
    Conn.send_resp(conn, 500, body)
  end
end
