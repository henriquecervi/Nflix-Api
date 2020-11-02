

class ApiUser
    include HTTParty
    base_uri "http://nflix-api-users:3001"
    headers "Content-Type" => "application/json"

    def self.token(user_email, user_password)
        result = post("/auth", body: {email: user_email, password: user_password}.to_json)
       "JWT #{result.parsed_response["token"]}"
    end

    def self.save(user)
        post("/user", body: user.to_json)
    end

    def self.update(token, user_id, user)
        put("/user/#{user_id}", body: user.to_json, headers: {"Authorization" => token})
    end

    def self.find(token, user_id)
        #get("/user" + user_id.to_s) ou utilizando interpolação
        get("/user/#{user_id}", headers: { "Authorization" => token })
    end

    def self.remove(token, user_id)
        delete("/user/#{user_id}", headers: { "Authorization" => token })
    end
end