defmodule Coyapi.Repository do
  @moduledoc false
  @keys [:id, :name, :description, :html_url, :stargazers_count]
  @enforce_keys @keys
  @derive {Jason.Encoder, only: @keys}
  defstruct @keys
end
