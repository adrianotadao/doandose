#encoding: utf-8

20.times do
  Campaign.create({
    active: [true, false].sample,
    title: "campanha de doacao",
    content: "Teste teste teste",
    quantity: rand(99),
    company: Company.all.to_a.sample,
    blood: Blood.all.to_a.sample,
    expired_at: Time.now + rand(9).hours
  })
end