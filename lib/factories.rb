require 'forgery'
require 'factory_bot'

FactoryBot.define do
  factory :assignment_group do
  end

  factory :course_group do
  end

  factory :account_group do
  end

  factory :sub_account do
  end

  factory :assignment do
    name { "#{Forgery('name').last_name}'s take on #{Forgery('lorem_ipsum').title}" }
    description { Forgery('lorem_ipsum').paragraphs }
    run_id {$runtime.to_i.to_s}
    environment_id {$test_env.id}
  end

  factory :course do
    name { CourseForgery.course_name }
    uid { CourseForgery.course_code }
    sis_id { "#{uid.strip.gsub(/\s+/, "")}_#{rand(10000)}" }
    run_id { $runtime.to_i.to_s }
    environment_id {$test_env.id}
    description {CourseForgery.description}
  end

  factory :user do
    first_name { Forgery('name').first_name}
    last_name { Forgery('name').last_name }
    uid { Forgery('bank_account').iban}
    run_id {$runtime.to_i.to_s}
    environment_id {$test_env.id}
  end

  factory :section do
    name {"#{Forgery('name').title}. #{Forgery('name').company_name}"}
    uid { Forgery('internet').ip_v4 }
  end
end
