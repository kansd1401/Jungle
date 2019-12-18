require 'rails_helper'


RSpec.feature "Add to cart", type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "My cart number goes up by 1" do
    visit root_path

    # commented out b/c it's for debugging only
    
    page.first(".add").click
    expect(page).to have_css('.cart', text: 'My Cart (1)')
    save_and_open_screenshot("add_to_cart.png")
  end
end
