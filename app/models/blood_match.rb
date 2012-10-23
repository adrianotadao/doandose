class BloodMatch
  class << self
    def matcher(blood)
      case blood
        when 'A+' then ["A+", "A-", "O+", "O-"]
        when 'A-' then ["O-", "A-"]
        when 'B+' then ["B+", "B-", "O+", "O-"]
        when 'B-' then ["B-", "O-"]
        when 'O+' then ["O+", "O-"]
        when 'O-' then ["O-"]
        when 'AB+' then ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"]
        when 'AB-' then ["A-", "B-", "AB-", "O-"]
      end
    end
  end
end