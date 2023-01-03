defmodule ToolBox.Repo.Migrations.CreateBoxItems do
  use Ecto.Migration

  def change do
    create table(:box_items) do
      add :short_description, :string
      add :snapshot, :string
      add :url, :string

      timestamps()
    end
  end
end
