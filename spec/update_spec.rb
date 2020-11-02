
describe "put" do
    context "when a registered user" do
        before(:all) do
            original_user = build(:duplicated_email)
            token = ApiUser.token(original_user.email, original_user.password)
            @new_user = build(:user)
            @result_put = ApiUser.update(token, original_user.id, @new_user.to_hash)
            # o result deve ser uma variável de instacia, pois estamos utilizando o before.
            @result_get = ApiUser.find(token, original_user.id)
        end

        it { expect(@result_put.response.code).to eql "200"}
        it { expect(@result_get.parsed_response["full_name"]).to eql @new_user.full_name}
        it { expect(@result_get.parsed_response["email"]).to eql @new_user.email}
    end
end