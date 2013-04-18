require "spec_helper"

describe UserMailer do

  let(:user_email) { "user@oregonsale.com" }
  let(:order) { Order.create(confirmation: "AAAAAA",
                confirmation_hash: UUID.new.generate,
                card_number: '4242424242424242')
              }
  let(:mail) { UserMailer.order_confirmation(user_email, order.confirmation, order.confirmation_hash) }

  describe "an admin notifies a user" do 

    let(:admin){FactoryGirl.create(:admin)}
    let(:store){admin.store}

    context "the users site is live" do 

      let(:site_live){UserMailer.site_live(store.path, store.id)}

      it "sends the store admin an email" do 
        site_live.to.should eq [admin.email]
      end
    end

    context "the users site is declined" do 

      let(:site_declined){UserMailer.site_declined(store.path, store.id)}

      it "sends the user an email" do 
        site_declined.to.should eq [admin.email]
      end
    end
  end

  describe "an admin creates a new admin" do 

    let(:store){FactoryGirl.create(:store)}
    let(:new_admin){UserMailer.new_admin("test@test.email", store.name, "password")}

    it "sends that new admin an email" do 
      new_admin.to.should eq ["test@test.email"]
    end
  end

  describe "an admin makes an existing user an admin" do 

    let(:store){FactoryGirl.create(:store)}
    let(:user){FactoryGirl.create(:user)}
    let(:add_admin){UserMailer.add_admin(user.email, store.name)}

    it "sends that new admin an email" do 
      add_admin.to.should eq [user.email]
    end
  end


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
