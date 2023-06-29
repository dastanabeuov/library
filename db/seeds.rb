first_group = Group.create!(name: "Library",
                      group_type: "Platform",
                      code: 0001,
                      email: "support@library.kz",
                      phone: "+7 707 700 3040",
                      active: true)


user = User.create!(first_name: 'Дастан',
                    last_name: 'Абеуов',
                    middle_name: 'Кайратович',
                    position: 'Супер Админ',
                    phone: '+7 707 159 7535',
                    role: 5,
                    email: 'superadmin@example.com',
                    password: 'password',
                    password_confirmation: 'password',
                    group_id: first_group.id
                    ) #if Rails.env.development?

user.skip_confirmation!
user.save!

21.times do |t|
  Category.create!(name: Faker::Books::CultureSeries.culture_ship_class, user_id: user.id ) #if Rails.env.development?
end

10.times do |t|
  Group.create!(name: Faker::Company.name,
                group_type: Faker::Company.type,
                code: Faker::Company.sic_code,
                email: "#{t}info@example.com",
                phone: "+#{Faker::Company.czech_organisation_number}",
                active: true)
end

Group.all.each do |group|
  file_group = File.open(Rails.root.join("app/assets/images/group.png"))
  group.logo.attach(io: file_group, filename: "group.png", content_type: 'application/png')
end


21.times do |t|
  Book.create!(title: "The well grounded rubyist",
               author: "David A.",
               description: "Welcome to the second edition of The Well-Grounded Rubyist.",
               category_ids: rand(1..21),
               user_id: user.id)
end

Book.all.each do |book|
  file_book = File.open(Rails.root.join("app/assets/images/the-well-grounded-rubyist.pdf"))
  book.main_pdf.attach(io: file_book, filename: "the-well-grounded-rubyist.pdf", content_type: 'application/pdf')
end

##First Group
file_first_group = File.open(Rails.root.join("app/assets/images/panda.png"))
first_group.logo.attach(io: file_first_group, filename: "panda.png", content_type: 'application/png')
