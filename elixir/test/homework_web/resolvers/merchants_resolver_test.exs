defmodule Homework.MerchantsResolverTest do
  use Homework.DataCase

  alias Homework.Merchants
  alias HomeworkWeb.Resolvers.MerchantsResolver

  describe "merchants-resolver" do
    @valid_attrs %{description: "some description", name: "some name"}

    def merchant_fixture(attrs \\ %{}) do
      {:ok, merchant} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Merchants.create_merchant()

      merchant
    end

    test "merchants/3 returns all merchants" do
      merchant = merchant_fixture()
      {:ok, merchants} = MerchantsResolver.merchants(%{}, %{}, %{})
      assert Enum.at(merchants, 0) == merchant
    end

    test "create_merchant/3 creates and returns a merchant" do
      description = "new description"
      name = "new name"
      args = %{description: description, name: name}

      {:ok, created_merchant} = MerchantsResolver.create_merchant(%{}, args, %{})

      assert created_merchant.description == description
      assert created_merchant.name == name
      assert created_merchant.id != nil
    end

    test "update_merchant/3 updates and returns a merchant" do
      merchant = merchant_fixture()
      description = "updated description"
      name = "updated name"
      args = %{description: description, name: name, id: merchant.id}

      {:ok, updated_merchant} = MerchantsResolver.update_merchant(%{}, args, %{})

      assert updated_merchant.description == description
      assert updated_merchant.name == name
      assert updated_merchant.id == merchant.id
    end

    test "delete_merchant/3 deletes and returns a merchant" do
      merchant = merchant_fixture()
      args = %{id: merchant.id}

      {:ok, deleted_merchant} = MerchantsResolver.delete_merchant(%{}, args, %{})

      assert deleted_merchant.id == merchant.id
    end
  end
end
