describe "get" do
    
    context "when a registered user" do

        let(:user) { build(:duplicated_email)}
        let(:token) { ApiUser.token(user.email, user.password)}
        let(:result) { ApiUser.find(token, user.id)}
        let(:user_data) { Database.new.find_user(user.email)}

        it { expect(result.response.code).to eql "200"}
        it { expect(result.parsed_response["full_name"]).to eql user_data["full_name"]}
        it { expect(result.parsed_response["password"]).to eql user_data["password"]}
        it { expect(result.parsed_response["email"]).to eql user_data["email"]}


        it { expect(Time.parse(result.parsed_response["createdAt"])).to eql Time.parse(user_data["created_at"])}
        it { expect(Time.parse(result.parsed_response["updatedAt"])).to eql Time.parse(user_data["updated_at"])}
    end

    context "when id not found" do
        let(:user) { build(:duplicated_email)}
        let(:token) { ApiUser.token(user.email, user.password)}
        let(:result) { ApiUser.find(token, "0")}

        it { expect(result.response.code).to eql "404"}
    end

    context "when other id" do
        let(:user) { build(:duplicated_email)}
        let(:other_user) { build(:duplicated_email)}
        let(:token) { ApiUser.token(user.email, user.password)}
        let(:result) { ApiUser.find(token, other_user.id)}

        it { expect(result.response.code).to eql "401"}
    end

end
