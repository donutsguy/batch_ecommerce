defmodule BatchEcommerce.AccountsTest do
  @moduledoc """
  The Accounts context test module.
  """
  use BatchEcommerce.DataCase, async: true

  alias BatchEcommerce.Accounts

  describe "users" do
    alias BatchEcommerce.Accounts.User

    import BatchEcommerce.AccountsFixtures

    @invalid_attrs %{
      cpf: nil,
      name: nil,
      email: nil,
      phone_number: nil,
      birth_date: nil,
      password: nil,
      address: nil
    }

    test "list_users/0 returns all users" do
      user = user_fixture()
      [found_user] = Accounts.list_users()

      fields_to_remove = [:password]
      assert [Map.drop(found_user, fields_to_remove)] == [Map.drop(user, fields_to_remove)]
    end

    test "get_user/1 returns the user with given id" do
      user = user_fixture()
      %User{} = found_user = Accounts.get_user(user.id)

      fields_to_remove = [:password]
      assert Map.drop(found_user, fields_to_remove) == Map.drop(user, fields_to_remove)
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{
        cpf: "52511111111",
        name: "murilo",
        email: "murilo@hotmail.com",
        phone_number: "11979897989",
        birth_date: ~D[2004-05-06],
        password: "password",
        address: %{
          address: "rua elixir",
          cep: "09071000",
          uf: "SP",
          city: "cidade java",
          district: "vila programação",
          complement: "casa",
          home_number: "321"
        }
      }

      assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
      assert user.cpf == "52511111111"
      assert user.name == "murilo"
      assert user.email == "murilo@hotmail.com"
      assert user.phone_number == "11979897989"
      assert user.birth_date == ~D[2004-05-06]
      refute is_nil(user.password_hash)

      assert user.address.address == "rua elixir"
      assert user.address.cep == "09071000"
      assert user.address.uf == "SP"
      assert user.address.city == "cidade java"
      assert user.address.district == "vila programação"
      assert user.address.complement == "casa"
      assert user.address.home_number == "321"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()

      update_attrs = %{
        cpf: "52511111111",
        name: "murilo updated",
        email: "murilo@hotmail.com",
        phone_number: "11979897989",
        birth_date: ~D[2005-05-06],
        password: "password",
        address: %{
          address: "rua python",
          cep: "09071001",
          uf: "MG",
          city: "cidade ruby",
          district: "vila destruição",
          complement: "apartamento",
          home_number: "123"
        }
      }

      assert {:ok, %User{} = user} = Accounts.update_user(user, update_attrs)
      assert user.cpf == "52511111111"
      assert user.name == "murilo updated"
      assert user.email == "murilo@hotmail.com"
      assert user.phone_number == "11979897989"
      assert user.birth_date == ~D[2005-05-06]
      refute is_nil(user.password_hash)

      assert user.address.address == "rua python"
      assert user.address.cep == "09071001"
      assert user.address.uf == "MG"
      assert user.address.city == "cidade ruby"
      assert user.address.district == "vila destruição"
      assert user.address.complement == "apartamento"
      assert user.address.home_number == "123"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)

      fields_to_drop = [:password]

      %User{} = user_found = Accounts.get_user(user.id)

      assert Map.drop(user, fields_to_drop) ==
               Map.drop(user_found, fields_to_drop)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert Accounts.get_user(user.id) == nil
    end

    test "authenticate_user/2 with existent email and password authenticate user" do
      valid_password = %{password: "password"}

      user = user_fixture(valid_password)

      assert {:ok, returned_user} =
               Accounts.authenticate_user(user.email, valid_password.password)

      assert returned_user.id == user.id
    end

    test "authenticate_user/2 with non-existent email or password return error" do
      assert {:error, :invalid_credentials} =
               Accounts.authenticate_user("naoexiste@exemplo.com", "qualquersenha")
    end
  end
end
