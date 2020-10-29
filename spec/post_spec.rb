
describe "post" do
    context "when new user" do
        # before do
        #     new_user = build(:user).to_hash            
        #     result = ApiUser.save(new_user)
        # end

        let(:result) {ApiUser.save(build(:user).to_hash)}

        it { expect(result.response.code).to eql "200"}
    end

    context "when duplicated email" do
        let(:result) {ApiUser.save(build(:duplicated_email).to_hash)}

        it { expect(result.response.code).to eql "409"}
        it { expect(result.parsed_response["msg"]).to eql "Oops. Looks like you already have an account with this email address."}
    end

    context "when wrong email" do
        let(:result) {ApiUser.save(build(:user_wrong_email).to_hash)}

        it { expect(result.response.code).to eql "412" }
        it { expect(result.parsed_response["msg"]).to eql "Oops. You entered a wrong email."}
    end

    context "when name not empty" do
        let(:result) {ApiUser.save(build(:name_not_empty).to_hash)}

        it { expect(result.response.code).to eql "412" }
        it { expect(result.parsed_response["msg"]).to eql "Validation notEmpty on full_name failed"}
    end

    context "when email not empty" do
        let(:result) {ApiUser.save(build(:email_not_empty).to_hash)}

        it { expect(result.response.code).to eql "412" }
        it { expect(result.parsed_response["msg"]).to eql "Validation notEmpty on email failed"}
    end

    context "when password not empty" do
        let(:result) {ApiUser.save(build(:password_not_empty).to_hash)}

        it { expect(result.response.code).to eql "412" }
        it { expect(result.parsed_response["msg"]).to eql "Validation notEmpty on password failed"}
    end

    context "when name empty" do
        let(:result) {ApiUser.save(build(:name_empty).to_hash)}

        it { expect(result.response.code).to eql "412" }
        it { expect(result.parsed_response["msg"]).to eql "Users.full_name cannot be null"}
    end

    context "when email empty" do   
        let(:result) {ApiUser.save(build(:email_empty).to_hash)}

        it { expect(result.response.code).to eql "412" }
        it { expect(result.parsed_response["msg"]).to eql "Users.email cannot be null"}
    end

    context "when password empty" do
                let(:result) {ApiUser.save(build(:password_empty).to_hash)}

        it { expect(result.response.code).to eql "412" }
        it { expect(result.parsed_response["msg"]).to eql "Users.password cannot be null"}
    end
end