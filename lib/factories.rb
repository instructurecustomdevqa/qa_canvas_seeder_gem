require 'forgery'
require 'factory_bot'

FactoryBot.define do
  factory :assignment_group do
  end

  factory :group_in_course do
  end

  factory :group_in_account do
  end

  factory :account do
  end

  factory :assignment do
    name { "#{Forgery('name').last_name}'s take on #{Forgery('lorem_ipsum').title}" }
    description { Forgery('lorem_ipsum').paragraphs }
  end

  factory :course do
    name { CourseForgery.course_name }
    uid { CourseForgery.course_code }
    sis_id { "#{uid.strip.gsub(/\s+/, "")}_#{rand(10000)}" }
    description {CourseForgery.description}
  end

  factory :user do
    first_name { Forgery('name').first_name}
    last_name { Forgery('name').last_name }
    uid { Forgery('bank_account').iban}
  end

  factory :section do
    name {"#{Forgery('name').title}. #{Forgery('name').company_name}"}
    uid { Forgery('internet').ip_v4 }
  end
end
