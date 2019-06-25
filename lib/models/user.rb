class User
  @first_name = ""
  @last_name = ""
  @login = ""
  @sis_id = ""
end

FactoryBot.define do
  factory :user do
    first_name { Forgery('name').first_name}
    last_name { Forgery('name').last_name }
    uid { Forgery('bank_account').iban}
  end
end
