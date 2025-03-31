defmodule DengutechWeb.BaseConocimientoJSON do
  alias Dengutech.Knowledge.BaseConocimiento

  @doc """
  Renders a list of base_conocimientos.
  """
  def index(%{base_conocimientos: base_conocimientos}) do
    %{data: for(base_conocimiento <- base_conocimientos, do: data(base_conocimiento))}
  end

  @doc """
  Renders a single base_conocimiento.
  """
  def show(%{base_conocimiento: base_conocimiento}) do
    %{data: data(base_conocimiento)}
  end

  defp data(%BaseConocimiento{} = base_conocimiento) do
    %{
      id: base_conocimiento.id,
      data: base_conocimiento.data
    }
  end
end
