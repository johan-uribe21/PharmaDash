defmodule PharmaDash.PeopleTest do
  use PharmaDash.DataCase

  alias PharmaDash.People

  describe "patients" do
    alias PharmaDash.People.Patient

    @valid_attrs %{city: "some city", name: "some name", stateAbr: "some stateAbr", street: "some street", zipcode: "some zipcode"}
    @update_attrs %{city: "some updated city", name: "some updated name", stateAbr: "some updated stateAbr", street: "some updated street", zipcode: "some updated zipcode"}
    @invalid_attrs %{city: nil, name: nil, stateAbr: nil, street: nil, zipcode: nil}

    def patient_fixture(attrs \\ %{}) do
      {:ok, patient} =
        attrs
        |> Enum.into(@valid_attrs)
        |> People.create_patient()

      patient
    end

    test "list_patients/0 returns all patients" do
      patient = patient_fixture()
      assert People.list_patients() == [patient]
    end

    test "get_patient!/1 returns the patient with given id" do
      patient = patient_fixture()
      assert People.get_patient!(patient.id) == patient
    end

    test "create_patient/1 with valid data creates a patient" do
      assert {:ok, %Patient{} = patient} = People.create_patient(@valid_attrs)
      assert patient.city == "some city"
      assert patient.name == "some name"
      assert patient.stateAbr == "some stateAbr"
      assert patient.street == "some street"
      assert patient.zipcode == "some zipcode"
    end

    test "create_patient/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = People.create_patient(@invalid_attrs)
    end

    test "update_patient/2 with valid data updates the patient" do
      patient = patient_fixture()
      assert {:ok, %Patient{} = patient} = People.update_patient(patient, @update_attrs)
      assert patient.city == "some updated city"
      assert patient.name == "some updated name"
      assert patient.stateAbr == "some updated stateAbr"
      assert patient.street == "some updated street"
      assert patient.zipcode == "some updated zipcode"
    end

    test "update_patient/2 with invalid data returns error changeset" do
      patient = patient_fixture()
      assert {:error, %Ecto.Changeset{}} = People.update_patient(patient, @invalid_attrs)
      assert patient == People.get_patient!(patient.id)
    end

    test "delete_patient/1 deletes the patient" do
      patient = patient_fixture()
      assert {:ok, %Patient{}} = People.delete_patient(patient)
      assert_raise Ecto.NoResultsError, fn -> People.get_patient!(patient.id) end
    end

    test "change_patient/1 returns a patient changeset" do
      patient = patient_fixture()
      assert %Ecto.Changeset{} = People.change_patient(patient)
    end
  end
end
