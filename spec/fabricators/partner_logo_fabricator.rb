Fabricator(:partner_logo) do
  data { File.open('spec/images/image.png')  }
end