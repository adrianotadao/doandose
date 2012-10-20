#encoding: utf-8

20.times do
  c = Campaign.create({
    active: [true, false].sample,
    title: "campanha de doacao",
    content: "Teste teste teste",
    quantity: rand(99),
    company: Company.all.to_a.shuffle.first,
    blood: Blood.all.to_a.shuffle.first,
    expired_at: Time.now + rand(9).hours
  })
  c.errors
end