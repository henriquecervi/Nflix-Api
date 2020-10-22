
describe "cadastro" do
    
    it "novo usuario" do
        result = HTTParty.post(
            "http://nflix-api-users:3001/user", 
            body: {full_name: "Henrique Cervi", email: "cervi@henrique.com", password: "123456"}.to_json,
            headers: {
                "Content-Type" => "application/json"
            },
        )
        expect(result.response.code).to eql "200"
    end

end