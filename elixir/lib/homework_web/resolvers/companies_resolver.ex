defmodule HomeworkWeb.Resolvers.CompaniesResolver do
  alias Homework.Companies
  alias Homework.Transactions

  def calculate_available_credit(transactions) do
    fn(company) ->
      total_amount_spent = Enum.reduce(transactions, 0, fn t, acc -> t.amount + acc end)
      company.credit_line - round(total_amount_spent / 100)
    end
  end

  def append_available_credit(company) do
    transactions = Transactions.get_company_transactions(company.id)
    calculate = calculate_available_credit(transactions)
    Map.put(company, :available_credit, calculate.(company))
  end

  @doc """
  Get a list of companies
  """
  def companies(_root, args, _info) do
    companies = Enum.map(Companies.list_companies(args), &append_available_credit/1)
    {:ok, companies}
  end

  @doc """
  Creates a company
  """
  def create_company(_root, args, _info) do
    case Companies.create_company(args) do
      {:ok, company} ->
        {:ok, append_available_credit(company)}

      error ->
        {:error, "could not create company: #{inspect(error)}"}
    end
  end

  @doc """
  Updates a company for an id with args specified.
  """
  def update_company(_root, %{id: id} = args, _info) do
    company = Companies.get_company!(id)

    case Companies.update_company(company, args) do
      {:ok, company} ->
        {:ok, append_available_credit(company)}

      error ->
        {:error, "could not update company: #{inspect(error)}"}
    end
  end

  @doc """
  Deletes a company for an id
  """
  def delete_company(_root, %{id: id}, _info) do
    company = Companies.get_company!(id)

    case Companies.delete_company(company) do
      {:ok, company} ->
        {:ok, company}

      error ->
        {:error, "could not update company: #{inspect(error)}"}
    end
  end
end
