#encoding: utf-8

20.times do
  notification = Notification.create({
    active: [true, false].sample,
    title: 'Criança precisa da sua ajuda',
    company: Company.all.to_a.sample,
    blood: Blood.all.to_a.sample,
    blood_type: Blood.all.to_a.sample,
    situation: ['Urgente', 'Moderado'].sample,
    quantity: rand(99),
    person_notifications: [PersonNotification.create(person: Person.all.to_a.sample)]
  })
  puts notification.errors
end