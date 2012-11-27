#encoding: utf-8
%w(AB+ AB- A+ A- B+ B- O+ O-).each do |r|
    blood = Blood.create(:name => r)
    Status.errors(blood)
end