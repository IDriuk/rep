defmodule Rep.Lifts do
  @moduledoc """
  The Lifts context.
  """

  import Ecto.Query, warn: false
  alias Rep.Repo

  alias Rep.Lifts.{Address, Mechanic}
  alias Rep.Accounts

  @doc """
  Returns the list of addresses.

  ## Examples

      iex> list_addresses()
      [%Address{}, ...]

  """
  def list_addresses (%Mechanic{} = mechanic) do
    query = from a in Address,
            where: a.mechanic_id == ^mechanic.id,
            order_by: [a.street, a.house, a.entrance]
    Repo.all(query)
  end

  @doc """
  Gets a single address.

  Raises `Ecto.NoResultsError` if the Address does not exist.

  ## Examples

      iex> get_address!(123)
      %Address{}

      iex> get_address!(456)
      ** (Ecto.NoResultsError)

  """
  def get_address!(id), do: Repo.get!(Address, id)

  @doc """
  Creates a address.

  ## Examples

      iex> create_address(%{field: value})
      {:ok, %Address{}}

      iex> create_address(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_address(%Mechanic{} = mechanic, attrs \\ %{}) do
    %Address{}
    |> Address.changeset(attrs)
    |> Ecto.Changeset.put_change(:mechanic_id, mechanic.id)
    |> Repo.insert()
  end

  @doc """
  Updates a address.

  ## Examples

      iex> update_address(address, %{field: new_value})
      {:ok, %Address{}}

      iex> update_address(address, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_address(%Address{} = address, attrs) do
    address
    |> Address.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Address.

  ## Examples

      iex> delete_address(address)
      {:ok, %Address{}}

      iex> delete_address(address)
      {:error, %Ecto.Changeset{}}

  """
  def delete_address(%Address{} = address) do
    Repo.delete(address)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking address changes.

  ## Examples

      iex> change_address(address)
      %Ecto.Changeset{source: %Address{}}

  """
  def change_address(%Address{} = address) do
    Address.changeset(address, %{})
  end

  alias Rep.Lifts.Complectation

  @doc """
  Returns the list of complectations.

  ## Examples

      iex> list_complectations()
      [%Complectation{}, ...]

  """
  def list_complectations address do
    query = from b in Complectation, where: b.address_id == ^address.id
    Repo.all(query)
  end

  @doc """
  Gets a single complectation.

  Raises `Ecto.NoResultsError` if the Complectation does not exist.

  ## Examples

      iex> get_complectation!(123)
      %Complectation{}

      iex> get_complectation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_complectation!(id), do: Repo.get!(Complectation, id)

  @doc """
  Creates a complectation.

  ## Examples

      iex> create_complectation(%{field: value})
      {:ok, %Complectation{}}

      iex> create_complectation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_complectation(%Address{} = address, attrs \\ %{}) do
    %Complectation{}
    |> Complectation.changeset(attrs)
    |> Ecto.Changeset.put_change(:address_id, address.id)
    |> Ecto.Changeset.unique_constraint(:address_id)
    |> Repo.insert()
  end

  @doc """
  Updates a complectation.

  ## Examples

      iex> update_complectation(complectation, %{field: new_value})
      {:ok, %Complectation{}}

      iex> update_complectation(complectation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_complectation(%Complectation{} = complectation, attrs) do
    complectation
    |> Complectation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Complectation.

  ## Examples

      iex> delete_complectation(complectation)
      {:ok, %Complectation{}}

      iex> delete_complectation(complectation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_complectation(%Complectation{} = complectation) do
    Repo.delete(complectation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking complectation changes.

  ## Examples

      iex> change_complectation(complectation)
      %Ecto.Changeset{source: %Complectation{}}

  """
  def change_complectation(%Complectation{} = complectation) do
    Complectation.changeset(complectation, %{})
  end

  alias Rep.Lifts.Break

  @doc """
  Returns the list of breaks.

  ## Examples

      iex> list_breaks()
      [%Break{}, ...]

  """
  def list_breaks address do
    query = from b in Break, where: b.address_id == ^address.id
    Repo.all(query)
  end

  @doc """
  Gets a single break.

  Raises `Ecto.NoResultsError` if the Break does not exist.

  ## Examples

      iex> get_break!(123)
      %Break{}

      iex> get_break!(456)
      ** (Ecto.NoResultsError)

  """
  def get_break!(id), do: Repo.get!(Break, id)

  @doc """
  Creates a break.

  ## Examples

      iex> create_break(%{field: value})
      {:ok, %Break{}}

      iex> create_break(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_break(%Address{} = address, attrs \\ %{}) do
    %Break{}
    |> Break.changeset(attrs)
    |> Ecto.Changeset.put_change(:address_id, address.id)
    |> Repo.insert()
  end

  @doc """
  Updates a break.

  ## Examples

      iex> update_break(break, %{field: new_value})
      {:ok, %Break{}}

      iex> update_break(break, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_break(%Break{} = break, attrs) do
    break
    |> Break.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Break.

  ## Examples

      iex> delete_break(break)
      {:ok, %Break{}}

      iex> delete_break(break)
      {:error, %Ecto.Changeset{}}

  """
  def delete_break(%Break{} = break) do
    Repo.delete(break)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking break changes.

  ## Examples

      iex> change_break(break)
      %Ecto.Changeset{source: %Break{}}

  """
  def change_break(%Break{} = break) do
    Break.changeset(break, %{})
  end

  alias Rep.Lifts.Mechanic

  @doc """
  Returns the list of mechanics.

  ## Examples

      iex> list_mechanics()
      [%Mechanic{}, ...]

  """
  def list_mechanics do
    Repo.all(Mechanic)
  end

  @doc """
  Gets a single mechanic.

  Raises `Ecto.NoResultsError` if the Mechanic does not exist.

  ## Examples

      iex> get_mechanic!(123)
      %Mechanic{}

      iex> get_mechanic!(456)
      ** (Ecto.NoResultsError)

  """
  def get_mechanic!(id), do: Repo.get!(Mechanic, id)

  @doc """
  Creates a mechanic.

  ## Examples

      iex> create_mechanic(%{field: value})
      {:ok, %Mechanic{}}

      iex> create_mechanic(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_mechanic(attrs \\ %{}) do
    %Mechanic{}
    |> Mechanic.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a mechanic.

  ## Examples

      iex> update_mechanic(mechanic, %{field: new_value})
      {:ok, %Mechanic{}}

      iex> update_mechanic(mechanic, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_mechanic(%Mechanic{} = mechanic, attrs) do
    mechanic
    |> Mechanic.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Mechanic.

  ## Examples

      iex> delete_mechanic(mechanic)
      {:ok, %Mechanic{}}

      iex> delete_mechanic(mechanic)
      {:error, %Ecto.Changeset{}}

  """
  def delete_mechanic(%Mechanic{} = mechanic) do
    Repo.delete(mechanic)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking mechanic changes.

  ## Examples

      iex> change_mechanic(mechanic)
      %Ecto.Changeset{source: %Mechanic{}}

  """
  def change_mechanic(%Mechanic{} = mechanic) do
    Mechanic.changeset(mechanic, %{})
  end

  def ensure_mechanic_exists(%Accounts.User{} = user) do
    %Mechanic{user_id: user.id}
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.unique_constraint(:user_id)
    |> Repo.insert()
    |> handle_existing_mechanic()
  end

  defp handle_existing_mechanic({:ok, mechanic}), do: mechanic
  defp handle_existing_mechanic({:error, changeset}) do
    Repo.get_by!(Mechanic, user_id: changeset.data.user_id)
  end
end
