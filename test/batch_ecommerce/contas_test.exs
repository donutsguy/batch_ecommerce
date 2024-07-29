defmodule BatchEcommerce.ContasTest do
  use BatchEcommerce.DataCase

  alias BatchEcommerce.Contas

  describe "responsaveis" do
    alias BatchEcommerce.Contas.Responsavel

    import BatchEcommerce.ContasFixtures

    @invalid_attrs %{nome: nil, cpf: nil, senha_hash: nil, email: nil, telefone: nil, endereco_id: nil, tipo_id: nil}

    test "list_responsaveis/0 returns all responsaveis" do
      responsavel = responsavel_fixture()
      assert Contas.list_responsaveis() == [responsavel]
    end

    test "get_responsavel!/1 returns the responsavel with given id" do
      responsavel = responsavel_fixture()
      assert Contas.get_responsavel!(responsavel.id) == responsavel
    end

    test "create_responsavel/1 with valid data creates a responsavel" do
      valid_attrs = %{nome: "some nome", cpf: "some cpf", senha_hash: "some senha_hash", email: "some email", telefone: "some telefone", endereco_id: 42, tipo_id: 42}

      assert {:ok, %Responsavel{} = responsavel} = Contas.create_responsavel(valid_attrs)
      assert responsavel.nome == "some nome"
      assert responsavel.cpf == "some cpf"
      assert responsavel.senha_hash == "some senha_hash"
      assert responsavel.email == "some email"
      assert responsavel.telefone == "some telefone"
      assert responsavel.endereco_id == 42
      assert responsavel.tipo_id == 42
    end

    test "create_responsavel/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Contas.create_responsavel(@invalid_attrs)
    end

    test "update_responsavel/2 with valid data updates the responsavel" do
      responsavel = responsavel_fixture()
      update_attrs = %{nome: "some updated nome", cpf: "some updated cpf", senha_hash: "some updated senha_hash", email: "some updated email", telefone: "some updated telefone", endereco_id: 43, tipo_id: 43}

      assert {:ok, %Responsavel{} = responsavel} = Contas.update_responsavel(responsavel, update_attrs)
      assert responsavel.nome == "some updated nome"
      assert responsavel.cpf == "some updated cpf"
      assert responsavel.senha_hash == "some updated senha_hash"
      assert responsavel.email == "some updated email"
      assert responsavel.telefone == "some updated telefone"
      assert responsavel.endereco_id == 43
      assert responsavel.tipo_id == 43
    end

    test "update_responsavel/2 with invalid data returns error changeset" do
      responsavel = responsavel_fixture()
      assert {:error, %Ecto.Changeset{}} = Contas.update_responsavel(responsavel, @invalid_attrs)
      assert responsavel == Contas.get_responsavel!(responsavel.id)
    end

    test "delete_responsavel/1 deletes the responsavel" do
      responsavel = responsavel_fixture()
      assert {:ok, %Responsavel{}} = Contas.delete_responsavel(responsavel)
      assert_raise Ecto.NoResultsError, fn -> Contas.get_responsavel!(responsavel.id) end
    end

    test "change_responsavel/1 returns a responsavel changeset" do
      responsavel = responsavel_fixture()
      assert %Ecto.Changeset{} = Contas.change_responsavel(responsavel)
    end
  end
end
