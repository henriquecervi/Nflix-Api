require "faker"
require_relative "models/user_model"


FactoryBot.define do
    
    factory :user, class: UserModel do
        full_name { "Henrique Cervi" }
        email { "henrique@henrique.br" }
        password { "123456" }

        after(:build) do |user|
            Database.new.delete_user(user.email)
        end
    end

    factory :duplicated_email, class: UserModel do
        id { 0 }
        full_name { Faker::Movies::StarWars.character }
        email { Faker::Internet.free_email(name: full_name) }
        password { "123456" }

        after(:build) do |user|
            Database.new.delete_user(user.email)
            result = ApiUser.save(user.to_hash)
            user.id = result.parsed_response["id"]
        end
    end
    
    factory :user_wrong_email, class: UserModel do
        full_name { "Henrique Cervi" }
        email { "henrique#henrique.br" }
        password { "123456" }
    end

    factory :name_not_empty, class: UserModel do
        full_name { "" }
        email { "henrique@henrique.br" }
        password { "123456" }
    end

    factory :email_not_empty, class: UserModel do
        full_name { "Henrique Cervi" }
        email { "" }
        password { "123456" }
    end

    factory :password_not_empty, class: UserModel do
        full_name { "Henrique Cervi" }
        email { "henrique@henrique.br" }
        password { "" }
    end

    factory :name_empty, class: UserModel do
        full_name {  }
        email { "henrique@henrique.br" }
        password { "123456" }
    end

    factory :email_empty, class: UserModel do
        full_name { "Henrique Cervi" }
        email {  }
        password { "123456" }
    end

    factory :password_empty, class: UserModel do
        full_name { "Henrique Cervi" }
        email { "henrique@henrique.br" }
        password {  }
    end
end