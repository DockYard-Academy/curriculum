defmodule Blog.Repo.Migrations.AddVisibilityFiltersToPost do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      remove :subtitle
      add :visible, :boolean, default: true
      add :published_on, :utc_datetime
    end

    create unique_index(:posts, [:title])
  end
end
