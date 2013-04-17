def seed_products(store, count)
  count.times do |x|
    begin
      puts "Creating product #{x + 1} for store #{store.id}."
      name = Andrey::Word.generate(length: 10).to_s + rand(10000).to_s
      desc = Faker::Lorem.sentence(word_count = 6)
      store.products.create!(name:         name,
                             description:  desc,
                             price:        rand(2000) + 1,
                             category_ids: store.categories.sample.id,
                             retired:      false)
    rescue
      puts "Product name is taken. Retrying."
      retry
    end
  end
end

def seed_categories(store, count)
  count.times do |x|
    begin
      name = Andrey::Word.generate(length: 7)
      store.categories.create!(name: name)
      puts "Category #{name} created for store #{store.id}."
    rescue
      puts "Category name taken dude! I is retrying."
      retry
    end
  end
end

def seed_users(count)
  count.times do |x|
    puts "Creating user #{x + 1}"
    User.create!(full_name:             "full_name#{x + 1}",
                 email:                 "user#{x + 1}@email.com",
                 display_name:          "display_name#{x + 1}",
                 password:              "password",
                 password_confirmation: "password")
  end
end

def seed_store_admins(store, count)
  count.times do |x|
    User.create!(full_name:    "store admin #{x + 1}",
                email:        "storeadmin#{x + 1}@email.com",
                password:     "password",
                role:         :admin,
                display_name: "storeadmin#{x + 1}",
                store_id:     store.id)
  end
end

def seed_store_stockers(store, count)
  count.times do |x|
    User.create!(full_name:    "store stocker#{x + 1}",
                email:        "storestocker#{x + 1}@email.com",
                password:     "password",
                role:         :stocker,
                display_name: "storestocker#{x + 1}",
                store_id:     store.id)
  end
end

def seed_store_orders(store, count)
  statuses = %w[pending shipped cancelled returned paid]
  count.times do |x|
    Order.create!(status:   statuses.sample,
                  user_id:  rand(10_000),
                  store_id: store.id)
  end
end



### Crete Stores ###
store1 = Store.create!(name: "Oregon Sale", description: "Oregon Sale", path: "oregonsale", status: "live")
store2 = Store.create!(name: "Cloak and Dagger", description: "Hide Yo Self", path: "cloakanddagger", status: "live")
store3 = Store.create!(name: "gSchool", description: "We build developers", path: "gschool", status: "live")
store4 = Store.create!(name: "Blair's Juices", description: "Kale, muthatrucka!", path: "kale", status: "live")
store5 = Store.create!(name: "James' Survial Store", description: "We provide what you need to escape this wretched 'Merica", path: "hideyokids", status: "live")
store6 = Store.create!(name: "Jorge's goat farm", description: "Come have fun at the expense of fainting goats!", path: "goats", status: "live")
store7 = Store.create!(name: "Shane's Irish Pub", description: "Come get wasted with mates that are good crack!", path: "stpatrick", status: "live")
store8 = Store.create!(name: "Kareem's Magic Pill", description: "Work, work, work. You'll never need to sleep again!", path: "robot", status: "live")
store9 = Store.create!(name: "Raphael's Answers", description: "Need answers to your questions, ask me. I know everything!", path: "genius", status: "pending")
store10 = Store.create!(name: "Daniels Extreme Sports", description: "Got adrenaline? We can help with that.", path: "skis", status: "pending")

stores = [store1, store2, store3, store4, store5, store6, store7, store8, store9, store10]


### Create Products ###
stores.each { |store| seed_products(store, 10_000) }

### Create Categories ###
stores.each { |store| seed_categories(store, 10) }

### Create Shoppers ###
seed_users(10_000)

### Create Store Admins ###
stores.each {|store| seed_store_admins(store, 2)}

### Create Store Stockers ###
stores.each {|store| seed_store_stockers(store, 2)}

### Create Store Orders ###
stores.each {|store| seed_store_orders(store, 20)}


### Required Store Admin ###
User.create(full_name: "Jeff",
            email: "demoXX+jeff@jumpstartlab.com",
            password: "password",
            role: :admin,
            display_name: "j3",
            store_id: 3)
### Required Store Stocker ###
User.create(full_name: "Katrina Owen",
            email: "demoXX+katrina@jumpstartlab.com",
            password: "password",
            role: :stocker,
            display_name: "Ree-na",
            store_id: 3)
### Required Platform Admin ###
User.create(full_name: "Steve Klabnik",
            email: "demoXX+steve@jumpstartlab.com",
            password: "password",
            role: :platform_admin,
            display_name: "SkrilleX")
User.create(full_name: "Danny Garcia",
            email: "demoXX+danny@jumpstartlab.com",
            password: "password",
            role: :platform_admin,
            display_name: "dannygarcia")






