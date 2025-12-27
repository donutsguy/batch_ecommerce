defmodule BatchEcommerce.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string, size: 60
      add :price, :decimal, precision: 10, scale: 2, null: false
      add :active, :boolean, default: true
      add :stock_quantity, :integer, precision: 5
      add :photo_filename, :string
      add :description, :text
      add :sales_quantity, :integer
      add :discount, :integer
      add :company_id, references(:companies, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end
  end
end
