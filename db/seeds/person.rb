#encoding: utf-8

300.times do
  Person.create({
    blood: Blood.all.to_a.shuffle.first,
    donor: [true, false].sample,
    name: Faker::Name.first_name,
    surname: Faker::Name.last_name,
    sex: ['m', 'f'].sample,
    birthday: (Date.today - rand(99).years).to_s,
    weight: rand(99),
    height: rand(99),
    user_attributes: {email: Faker::Internet.email, password: '123123', password_confirmation: '123123'},
    contact_attributes: {ddd_phone: '18', phone: '123123123', ddd_cellphone: '18', cellphone: '123123123', email: Faker::Internet.email},
    address_attributes: {zip_code: '16200001', number: rand(9999), street: Faker::Address.street_name, neighborhood: Faker::Address.secondary_address, city: Faker::Address.city, state: Faker::Address.state, loc: ["-21.#{rand(99999999)}".to_f, "-50.#{rand(99999999)}".to_f]}
    })
end