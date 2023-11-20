defmodule CoyapiWeb.AuthController do
  alias Ecto.Changeset
  alias CoyapiWeb.Auth.Guardian
  alias Coyapi.Users.Create

  import Ecto.Changeset, only: [traverse_errors: 2]

  use CoyapiWeb, :controller

  def login(conn, params) do
    case Guardian.authenticate(params) do
      {:ok, token} -> json(conn, %{token: token})
      {:error, %{result: result}} -> conn |> put_status(500) |> json(%{error: result})
      _ -> conn |> put_status(500) |> json(%{error: "Error"})
    end
  end

  def register(conn, params) do
    case Create.call(params) do
      {:ok, user} ->
        json(conn, %{user: user})

      {:error, %Changeset{} = user} ->
        conn |> put_status(400) |> json(%{errors: translate_errors(user)})
    end
  end

  defp translate_errors(changeset) do
    traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, result}, acc ->
        String.replace(acc, "%{#{key}}", to_string(result))
      end)
    end)
  end
end
