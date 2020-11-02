describe "delete" do

context "when a registered user" do

    let(:user) { build(:duplicated_email)}
    let(:token) { ApiUser.token(user.email, user.password)}
    let(:result) { ApiUser.remove(token, user.id)}    

    it { expect(result.response.code).to eql "204"}
end

context "when id doesnt exist" do

    let(:user) { build(:duplicated_email)}
    let(:token) { ApiUser.token(user.email, user.password)}
    let(:result) { ApiUser.remove(token, "0")}    

    it { expect(result.response.code).to eql "404"}
end

context "when wrong id" do

    let(:user) { build(:duplicated_email)}
    let(:token) { ApiUser.token(user.email, user.password)}
    let(:result) { ApiUser.remove(token, "abc")}    

    it { expect(result.response.code).to eql "412"}
end


end
