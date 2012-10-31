class Statistically
  class << self
    def total_per_day(date)
      User.where(:created_at.gte => date, :created_at.lte => date + 1.day).count
    end

    def total_per_blood_type(type, date)
      blood(type).people.where(:created_at.gte => date, :created_at.lte => date + 1.day).count
    end

    def blood(name)
      Blood.where(name: name).first
    end
  end
end