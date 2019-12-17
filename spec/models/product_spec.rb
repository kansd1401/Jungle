require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    let(:category){Category.create(:name => 'Food')}
    subject {
      described_class.new(name: "Spaghetti", description: "It's a italian food mamma mia", image: "https://www.inspiredtaste.net/wp-content/uploads/2019/03/Spaghetti-with-Meat-Sauce-Recipe-1-1200.jpg", price_cents: 350, quantity: 10, category: category)
    }
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a name" do
      subject.name = nil
      subject.save
      expect(subject.errors.full_messages.first).to eq "Name can't be blank"
    end
    it "is not valid without a price" do
      subject.price_cents = nil
      subject.save
      expect(subject.errors.full_messages.first).to eq "Price cents is not a number"
    end
    it "is not valid without a start_date" do
      subject.quantity = nil
      subject.save
      expect(subject.errors.full_messages.first).to eq "Quantity can't be blank"
    end
    it "is not valid without a end_date" do
      subject.category = nil
      subject.save
      expect(subject.errors.full_messages.first).to eq "Category can't be blank"
    end
  end
end
