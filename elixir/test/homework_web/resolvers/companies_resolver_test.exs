defmodule Homework.CompaniesResolverTest do
  use Homework.DataCase

  alias Homework.Companies
  alias Homework.Transactions
  alias Homework.Merchants
  alias Homework.Users
  alias HomeworkWeb.Resolvers.CompaniesResolver

  describe "companies-resolver" do
    @valid_attrs %{name: "some company", credit_line: 100000}

    def generate_transaction_payload(company_id, merchant_id, user_id) do
      %{
        amount: 10000,
        credit: true,
        debit: true,
        description: "new transaction",
        merchant_id: merchant_id,
        user_id: user_id,
        company_id: company_id
      }
    end

    def create_test_transaction(company_id) do
      {:ok, merchant} = Merchants.create_merchant(%{name: "does not matter", description: "does not matter"})
      {:ok, user} = Users.create_user(%{dob: "does not matter", first_name: "does not matter", last_name: "does not matter"})
      transaction_payload = generate_transaction_payload(company_id, merchant.id, user.id)
      {:ok, transaction} = Transactions.create_transaction(transaction_payload)

      transaction
    end

    def company_fixture(attrs \\ %{}) do
      {:ok, company} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Companies.create_company()

      company
    end

    test "companies/3 returns all companies" do
      company = company_fixture()
      expected_company = Map.put(company, :available_credit, company.credit_line)

      {:ok, companies} = CompaniesResolver.companies(%{}, %{}, %{})
      assert Enum.at(companies, 0) == expected_company
    end

    test "create_company/3 creates and returns a company" do
      name = "new company"
      credit_line = 100
      args = %{name: name, credit_line: credit_line}

      mutation_response = CompaniesResolver.create_company(%{}, args, %{})
      {:ok, created_company} = mutation_response

      assert created_company.name == name
      assert created_company.credit_line == credit_line
      assert created_company.available_credit == credit_line
      assert created_company.id != nil
    end

    test "update_company/3 updates and returns a company" do
      company = company_fixture()
      name = "updated company"
      credit_line = 200
      args = %{name: name, credit_line: credit_line, id: company.id}

      {:ok, updated_company} = CompaniesResolver.update_company(%{}, args, %{})

      assert updated_company.name == name
      assert updated_company.credit_line == credit_line
      assert updated_company.available_credit == credit_line
      assert updated_company.id != nil
    end

    test "delete_company/3 deletes and returns a company" do
      company = company_fixture()
      args = %{id: company.id}

      {:ok, deleted_company} = CompaniesResolver.delete_company(%{}, args, %{})

      assert deleted_company.id == company.id
    end

    test "companies/3 correctly calculates available_credit" do
      company = company_fixture()
      {:ok, company2} = Companies.create_company(%{name: "other company", credit_line: 1})
      expected_company_initial = Map.put(company, :available_credit, company.credit_line)

      {:ok, companies} = CompaniesResolver.companies(%{}, %{}, %{})
      assert Enum.at(companies, 0) == expected_company_initial

      create_test_transaction(company.id)
      create_test_transaction(company.id)
      create_test_transaction(company.id)
      create_test_transaction(company2.id)

      expected_company_final = Map.put(company, :available_credit, 99700)
      {:ok, companies} = CompaniesResolver.companies(%{}, %{}, %{})
      assert Enum.at(companies, 0) == expected_company_final
    end
  end
end
