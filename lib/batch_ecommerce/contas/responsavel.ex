defmodule BatchEcommerce.Contas.Responsavel do
  use Ecto.Schema
  import Ecto.Changeset

  schema "responsaveis" do
    field :nome, :string
    field :cpf, :string
    field :senha_hash, :string
    field :senha, :string, virtual: true
    field :email, :string
    field :telefone, :string
    field :endereco_id, :integer
    field :tipo_id, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(responsavel, attrs) do
    responsavel
    |> cast(attrs, [:nome, :cpf, :senha, :email, :telefone, :endereco_id, :tipo_id])
    |> validate_required([:nome, :cpf, :senha, :email, :telefone, :endereco_id, :tipo_id])
    |> unique_constraint([:cpf, :email, :telefone])
    |> password_hash()
  end

  @doc false
  defp password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{senha: senha}} ->
        put_change(changeset, :senha_hash, Bcrypt.hash_pwd_salt(senha))

      %Ecto.Changeset{valid?: true, changes: _} ->
        changeset

      %Ecto.Changeset{valid?: false} ->
        changeset
    end
  end
end
