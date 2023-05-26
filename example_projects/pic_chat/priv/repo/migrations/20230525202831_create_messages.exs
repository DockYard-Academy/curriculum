defmodule PicChat.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :content, :text

      timestamps()
    end
  end
end
