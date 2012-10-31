class Statistically
  class << self
    def person_total
      Person.all.count
    end

    #Subscribe per day
    def total_per_day(date)
      User.where(:created_at.gte => date, :created_at.lte => date + 1.day).count
    end

    #Subscribe per day of blood type
    def blood(name)
      Blood.where(name: name).first
    end

    def total_per_blood_type(type, date)
      blood(type).people.where(:created_at.gte => date, :created_at.lte => date + 1.day).count
    end

    #blood percente
    def blood_count(blood)
      Blood.where(name: blood).first.people.count
    end

    def blood_percentage(blood)
      (100 * blood_count(blood) / person_total.to_f).round(2)
    end

    #gender percente
    def gender_count(gender)
      Person.where(sex: gender).count
    end

    def gender_percentage(gender)
      (100 * gender_count(gender) / person_total.to_f).round(2)
    end

    #birthdate
    def birthdate_max
       Person.only(:birthday).aggregate.sort_by{|e| -e["count"]}[0..8]
    end

    def birthdate_percent(position)
      return false if position > birthdate_max.length
      [years_old(position), (100 * birthdate_max[position]['count'] / person_total.to_f)]
    end

    def years_old(position)
      return false if position > birthdate_max.length
      Date.today.strftime('%Y').to_i - birthdate_max[position]['birthday'].strftime('%Y').to_i
    end

  end
end