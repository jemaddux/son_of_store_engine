require "spec_helper"

describe UserMailer do
  describe "order_confirmation" do

    let(:user_email) { "user@oregonsale.com" }
    let(:order) { Order.create(confirmation: "AAAAAA") }
    let(:mail) { UserMailer.order_confirmation(user_email, order) }

    it "renders the headers" do
      mail.subject.should eq("Order confirmation")
      mail.to.should eq(["user@oregonsale.com"])
      mail.from.should eq(["no-reply@oregonsale.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("AAAAAA")
    end

    it "has a unique confirmation url" do 
      expect(mail.body).to include(order.confirmation_url)
    end
  end
end
