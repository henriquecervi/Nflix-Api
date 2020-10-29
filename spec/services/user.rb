

class ApiUser
    include HTTParty
    base_uri "http://nflix-api-users:3001"
    headers "Content-Type" => "application/json"

    def self.save(user)
        post("/user", body: user.to_json)
    end


end