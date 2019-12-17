require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    subject {
      described_class.new(name: "Spaghetti",last_name: "Man", email: "123@mammamia.com",password: "12345", password_confirmation: "12345" )
    }
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "gives error when password and password confirmation don't match" do
      subject.password = "22222"
      subject.save
      expect(subject.errors.full_messages.first).to eq "Password confirmation doesn't match Password"
    end
    it "gives error when password and confirmation are empty" do
      subject.password = nil
      subject.password_confirmation = nil
      subject.save
      expect(subject.errors.full_messages.first).to eq "Password can't be blank"
    end
    it "is not valid without a first name" do
      subject.name = nil
      subject.save
      expect(subject.errors.full_messages.first).to eq "Name can't be blank"
    end
    it "is not valid without a last name" do
      subject.last_name = nil
      subject.save
      expect(subject.errors.full_messages.first).to eq "Last name can't be blank"
    end
    it "is not valid without a email" do
      subject.email = nil
      subject.save
      expect(subject.errors.full_messages.first).to eq "Email can't be blank"
    end
    it "is not valid if a user with the email already exists" do
      user = User.create(name: "ooof",last_name: "boi", email: "123@mammamia.com",password: "12345", password_confirmation: "12345" )
      new_user = User.create(name: "pepe",last_name: "boi", email: "123@mammamia.com",password: "12345", password_confirmation: "12345" )
      new_user.save
      expect(new_user.errors.full_messages.first).to eq "Email has already been taken"
    end
    it "password must be atleast 5 charachters" do
      subject.password = "123"
      subject.password_confirmation = "123"
      subject.save
      expect(subject.errors.full_messages.first).to eq "Password is too short (minimum is 5 characters)"
    end
  end

  describe '.authenticate_with_credentials' do
    it "should return false when email and password don't match" do
      @user = described_class.create(name: "Spaghetti",last_name: "Man", email: "123@mammamia.com",password: "12345", password_confirmation: "12345" )
      email = @user.email
      password = "1231234"
      expect(User.authenticate_with_credentials(email,password)).to be_nil
    end
    it "should return user when email and password correct" do
      @user = described_class.create(name: "Spaghetti",last_name: "Man", email: "123@mammamia.com",password: "12345", password_confirmation: "12345" )
      email = @user.email
      password = @user.password
      result = User.authenticate_with_credentials(email,password)
      expect(result.id).to eq @user.id
    end
  end

end
