defmodule Homework.TransactionsResolverTest do
  use Homework.DataCase

  alias Homework.Merchants
  alias Homework.Transactions
  alias Homework.Users
  alias Homework.Companies
  alias HomeworkWeb.Resolvers.TransactionsResolver

  describe "transactions-resolver" do
    setup do
      {:ok, merchant1} =
        Merchants.create_merchant(%{description: "some description", name: "some name"})

      {:ok, merchant2} =
        Merchants.create_merchant(%{
          description: "some updated description",
          name: "some updated name"
        })

      {:ok, user1} =
        Users.create_user(%{
          dob: "some dob",
          first_name: "some first_name",
          last_name: "some last_name"
        })

      {:ok, user2} =
        Users.create_user(%{
          dob: "some updated dob",
          first_name: "some updated first_name",
          last_name: "some updated last_name"
        })

      {:ok, company1} =
        Companies.create_company(%{
          name: "some company",
          credit_line: 1000
        })

      {:ok, company2} =
        Companies.create_company(%{
          name: "some updated company",
          credit_line: 1000
        })

      valid_attrs = %{
        amount: 42.21,
        credit: true,
        debit: true,
        description: "some description",
        merchant_id: merchant1.id,
        user_id: user1.id,
        company_id: company1.id
      }

      update_attrs = %{
        amount: 43.21,
        credit: false,
        debit: false,
        description: "some updated description",
        merchant_id: merchant2.id,
        user_id: user2.id,
        company_id: company2.id
      }

      invalid_attrs = %{
        amount: nil,
        credit: nil,
        debit: nil,
        description: nil,
        merchant_id: nil,
        user_id: nil,
        company_id: nil
      }

      {:ok,
       %{
         valid_attrs: valid_attrs,
         update_attrs: update_attrs,
         invalid_attrs: invalid_attrs,
         merchant1: merchant1,
         merchant2: merchant2,
         user1: user1,
         user2: user2,
         company1: company1,
         company2: company2
       }}
    end

    def transaction_fixture(valid_attrs, attrs \\ %{}) do
      {:ok, transaction} =
        attrs
        |> Enum.into(valid_attrs)
        |> Transactions.create_transaction()

      transaction
    end

    test "transactions/3 returns all transactions", %{valid_attrs: valid_attrs} do
      transaction = transaction_fixture(%{valid_attrs | amount: 4221})
      {:ok, transactions} = TransactionsResolver.transactions(%{}, %{}, %{})
      assert Enum.at(transactions, 0) == %{transaction | amount: 42.21 }
    end

    test "create_transaction/3 creates and returns a transaction", %{valid_attrs: valid_attrs} do
      {:ok, created_transaction} = TransactionsResolver.create_transaction(%{}, valid_attrs, %{})

      assert created_transaction.amount == valid_attrs.amount
      assert created_transaction.credit == valid_attrs.credit
      assert created_transaction.debit == valid_attrs.debit
      assert created_transaction.description == valid_attrs.description
      assert created_transaction.merchant_id == valid_attrs.merchant_id
      assert created_transaction.user_id == valid_attrs.user_id
      assert created_transaction.company_id == valid_attrs.company_id
      assert created_transaction.id != nil
    end

    test "update_transaction/3 updates and returns a transaction", %{valid_attrs: valid_attrs, update_attrs: update_attrs} do
      transaction = transaction_fixture(%{valid_attrs | amount: 4221})

      {:ok, updated_transaction} = TransactionsResolver.update_transaction(%{}, Map.put(update_attrs, :id, transaction.id), %{})

      assert updated_transaction.amount == update_attrs.amount
      assert updated_transaction.credit == update_attrs.credit
      assert updated_transaction.debit == update_attrs.debit
      assert updated_transaction.description == update_attrs.description
      assert updated_transaction.merchant_id == update_attrs.merchant_id
      assert updated_transaction.user_id == update_attrs.user_id
      assert updated_transaction.company_id == update_attrs.company_id
      assert updated_transaction.id != nil
    end

    test "delete_transaction/3 deletes and returns a transaction", %{valid_attrs: valid_attrs} do
      transaction = transaction_fixture(%{valid_attrs | amount: 4221})
      args = %{id: transaction.id}

      {:ok, deleted_transaction} = TransactionsResolver.delete_transaction(%{}, args, %{})

      assert deleted_transaction.id == transaction.id
    end
  end
end
