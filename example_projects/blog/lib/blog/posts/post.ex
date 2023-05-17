defmodule Blog.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :content, :string
    field :title, :string
    field :visible, :boolean, default: true
    field :published_on, :utc_datetime

    has_many :comments, Blog.Comments.Comment
    belongs_to :user, Blog.Accounts.User
    many_to_many :tags, Blog.Tags.Tag, join_through: "posts_tags", on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(post, attrs, tags \\ []) do
    post
    |> cast(attrs, [:title, :content, :visible, :published_on, :user_id])
    |> validate_required([:title, :content, :visible, :user_id])
    |> unique_constraint(:title)
    |> foreign_key_constraint(:user_id)
    |> put_assoc(:tags, tags)
  end
end
