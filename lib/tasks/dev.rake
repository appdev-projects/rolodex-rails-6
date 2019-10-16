namespace(:dev) do
  desc "Hydrate the database with some dummy data to look at so that developing is easier"
  task({ :prime => :environment}) do
    require "faker"
    company_records = []
    100.times do
      company_records.push(
        {:founded_on => Faker::Date.between(from: 2.months.ago, to: Date.today), :industry => Faker::Company.industry, :last_year_revenue => Faker::Number.within(range: -500..10_000_000), :structure => Faker::Company.suffix, :name => Faker::Company.name },    
      )
    end
     if ActiveRecord::Base.connection.table_exists? "companies"
       Company.delete_all
       Company.insert_all!(company_records)
       p "Created #{Company.count} Company records"

     end
    contact_records = []
    100.times do 
      contact_records.push(
        {:first_name => Faker::Name.first_name , :last_name => Faker::Name.last_name , :date_of_birth => Faker::Date.birthday(min_age: 18, max_age: 65)},
      )
    end
     if ActiveRecord::Base.connection.table_exists? "contacts"
        Contact.delete_all
        Contact.insert_all!(contact_records)
        puts "Created #{Contact.count} Contact records"

     end

  end
end
