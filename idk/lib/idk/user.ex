defmodule Idk.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Idk.User

  schema "users" do
    field :name, :string
    field :unhashed_password, :string, virtual: true
    field :password, :string
    field :email, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} =user, attrs) do
    user
    |> cast(attrs, [:name, :unhashed_password, :email])
    |> validate_required([:name, :email, :unhashed_password])
    |> unique_constraint(:email)
    |> hash_pwd()
  end

  defp hash_pwd(changeset) do
    #the way switch statements work: provide some expression thhat returna s value after 'case'. this value is then
    #matched to whatever you want. if nil, do the thing after ->. if anything else (an actuall value) match it in a variable (this case some_pwd) and do stuff with it
    case get_change(changeset, :unhashed_password, nil) do
      nil -> changeset
      some_pwd ->put_change(changeset, :password, Pbkdf2.hash_pwd_salt(some_pwd))
    end
  end
end
