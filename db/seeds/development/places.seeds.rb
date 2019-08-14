after "development:users" do
  (1..5).each do
    Place.create!(
      title: Faker::Address.community,
      address: Faker::Address.street_address,
    )
  end
end
