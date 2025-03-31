defmodule DengutechWeb.BaseConocimientoControllerTest do
  use DengutechWeb.ConnCase

  import Dengutech.KnowledgeFixtures

  alias Dengutech.Knowledge.BaseConocimiento

  @create_attrs %{
    data: %{}
  }
  @update_attrs %{
    data: %{}
  }
  @invalid_attrs %{data: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all base_conocimientos", %{conn: conn} do
      conn = get(conn, ~p"/api/base_conocimientos")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create base_conocimiento" do
    test "renders base_conocimiento when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/base_conocimientos", base_conocimiento: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/base_conocimientos/#{id}")

      assert %{
               "id" => ^id,
               "data" => %{}
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/base_conocimientos", base_conocimiento: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update base_conocimiento" do
    setup [:create_base_conocimiento]

    test "renders base_conocimiento when data is valid", %{conn: conn, base_conocimiento: %BaseConocimiento{id: id} = base_conocimiento} do
      conn = put(conn, ~p"/api/base_conocimientos/#{base_conocimiento}", base_conocimiento: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/base_conocimientos/#{id}")

      assert %{
               "id" => ^id,
               "data" => %{}
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, base_conocimiento: base_conocimiento} do
      conn = put(conn, ~p"/api/base_conocimientos/#{base_conocimiento}", base_conocimiento: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete base_conocimiento" do
    setup [:create_base_conocimiento]

    test "deletes chosen base_conocimiento", %{conn: conn, base_conocimiento: base_conocimiento} do
      conn = delete(conn, ~p"/api/base_conocimientos/#{base_conocimiento}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/base_conocimientos/#{base_conocimiento}")
      end
    end
  end

  defp create_base_conocimiento(_) do
    base_conocimiento = base_conocimiento_fixture()
    %{base_conocimiento: base_conocimiento}
  end
end
