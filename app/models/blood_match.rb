class BloodMatch
  class << self
    def receives(blood)
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

    def donor(blood)
      case blood
        when 'A+' then ["A+", "AB+"]
        when 'A-' then ["A+", "A-", "AB+", "AB-"]
        when 'B+' then ["B+", "AB+"]
        when 'B-' then ["B+", "B-", "AB+", "AB-"]
        when 'O+' then ["A+", "B+", "AB+", "O+"]
        when 'O-' then ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"]
        when 'AB+' then ["AB+"]
        when 'AB-' then ["AB+", "AB-"]
      end
    end

  end
end