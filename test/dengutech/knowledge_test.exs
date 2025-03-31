defmodule Dengutech.KnowledgeTest do
  use Dengutech.DataCase

  alias Dengutech.Knowledge

  describe "base_conocimientos" do
    alias Dengutech.Knowledge.BaseConocimiento

    import Dengutech.KnowledgeFixtures

    @invalid_attrs %{data: nil}

    test "list_base_conocimientos/0 returns all base_conocimientos" do
      base_conocimiento = base_conocimiento_fixture()
      assert Knowledge.list_base_conocimientos() == [base_conocimiento]
    end

    test "get_base_conocimiento!/1 returns the base_conocimiento with given id" do
      base_conocimiento = base_conocimiento_fixture()
      assert Knowledge.get_base_conocimiento!(base_conocimiento.id) == base_conocimiento
    end

    test "create_base_conocimiento/1 with valid data creates a base_conocimiento" do
      valid_attrs = %{data: %{}}

      assert {:ok, %BaseConocimiento{} = base_conocimiento} = Knowledge.create_base_conocimiento(valid_attrs)
      assert base_conocimiento.data == %{}
    end

    test "create_base_conocimiento/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Knowledge.create_base_conocimiento(@invalid_attrs)
    end

    test "update_base_conocimiento/2 with valid data updates the base_conocimiento" do
      base_conocimiento = base_conocimiento_fixture()
      update_attrs = %{data: %{}}

      assert {:ok, %BaseConocimiento{} = base_conocimiento} = Knowledge.update_base_conocimiento(base_conocimiento, update_attrs)
      assert base_conocimiento.data == %{}
    end

    test "update_base_conocimiento/2 with invalid data returns error changeset" do
      base_conocimiento = base_conocimiento_fixture()
      assert {:error, %Ecto.Changeset{}} = Knowledge.update_base_conocimiento(base_conocimiento, @invalid_attrs)
      assert base_conocimiento == Knowledge.get_base_conocimiento!(base_conocimiento.id)
    end

    test "delete_base_conocimiento/1 deletes the base_conocimiento" do
      base_conocimiento = base_conocimiento_fixture()
      assert {:ok, %BaseConocimiento{}} = Knowledge.delete_base_conocimiento(base_conocimiento)
      assert_raise Ecto.NoResultsError, fn -> Knowledge.get_base_conocimiento!(base_conocimiento.id) end
    end

    test "change_base_conocimiento/1 returns a base_conocimiento changeset" do
      base_conocimiento = base_conocimiento_fixture()
      assert %Ecto.Changeset{} = Knowledge.change_base_conocimiento(base_conocimiento)
    end
  end
end
