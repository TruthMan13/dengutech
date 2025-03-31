defmodule DengutechWeb.BaseConocimientoController do
  use DengutechWeb, :controller

  alias Dengutech.Knowledge
  alias Dengutech.Knowledge.BaseConocimiento

  action_fallback DengutechWeb.FallbackController

  def index(conn, _params) do
    base_conocimientos = Knowledge.list_base_conocimientos()
    render(conn, :index, base_conocimientos: base_conocimientos)
  end

  def create(conn, %{"base_conocimiento" => base_conocimiento_params}) do
    with {:ok, %BaseConocimiento{} = base_conocimiento} <- Knowledge.create_base_conocimiento(base_conocimiento_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/base_conocimientos/#{base_conocimiento}")
      |> render(:show, base_conocimiento: base_conocimiento)
    end
  end

  def show(conn, %{"id" => id}) do
    base_conocimiento = Knowledge.get_base_conocimiento!(id)
    render(conn, :show, base_conocimiento: base_conocimiento)
  end

  def update(conn, %{"id" => id, "base_conocimiento" => base_conocimiento_params}) do
    base_conocimiento = Knowledge.get_base_conocimiento!(id)

    with {:ok, %BaseConocimiento{} = base_conocimiento} <- Knowledge.update_base_conocimiento(base_conocimiento, base_conocimiento_params) do
      render(conn, :show, base_conocimiento: base_conocimiento)
    end
  end

  def delete(conn, %{"id" => id}) do
    base_conocimiento = Knowledge.get_base_conocimiento!(id)

    with {:ok, %BaseConocimiento{}} <- Knowledge.delete_base_conocimiento(base_conocimiento) do
      send_resp(conn, :no_content, "")
    end
  end
  def predict(conn, params) do
    # Genera el vector a partir de los parámetros
    required_fields = [
      "fever", "headache", "muscle_pain", "joint_pain", "nausea",
      "retrocular_pain", "fatigue", "swollen_glands", "abdominal_pain",
      "vomiting", "bleeding", "respiratory_distress", "lethargy", "age", "region"
    ]

    vector = Enum.map(required_fields, &Map.get(params, &1, nil))

    # Validar que el vector es numérico y tiene 15 elementos
    if length(vector) == 15 and Enum.all?(vector, &is_number/1) do
      case Knowledge.fetch_and_transform_data() do
        {:error, reason} ->
          conn
          |> put_status(:unprocessable_entity)
          |> json(%{error: reason})

        {pesos, centros} ->
          # Llama a predict con vector, pesos y centros
          prediction = SistemaExperto.Learning.predict(vector, centros, pesos)

          conn
          |> put_status(:ok)
          |> json(%{prediction: prediction})
      end
    else
      conn
      |> put_status(:unprocessable_entity)
      |> json(%{error: "El vector debe ser una lista de 15 números"})
    end
  end



end
