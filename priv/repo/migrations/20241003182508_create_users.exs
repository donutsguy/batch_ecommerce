defmodule BatchEcommerce.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :cpf, :string
      add :name, :string
      add :email, :string
      add :phone_number, :string
      add :birth_date, :date
      add :password_hash, :string
      add :address_id, references(:addresses)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:users, :email)
    create unique_index(:users, :cpf)
    create unique_index(:users, :phone_number)
  end
end
