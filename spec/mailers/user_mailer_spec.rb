require "spec_helper"

describe UserMailer do
  describe "order_confirmation" do

    let(:user_email) { "user@oregonsale.com" }
    let(:order) { Order.create(confirmation: "AAAAAA", confirmation_hash: UUID.new.generate, card_number: '4242424242424242') }
    let(:mail) { UserMailer.order_confirmation(user_email, order) }

    it "renders the headers" do
      mail.subject.should eq("Order confirmation")
      mail.to.should eq(["user@oregonsale.com"])
      mail.from.should eq(["no-reply@oregonsale.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("AAAAAA")
    end

    it "has that order's unique confirmation code" do 
      expect(mail.body).to include(order.confirmation_hash)
    end

    it "has that order's unique confirmation url" do 
      puts order.inspect
      expect(mail.body.encoded).to match("mrblonde.herokuapp.com/orders/review/#{order.confirmation_hash}")
    end
  end
end
