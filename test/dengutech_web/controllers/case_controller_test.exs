defmodule DengutechWeb.CaseControllerTest do
  use DengutechWeb.ConnCase

  import Dengutech.DiseaseFixtures

  alias Dengutech.Disease.Case

  @create_attrs %{
    fever: 42,
    headache: 42,
    muscle_pain: 42,
    joint_pain: 42,
    nausea: 42,
    retrocular_pain: 42,
    fatigue: 42,
    swollen_glands: 42,
    abdominal_pain: 42,
    vomiting: 42,
    bleeding: 42,
    respiratory_distress: 42,
    lethargy: 42,
    age: 120.5,
    region: 120.5,
    date_of_onset: ~D[2025-03-19],
    diagnosis: 42
  }
  @update_attrs %{
    fever: 43,
    headache: 43,
    muscle_pain: 43,
    joint_pain: 43,
    nausea: 43,
    retrocular_pain: 43,
    fatigue: 43,
    swollen_glands: 43,
    abdominal_pain: 43,
    vomiting: 43,
    bleeding: 43,
    respiratory_distress: 43,
    lethargy: 43,
    age: 456.7,
    region: 456.7,
    date_of_onset: ~D[2025-03-20],
    diagnosis: 43
  }
  @invalid_attrs %{fever: nil, headache: nil, muscle_pain: nil, joint_pain: nil, nausea: nil, retrocular_pain: nil, fatigue: nil, swollen_glands: nil, abdominal_pain: nil, vomiting: nil, bleeding: nil, respiratory_distress: nil, lethargy: nil, age: nil, region: nil, date_of_onset: nil, diagnosis: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all cases", %{conn: conn} do
      conn = get(conn, ~p"/api/cases")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create case" do
    test "renders case when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/cases", case: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/cases/#{id}")

      assert %{
               "id" => ^id,
               "abdominal_pain" => 42,
               "age" => 120.5,
               "bleeding" => 42,
               "date_of_onset" => "2025-03-19",
               "diagnosis" => 42,
               "fatigue" => 42,
               "fever" => 42,
               "headache" => 42,
               "joint_pain" => 42,
               "lethargy" => 42,
               "muscle_pain" => 42,
               "nausea" => 42,
               "region" => 120.5,
               "respiratory_distress" => 42,
               "retrocular_pain" => 42,
               "swollen_glands" => 42,
               "vomiting" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/cases", case: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update case" do
    setup [:create_case]

    test "renders case when data is valid", %{conn: conn, case: %Case{id: id} = case} do
      conn = put(conn, ~p"/api/cases/#{case}", case: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/cases/#{id}")

      assert %{
               "id" => ^id,
               "abdominal_pain" => 43,
               "age" => 456.7,
               "bleeding" => 43,
               "date_of_onset" => "2025-03-20",
               "diagnosis" => 43,
               "fatigue" => 43,
               "fever" => 43,
               "headache" => 43,
               "joint_pain" => 43,
               "lethargy" => 43,
               "muscle_pain" => 43,
               "nausea" => 43,
               "region" => 456.7,
               "respiratory_distress" => 43,
               "retrocular_pain" => 43,
               "swollen_glands" => 43,
               "vomiting" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, case: case} do
      conn = put(conn, ~p"/api/cases/#{case}", case: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete case" do
    setup [:create_case]

    test "deletes chosen case", %{conn: conn, case: case} do
      conn = delete(conn, ~p"/api/cases/#{case}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/cases/#{case}")
      end
    end
  end

  defp create_case(_) do
    case = case_fixture()
    %{case: case}
  end
end
