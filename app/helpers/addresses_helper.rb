module AddressesHelper

  def states_collection
    %w(AC AL AP AM BA CE DF ES GO MA MT MS MG PA PB PR PE PI RJ RN RS RO RR SC SP SE TO)
  end

  def coordenations(addresses)
    coordenation = []
    addresses.each do |r|
      coordenation << r.full_coordenation if r.full_coordenation
    end
    coordenation
  end
  
end
