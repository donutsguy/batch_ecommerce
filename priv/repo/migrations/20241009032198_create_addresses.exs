defmodule BatchEcommerce.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add :cep, :string, size: 8, null: false
      add :uf, :string, size: 2, null: false
      add :city, :string, size: 30, null: false
      add :district, :string, size: 20, null: false
      add :address, :string, size: 100, null: false
      add :complement, :string, size: 30
      add :home_number, :string, size: 10, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
