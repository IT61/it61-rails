after "development:places" do
  (1..5).each do
    # Unpublished events
    Event.create!(
      title: Faker::Esport.event,
      description: Faker::Markdown.sandwich(sentences: 6, repeat: 3),
      organizer: User.order("RANDOM()").first,
      started_at: Faker::Time.forward(days: 30),
      published: false,
    )

    # Upcoming events
    Event.create!(
      title: Faker::Esport.event,
      description: Faker::Markdown.sandwich(sentences: 6, repeat: 3),
      organizer: User.order("RANDOM()").first,
      started_at: Faker::Time.forward(days: 30),
      published: true,
      published_at: Date.current,
    )

    # Past events
    Event.create!(
      title: Faker::Esport.event,
      description: Faker::Markdown.sandwich(sentences: 6, repeat: 3),
      organizer: User.order("RANDOM()").first,
      started_at: Faker::Time.backward(days: 30),
      published: true,
      published_at: Faker::Time.backward(days: 10),
    )
  end
end
