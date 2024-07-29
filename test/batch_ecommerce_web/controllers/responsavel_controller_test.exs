defmodule BatchEcommerceWeb.ResponsavelControllerTest do
  use BatchEcommerceWeb.ConnCase

  import BatchEcommerce.ContasFixtures

  alias BatchEcommerce.Contas.Responsavel

  @create_attrs %{
    nome: "some nome",
    cpf: "some cpf",
    senha_hash: "some senha_hash",
    email: "some email",
    telefone: "some telefone",
    endereco_id: 42,
    tipo_id: 42
  }
  @update_attrs %{
    nome: "some updated nome",
    cpf: "some updated cpf",
    senha_hash: "some updated senha_hash",
    email: "some updated email",
    telefone: "some updated telefone",
    endereco_id: 43,
    tipo_id: 43
  }
  @invalid_attrs %{nome: nil, cpf: nil, senha_hash: nil, email: nil, telefone: nil, endereco_id: nil, tipo_id: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all responsaveis", %{conn: conn} do
      conn = get(conn, ~p"/api/responsaveis")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create responsavel" do
    test "renders responsavel when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/responsaveis", responsavel: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/responsaveis/#{id}")

      assert %{
               "id" => ^id,
               "cpf" => "some cpf",
               "email" => "some email",
               "endereco_id" => 42,
               "nome" => "some nome",
               "senha_hash" => "some senha_hash",
               "telefone" => "some telefone",
               "tipo_id" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/responsaveis", responsavel: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update responsavel" do
    setup [:create_responsavel]

    test "renders responsavel when data is valid", %{conn: conn, responsavel: %Responsavel{id: id} = responsavel} do
      conn = put(conn, ~p"/api/responsaveis/#{responsavel}", responsavel: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/responsaveis/#{id}")

      assert %{
               "id" => ^id,
               "cpf" => "some updated cpf",
               "email" => "some updated email",
               "endereco_id" => 43,
               "nome" => "some updated nome",
               "senha_hash" => "some updated senha_hash",
               "telefone" => "some updated telefone",
               "tipo_id" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, responsavel: responsavel} do
      conn = put(conn, ~p"/api/responsaveis/#{responsavel}", responsavel: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete responsavel" do
    setup [:create_responsavel]

    test "deletes chosen responsavel", %{conn: conn, responsavel: responsavel} do
      conn = delete(conn, ~p"/api/responsaveis/#{responsavel}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/responsaveis/#{responsavel}")
      end
    end
  end

  defp create_responsavel(_) do
    responsavel = responsavel_fixture()
    %{responsavel: responsavel}
  end
end
