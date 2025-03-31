defmodule Dengutech.DiseaseTest do
  use Dengutech.DataCase

  alias Dengutech.Disease

  describe "cases" do
    alias Dengutech.Disease.Case

    import Dengutech.DiseaseFixtures

    @invalid_attrs %{fever: nil, headache: nil, muscle_pain: nil, joint_pain: nil, nausea: nil, retrocular_pain: nil, fatigue: nil, swollen_glands: nil, abdominal_pain: nil, vomiting: nil, bleeding: nil, respiratory_distress: nil, lethargy: nil, age: nil, region: nil, date_of_onset: nil, diagnosis: nil}

    test "list_cases/0 returns all cases" do
      case = case_fixture()
      assert Disease.list_cases() == [case]
    end

    test "get_case!/1 returns the case with given id" do
      case = case_fixture()
      assert Disease.get_case!(case.id) == case
    end

    test "create_case/1 with valid data creates a case" do
      valid_attrs = %{fever: 42, headache: 42, muscle_pain: 42, joint_pain: 42, nausea: 42, retrocular_pain: 42, fatigue: 42, swollen_glands: 42, abdominal_pain: 42, vomiting: 42, bleeding: 42, respiratory_distress: 42, lethargy: 42, age: 120.5, region: 120.5, date_of_onset: ~D[2025-03-19], diagnosis: 42}

      assert {:ok, %Case{} = case} = Disease.create_case(valid_attrs)
      assert case.fever == 42
      assert case.headache == 42
      assert case.muscle_pain == 42
      assert case.joint_pain == 42
      assert case.nausea == 42
      assert case.retrocular_pain == 42
      assert case.fatigue == 42
      assert case.swollen_glands == 42
      assert case.abdominal_pain == 42
      assert case.vomiting == 42
      assert case.bleeding == 42
      assert case.respiratory_distress == 42
      assert case.lethargy == 42
      assert case.age == 120.5
      assert case.region == 120.5
      assert case.date_of_onset == ~D[2025-03-19]
      assert case.diagnosis == 42
    end

    test "create_case/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Disease.create_case(@invalid_attrs)
    end

    test "update_case/2 with valid data updates the case" do
      case = case_fixture()
      update_attrs = %{fever: 43, headache: 43, muscle_pain: 43, joint_pain: 43, nausea: 43, retrocular_pain: 43, fatigue: 43, swollen_glands: 43, abdominal_pain: 43, vomiting: 43, bleeding: 43, respiratory_distress: 43, lethargy: 43, age: 456.7, region: 456.7, date_of_onset: ~D[2025-03-20], diagnosis: 43}

      assert {:ok, %Case{} = case} = Disease.update_case(case, update_attrs)
      assert case.fever == 43
      assert case.headache == 43
      assert case.muscle_pain == 43
      assert case.joint_pain == 43
      assert case.nausea == 43
      assert case.retrocular_pain == 43
      assert case.fatigue == 43
      assert case.swollen_glands == 43
      assert case.abdominal_pain == 43
      assert case.vomiting == 43
      assert case.bleeding == 43
      assert case.respiratory_distress == 43
      assert case.lethargy == 43
      assert case.age == 456.7
      assert case.region == 456.7
      assert case.date_of_onset == ~D[2025-03-20]
      assert case.diagnosis == 43
    end

    test "update_case/2 with invalid data returns error changeset" do
      case = case_fixture()
      assert {:error, %Ecto.Changeset{}} = Disease.update_case(case, @invalid_attrs)
      assert case == Disease.get_case!(case.id)
    end

    test "delete_case/1 deletes the case" do
      case = case_fixture()
      assert {:ok, %Case{}} = Disease.delete_case(case)
      assert_raise Ecto.NoResultsError, fn -> Disease.get_case!(case.id) end
    end

    test "change_case/1 returns a case changeset" do
      case = case_fixture()
      assert %Ecto.Changeset{} = Disease.change_case(case)
    end
  end
end
