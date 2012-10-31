class Statistically
  class << self
    def person_total
      Person.all.count
    end

    def total_per_day(date)
      User.where(:created_at.gte => date, :created_at.lte => date + 1.day).count
    end

    def total_per_blood_type(type, date)
      blood(type).people.where(:created_at.gte => date, :created_at.lte => date + 1.day).count
    end

    def blood(name)
      Blood.where(name: name).first
    end

    def blood_count(blood)
      Blood.where(name: blood).first.people.count
    end

    def blood_percentage(blood)
      (100 * blood_count(blood) / person_total.to_f).round(2)
    end
  end
end