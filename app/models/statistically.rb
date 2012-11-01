class Statistically
  class << self

    #global
    def person_total
      Person.all.count
    end

    #Subscribe per day of blood type
    def amount_of_blood_type(type, date)
      blood = Blood.where(name: type).first
      blood.people.where(:created_at.gte => date, :created_at.lte => date + 1.day).count
    end

    #blood
    def percentage_blood_type(blood)
      blood = Blood.where(name: blood).first.people.count
      (100 * blood / person_total.to_f).round(2)
    end

    #gender
    def percentage_gender(gender)
      gender = Person.where(sex: gender).count
      (100 * gender / person_total.to_f).round(2)
    end

    #birthdate
    def indexed_ages_more
      birthdates = Person.only(:birthday).aggregate.sort_by{|e| -e["count"]}[0..8]

      birthdates.map do |b|
        [
          "#{ Date.today.strftime('%Y').to_i - b['birthday'].strftime('%Y').to_i } anos",
          ( 100 * b['count'] / person_total.to_f ).round(2)
        ]
      end
    end

    #notification
    def joined_by_blood_type
      notifications = Notification.all.asc(:created_at)[0..5]

      {
        title: notifications.map{|t| t.title.to_s },
        confirmed: notifications.map{ |c| c.person_notifications.count },
        not_confirmed: notifications.map{ |c| c.quantity - c.person_notifications.count }
      }
    end
  end
end