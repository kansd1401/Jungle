require 'rails_helper'

RSpec.feature "Product Details", type: :feature, js: true do
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

  scenario "They can see the product page" do
    visit root_path

    # commented out b/c it's for debugging only
    
    page.first(".product-name").click
    find(".product-detail")
    # save_and_open_screenshot("product-detail.png")
  end
end