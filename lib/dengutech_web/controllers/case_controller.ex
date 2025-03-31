defmodule DengutechWeb.CaseController do
  use DengutechWeb, :controller

  alias Dengutech.Disease
  alias Dengutech.Disease.Case

  action_fallback DengutechWeb.FallbackController

  def index(conn, _params) do
    cases = Disease.list_cases()
    render(conn, :index, cases: cases)
  end



  def diagnosis_and_date_of_onset(conn, _params) do
    cases = Disease.list_cases() # Obtiene todos los casos
    filtered_data = Enum.map(cases, fn case ->
      %{diagnosis: case.diagnosis, date_of_onset: case.date_of_onset}
    end)

    json(conn, %{data: filtered_data})
  end

  def create(conn, params) do
    case parse_date(params["date_of_onset"]) do
      {:ok, date} ->
        case Disease.create_case(Map.put(params, "date_of_onset", date)) do
          {:ok, case} ->
            conn
            |> put_status(:created)
            |> put_resp_header("location", ~p"/api/cases/#{case}")
            |> render("show.json", case: case)

          {:error, changeset} ->
            conn
            |> put_status(:unprocessable_entity)
            |> put_view(DengutechWeb.ChangesetJSON)
            |> render("error.json", changeset: changeset)
        end
      {:error, _error} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(DengutechWeb.ChangesetJSON)
        |> render("error.json", changeset: %Ecto.Changeset{errors: [date_of_onset: {"invalid date format", []}]})
    end
  end

  defp parse_date(date_string) do
    case Date.from_iso8601(date_string) do
      {:ok, date} -> {:ok, date}
      {:error, error} -> {:error, error}
    end
  end

  def show(conn, %{"id" => id}) do
    case = Disease.get_case!(id)
    render(conn, :show, case: case)
  end

  def update(conn, %{"id" => id, "case" => case_params}) do
    case = Disease.get_case!(id)

    with {:ok, %Case{} = case} <- Disease.update_case(case, case_params) do
      render(conn, :show, case: case)
    end
  end

  def delete(conn, %{"id" => id}) do
    case = Disease.get_case!(id)

    with {:ok, %Case{}} <- Disease.delete_case(case) do
      send_resp(conn, :no_content, "")
    end
  end

  def index_filtered(conn, _params) do
    cases = Dengutech.Disease.list_cases_without_diagnosis_and_date()

    json(conn, %{cases: cases})
  end

  def run_learning(conn, _params) do
    Dengutech.Disease.execute_learning_and_save()
    send_resp(conn, :ok, "Learning completed and results saved")
  end
end
