#encoding: utf-8

50.times do
  company = Company.create({
    name: Faker::Company.name,
    fancy_name: Faker::Company.bs,
    cnpj: rand(999999),
    responsible: Faker::Name.name,
    user_attributes: {email: Faker::Internet.email, password: '123123', password_confirmation: '123123'},
    contact_attributes: {ddd_phone: 18, phone: 123123123, ddd_cellphone: 18,  cellphone: 123123123, email: Faker::Internet.email},
    address_attributes: {zip_code: 16200001, number: rand(9999), street: Faker::Address.street_name, neighborhood: Faker::Address.secondary_address, city: Faker::Address.city, state: Faker::Address.state, loc: ["-21.#{rand(99999999)}".to_f, "-50.#{rand(99999999)}".to_f]}
    })
end

Company.create({"name"=>"Santa Casa de Birigui", "fancy_name"=>"Santa casa", "cnpj"=>"11.111.111/1111-11", "responsible"=>"Roberto", "address_attributes"=>{"zip_code"=>16201010, "number"=>41257, "street"=>"R. Dr. Carlos Carvalho Rosa", "neighborhood"=>"Patrimônio Silvares", "city"=>"Birigui", "state"=>"São Paulo", "complement"=>"", "loc"=>[-21.2825835, -50.33602689999998]}, "contact_attributes"=>{"ddd_phone"=>18, "phone"=>11111111, "ddd_cellphone"=>18, "cellphone"=>11111111, "email"=>"santacasa@teste.com.br"}, "user_attributes"=>{"email"=>"santacasa@doando.se", "password"=>"123123", "password_confirmation"=>"123123"}})
Company.create({"name"=>"Centro Médico de Birigui", "fancy_name"=>"Centro Médico", "cnpj"=>"22.111.111/1111-11", "responsible"=>"Roberto", "address_attributes"=>{"zip_code"=>16201010, "number"=>257, "street"=>"R. Dr. Carlos Carvalho Rosa", "neighborhood"=>"Patrimônio Silvares", "city"=>"Birigui", "state"=>"São Paulo", "complement"=>"", "loc"=>[-21.2887222, -50.34439450000002]}, "contact_attributes"=>{"ddd_phone"=>18, "phone"=>11111111, "ddd_cellphone"=>18, "cellphone"=>11111111, "email"=>"centromedico@teste.com.br"}, "user_attributes"=>{"email"=>"centromedico@doando.se", "password"=>"123123", "password_confirmation"=>"123123"}})