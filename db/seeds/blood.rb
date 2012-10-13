#encoding: utf-8

%w(AB+ AB- A+ A- B+ B- O+ O-).each{|r| Blood.create(:name => r) }