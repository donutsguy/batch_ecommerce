defmodule BatchEcommerce.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :cpf_cnpj, :string, size: 14, null: false
      add :name, :citext, size: 60, null: false
      add :email, :citext, size: 254, null: false
      add :phone_number, :string, size: 13
      add :birth_date, :date
      add :is_active, :boolean, default: true
      add :password_hash, :string, null: false
      add :photo_filename, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:users, :cpf_cnpj)
    create unique_index(:users, :email)
    create unique_index(:users, :phone_number)
    create index(:users, [:name, :photo_filename])
  end
end
