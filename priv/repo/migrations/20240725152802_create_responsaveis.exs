defmodule BatchEcommerce.Repo.Migrations.CreateResponsaveis do
  use Ecto.Migration

  def change do
    create table(:responsaveis) do
      add :nome, :string
      add :cpf, :string
      add :senha_hash, :string
      add :email, :string
      add :telefone, :string
      add :endereco_id, :integer
      add :tipo_id, :integer

      timestamps(type: :utc_datetime)
    end

    create unique_index(:responsaveis, [:cpf, :email, :telefone])
  end
end
