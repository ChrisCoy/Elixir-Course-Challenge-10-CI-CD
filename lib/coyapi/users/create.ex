defmodule Coyapi.Users.Create do
  @moduledoc false
  alias Coyapi.{Repo, User}

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
