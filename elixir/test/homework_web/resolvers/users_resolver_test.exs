defmodule Homework.UsersResolverTest do
  use Homework.DataCase

  alias Homework.Users
  alias HomeworkWeb.Resolvers.UsersResolver

  describe "users-resolver" do
    @valid_attrs %{dob: "some dob", first_name: "some first_name", last_name: "some last_name"}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_user()

      user
    end

    test "users/3 returns all users" do
      user = user_fixture()
      {:ok, users} = UsersResolver.users(%{}, %{}, %{})
      assert Enum.at(users, 0) == user
    end

    test "create_user/3 creates and returns a user" do
      dob = "01-01-2000"
      first_name = "first"
      last_name = "last"
      args = %{dob: dob, first_name: first_name, last_name: last_name}

      {:ok, created_user} = UsersResolver.create_user(%{}, args, %{})

      assert created_user.dob == dob
      assert created_user.first_name == first_name
      assert created_user.last_name == last_name
      assert created_user.id != nil
    end

    test "update_user/3 updates and returns a user" do
      user = user_fixture()
      dob = "01-01-1900"
      first_name = "updated_first"
      last_name = "updated_last"
      args = %{dob: dob, first_name: first_name, last_name: last_name, id: user.id}

      {:ok, updated_user} = UsersResolver.update_user(%{}, args, %{})

      assert updated_user.dob == dob
      assert updated_user.first_name == first_name
      assert updated_user.last_name == last_name
      assert updated_user.id == user.id
    end

    test "delete_user/3 deletes and returns a user" do
      user = user_fixture()
      args = %{id: user.id}

      {:ok, deleted_user} = UsersResolver.delete_user(%{}, args, %{})

      assert deleted_user.id == user.id
    end
  end
end
