defmodule HomeworkWeb.Resolvers.TransactionsResolver do
  alias Homework.Merchants
  alias Homework.Transactions
  alias Homework.Users
  alias Homework.Companies

  def convert_to_int(val) do
    round(val * 100)
  end

  def convert_amount_to_int(transaction) do
    %{transaction | amount: convert_to_int(transaction.amount)}
  end

  def convert_amount_to_decimal(transaction) do
    %{transaction | amount: transaction.amount / 100}
  end

  @doc """
  Get a list of transcations
  """
  def transactions(_root, args, _info) do
    converted_args = cond do
      Map.has_key?(args, :min) and Map.has_key?(args, :max) -> %{min: convert_to_int(args.min), max: convert_to_int(args.max)}
      Map.has_key?(args, :min) -> %{min: convert_to_int(args.min)}
      Map.has_key?(args, :max) -> %{max: convert_to_int(args.max)}
      true -> %{}
    end
    transactions = Transactions.list_transactions(converted_args)
    {:ok, Enum.map(transactions, &convert_amount_to_decimal/1)}
  end

  @doc """
  Get the user associated with a transaction
  """
  def user(_root, _args, %{source: %{user_id: user_id}}) do
    {:ok, Users.get_user!(user_id)}
  end

  @doc """
  Get the merchant associated with a transaction
  """
  def merchant(_root, _args, %{source: %{merchant_id: merchant_id}}) do
    {:ok, Merchants.get_merchant!(merchant_id)}
  end

  @doc """
  Get the company associated with a transaction
  """
  def company(_root, _args, %{source: %{company_id: company_id}}) do
    {:ok, Companies.get_company!(company_id)}
  end

  @doc """
  Create a new transaction
  """
  def create_transaction(_root, args, _info) do
    case Transactions.create_transaction(convert_amount_to_int(args)) do
      {:ok, transaction} ->
        {:ok, convert_amount_to_decimal(transaction)}

      error ->
        {:error, "could not create transaction: #{inspect(error)}"}
    end
  end

  @doc """
  Updates a transaction for an id with args specified.
  """
  def update_transaction(_root, %{id: id} = args, _info) do
    transaction = Transactions.get_transaction!(id)

    case Transactions.update_transaction(transaction, convert_amount_to_int(args)) do
      {:ok, transaction} ->
        {:ok, convert_amount_to_decimal(transaction)}

      error ->
        {:error, "could not update transaction: #{inspect(error)}"}
    end
  end

  @doc """
  Deletes a transaction for an id
  """
  def delete_transaction(_root, %{id: id}, _info) do
    transaction = Transactions.get_transaction!(id)

    case Transactions.delete_transaction(transaction) do
      {:ok, transaction} ->
        {:ok, transaction}

      error ->
        {:error, "could not update transaction: #{inspect(error)}"}
    end
  end
end
