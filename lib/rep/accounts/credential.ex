defmodule Rep.Accounts.Credential do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rep.Accounts.{Credential, User}

  schema "credentials" do
    field :email, :string
    field :password, :string
    field :password_hash, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(%Credential{} = credential, attrs) do
    credential
    |> cast(attrs, [:email, :password, :password_hash])
    |> validate_required([:email, :password])
    |> unique_constraint(:email)
    |> put_pass_hash
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Comeonin.Pbkdf2.add_hash(password))
  end
  defp put_pass_hash(changeset), do: changeset

end
