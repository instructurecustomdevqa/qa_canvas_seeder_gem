class Section
  @name = ""
  @sis_id = ""
end

FactoryBot.define do
  factory :section do
    name {"#{Forgery('name').title}. #{Forgery('name').company_name}"}
    uid { Forgery('internet').ip_v4 }
  end
end
