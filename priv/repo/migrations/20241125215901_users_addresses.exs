defmodule BatchEcommerce.Repo.Migrations.UsersAddresses do
  use Ecto.Migration

  def change do
    create table(:users_addresses, primary_key: false) do
      add :user_id, references(:users, type: :uuid, on_delete: :delete_all)
      add :address_id, references(:addresses, on_delete: :delete_all)
    end

    create index(:users_addresses, [:user_id])
    create unique_index(:users_addresses, [:user_id, :address_id])
  end
end
