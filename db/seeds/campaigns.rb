#encoding: utf-8
20.times do
  Campaign.create({
    active: [true, false].sample,
    title: "title #{rand(20)}",
    content: "Teste teste teste #{rand(20)}",
    quantity: rand(100),
    expired_at: Time.now - rand(9).hours,
  })
end