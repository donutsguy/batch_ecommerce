defmodule BatchEcommerce.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :price, :decimal
      add :stock_quantity, :integer
      add :image_url, :string
      add :description, :string
      add :sales_quantity, :integer
      add :discount, :integer
      add :company_id, references(:companies, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

  end
end
