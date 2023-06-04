defmodule Blog.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :subtitle, :string
      add :content, :text

      timestamps()
    end

    create unique_index(:posts, [:title])
  end
end
