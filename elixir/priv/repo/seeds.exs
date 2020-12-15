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


user1 = Homework.Repo.insert!(%Homework.Users.User{dob: "09-08-1995", first_name: "first1", last_name: "last1"})
user2 = Homework.Repo.insert!(%Homework.Users.User{dob: "09-08-1995", first_name: "first2", last_name: "last2"})
user3 = Homework.Repo.insert!(%Homework.Users.User{dob: "09-08-1995", first_name: "first3", last_name: "last3"})

merchant1 = Homework.Repo.insert!(%Homework.Merchants.Merchant{name: "merchant1", description: "merchant 1"})
merchant2 = Homework.Repo.insert!(%Homework.Merchants.Merchant{name: "merchant2", description: "merchant 2"})
merchant3 = Homework.Repo.insert!(%Homework.Merchants.Merchant{name: "merchant3", description: "merchant 3"})

company1 = Homework.Repo.insert!(%Homework.Companies.Company{name: "company1", credit_line: 100})
company2 = Homework.Repo.insert!(%Homework.Companies.Company{name: "company2", credit_line: 200})
company3 = Homework.Repo.insert!(%Homework.Companies.Company{name: "company3", credit_line: 300})

Homework.Repo.insert!(%Homework.Transactions.Transaction{amount: 10000, credit: true, debit: true, description: "transaction1", merchant_id: merchant1.id, user_id: user1.id, company_id: company1.id})
Homework.Repo.insert!(%Homework.Transactions.Transaction{amount: 20000, credit: true, debit: true, description: "transaction2", merchant_id: merchant2.id, user_id: user2.id, company_id: company2.id})
Homework.Repo.insert!(%Homework.Transactions.Transaction{amount: 30000, credit: true, debit: true, description: "transaction3", merchant_id: merchant3.id, user_id: user3.id, company_id: company3.id})
