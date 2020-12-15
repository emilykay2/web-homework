defmodule Homework.CalculateAvailableCredit do
  use Homework.DataCase

  alias HomeworkWeb.Resolvers.CompaniesResolver

  describe "calculate_available_credit" do
    test "calculate_available_credit returns credit_line when there are no transactions" do
      company = %{
        name: "my company",
        credit_line: 1000,
        updated_at: "some time",
        inserted_at: "some time"
      }

      calculate = CompaniesResolver.calculate_available_credit([])
      assert calculate.(company) == 1000
    end

    test "calculate_available_credit returns credit_line minus all transactions" do
      company = %{
        name: "my company",
        credit_line: 1000,
        updated_at: "some time",
        inserted_at: "some time"
      }
      transactions = [%{amount: 200}, %{amount: 300}, %{amount: 100}]

      calculate = CompaniesResolver.calculate_available_credit(transactions)
      assert calculate.(company) == 400
    end
  end
end
