require "spec_helper"

describe UserMailer do

  let(:user_email) { "user@oregonsale.com" }
  let(:order) { Order.create(confirmation: "AAAAAA",
                confirmation_hash: UUID.new.generate,
                card_number: '4242424242424242')
              }
  let(:mail) { UserMailer.order_confirmation(user_email, order) }

  describe "order_confirmation" do

    it "renders the headers" do
      mail.subject.should eq("Order confirmation")
      mail.to.should eq(["user@oregonsale.com"])
      mail.from.should eq(["no-reply@themarketcollective.herokuapp.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("AAAAAA")
    end

    it "has that order's unique confirmation code" do
      expect(mail.body).to include(order.confirmation_hash)
    end

    it "has that order's unique confirmation url" do
      expect(mail.body.encoded).to match("mrblonde.herokuapp.com/orders/review/#{order.confirmation_hash}")
    end
  end

  describe 'account confirmation' do
    let(:account_confirmation) {UserMailer.account_confirmation(user_email)}

    it "renders the headers" do
      account_confirmation.subject.should eq("Account confirmation")
      account_confirmation.to.should eq(["user@oregonsale.com"])
      account_confirmation.from.should eq(["no-reply@themarketcollective.herokuapp.com"])
    end
  end
end
