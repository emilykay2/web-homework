# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Homework.Repo.insert!(%Homework.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


Homework.Repo.insert!(%Homework.Users.User{dob: "09-08-1995", first_name: "Harry", last_name: "Potter", id: "e1cbd1a2-7671-48ac-9b6b-90c9500e9aef"})
Homework.Repo.insert!(%Homework.Users.User{dob: "09-08-1995", first_name: "Hermione", last_name: "Granger", id: "dff8a6ff-6327-4bbd-b762-e347922a7e26"})
Homework.Repo.insert!(%Homework.Users.User{dob: "09-08-1995", first_name: "Ron", last_name: "Weasley", id: "b0c88b5c-e9a4-4cf6-83b9-0af9a490372b"})

Homework.Repo.insert!(%Homework.Merchants.Merchant{name: "merchant1", description: "merchant 1", id: "69c48d37-4a3d-4132-b9a8-0d8a0f9bbd4b"})
Homework.Repo.insert!(%Homework.Merchants.Merchant{name: "merchant2", description: "merchant 2", id: "b5329d35-0f37-4b43-b315-d2c367524e9e"})
Homework.Repo.insert!(%Homework.Merchants.Merchant{name: "merchant3", description: "merchant 3", id: "26719e88-82a2-4132-9690-680ebe33dc0b"})

Homework.Repo.insert!(%Homework.Companies.Company{name: "company1", credit_line: 100, id: "35c8c934-443c-4e71-85ce-5d4f32d5d531"})
Homework.Repo.insert!(%Homework.Companies.Company{name: "company2", credit_line: 200, id: "cf19dcf3-722d-4c25-b55d-ef3977aae21c"})
Homework.Repo.insert!(%Homework.Companies.Company{name: "company3", credit_line: 300, id: "eb313fc1-c8ac-42ed-8528-257707c8a318"})

Homework.Repo.insert!(%Homework.Transactions.Transaction{amount: 5, credit: true, debit: true, description: "transaction1", merchant_id: "69c48d37-4a3d-4132-b9a8-0d8a0f9bbd4b", user_id: "e1cbd1a2-7671-48ac-9b6b-90c9500e9aef", company_id: "35c8c934-443c-4e71-85ce-5d4f32d5d531"})
