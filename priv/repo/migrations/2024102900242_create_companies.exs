defmodule BatchEcommerce.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add :cnpj, :string, size: 14, null: false
      add :user_id, references(:users, type: :uuid, on_delete: :restrict), null: false
      add :name, :citext, size: 80, null: false
      add :email, :citext, size: 254, null: false
      add :phone_number, :string, size: 13, null: false
      add :photo_filename, :string
      add :minio_bucket_name, :string

      timestamps()
    end

    create unique_index(:companies, :cnpj)
    create unique_index(:companies, :email)
    create unique_index(:companies, :phone_number)
    create index(:companies, :user_id)
    create index(:companies, [:name, :photo_filename])
  end
end
