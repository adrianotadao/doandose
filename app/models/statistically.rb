class Statistically
  class << self

    #person count
    def total_person
      Person.all.count
    end

    #Subscribe per day of blood type
    def amount_of_blood_type(data_start, date_end)
      bloods = Blood.all
      bloods.map do |blood|
        (data_start.to_date..date_end.to_date).map do |date|
          (blood.people.where(:created_at.gte => date, :created_at.lte => date + 1.day).count).to_f
        end
      end
    end

    #blood
    def percentage_blood_type
      blood = Blood.all
      result = []
      blood.map do |b|
        quantity = Blood.where(name: b.name).first.people.count
        result << [ b.name, (100 * quantity / total_person.to_f).round(2) ]
      end
      result
    end

    #gender
    def percentage_gender
      ['m', 'f'].map do |g|
        counter = Person.where(sex: g).count
        [ g == 'm' ? 'Masculino' : 'Feminino', (100 * counter / total_person.to_f).round(2) ]
      end
    end

    #birthdate
    def indexed_ages_more
      birthdates = Person.only(:birthday).aggregate.sort_by{|e| -e["count"] }[0..8]
      count = 0

      result = birthdates.map do |b|
        percentage = ( 100 * b['count'] / total_person.to_f ).round(2)
        count += percentage
        [
          "#{ Date.today.strftime('%Y').to_i - b['birthday'].strftime('%Y').to_i } anos",
          percentage
        ]
      end
      result << ['Outras idades', 100 - count]
    end

    #notification
    def joined_by_blood_type
      notifications = Notification.all.asc(:created_at).limit( 5 )
      confirmed = notifications.map( &:person_notifications).map( &:count )

      {
        title: notifications.map( &:title ),
        confirmed: confirmed,
        not_confirmed: notifications.map( &:quantity ) -  confirmed
      }
    end
  end
end