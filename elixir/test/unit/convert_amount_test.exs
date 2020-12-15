defmodule Homework.ConvertAmount do
  use Homework.DataCase

  alias HomeworkWeb.Resolvers.TransactionsResolver

  describe "convert_amount_to_decimal" do
    test "returns the transaction with the amount converted to dollars" do
      transaction = %{amount: 234323}
      expected_transaction = %{amount: 2343.23}
      assert TransactionsResolver.convert_amount_to_decimal(transaction) == expected_transaction
      assert is_float(expected_transaction.amount)
    end
  end

  describe "convert_amount_to_int" do
    test "returns the transaction with the amount converted to cents" do
      transaction = %{amount: 2343.23}
      expected_transaction = %{amount: 234323}
      assert TransactionsResolver.convert_amount_to_int(transaction) == expected_transaction
      assert is_integer(expected_transaction.amount)
    end
  end
end
