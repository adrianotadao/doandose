#encoding: utf-8

20.times do
  Notification.create({
    active: [true, false].sample,
    title: 'Criança precisa da sua ajuda',
    company: Company.all.to_a.shuffle.first,
    blood: Blood.all.to_a.shuffle.first,
    situation: ['Urgente', 'Moderado'].sample,
    quantity: rand(99)
  })
end