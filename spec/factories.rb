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

end