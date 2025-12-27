defmodule BatchEcommerce.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string, size: 60
      add :slug, :string, size: 60, null: false
      add :description, :text
      add :is_active, :boolean, default: true
      add :parent_id, references(:categories, type: :integer, on_delete: :nilify_all)
      add :display_order, :integer, default: 0

      timestamps(type: :utc_datetime)
    end

    create index(:categories, :slug, unique: true)
  end
end
