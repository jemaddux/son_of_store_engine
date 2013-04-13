#USERS
##Store Admins
User.create(full_name: "Chelsea Komlo", email: "chelsea.komlo@gmail.com",
  password: "password", role: :admin, display_name: "Chelsea Komlo", store_id: 1)
User.create(full_name: "Aimee Maher", email: "aimeegirl723@gmail.com",
  password: "password", role: :admin, display_name: "Aimee Maher", store_id: 2)
User.create(full_name: "Jeff", email: "demoXX+jeff@jumpstartlab.com",
  password: "password", role: :admin, display_name: "j3", store_id: 3)
##Store Stockers
User.create(full_name: "John Maddux", email: "jemaddux@gmail.com",
  password: "password", role: :stocker, display_name: "John Maddux", store_id: 1)
User.create(full_name: "Danny Garcia", email: "dannygarcia.me@gmail.com",
  password: "password", role: :stocker, display_name: "Danny Garcia", store_id: 2)
User.create(full_name: "Steve Klabnik", email: "demoXX+steve@jumpstartlab.com",
  password: "password", role: :stocker, display_name: "SkrilleX", store_id: 3)
##Shoppers
User.create(full_name: "Franklin Webber", email: "demoXX+franklin@jumpstartlab.com",
  password: "password", role: :user, display_name: "Franklin Webber")
##Platform Admin
User.create(full_name: "Katrina Owen", email: "demoXX+katrina@jumpstartlab.com",
  password: "password", role: :platform_admin, display_name: "Ree-na")

#Oregon Sale********************************************************************
Store.create(name: "Oregon Sale", description: "Oregon Sale", path: "oregonsale", status: "live", user_id: 1)

  # CATEGORIES
  Category.create(name: "Grub", store_id: 1)
  Category.create(name: "Clothing", store_id: 1)
  Category.create(name: "Weapons", store_id: 1)
  Category.create(name: "Tools", store_id: 1)
  Category.create(name: "Medicine", store_id: 1)
  Category.create(name: "Essentials", store_id: 1)

  ##GRUB
  Product.create( name: "Rations", price: 24, description: "Good for one 'splorer.", category_ids: ["1"], store_id: 1)
  Product.create( name: "Eggs", price: 5, description: "Farm fresh and ready to consume.", category_ids: ["1"], store_id: 1)
  Product.create( name: "Apples", price: 19, description: "Great for a snack!", category_ids: ["1"], store_id: 1)
  Product.create( name: "Hardtack", price: 40, description: "Simple cracker for simple folk.", category_ids: ["1"], store_id: 1)
  Product.create( name: "Prickly Pear", price: 60, description: "Prickly on the outside, scrumptious on the inside.", category_ids: ["1"], store_id: 1)
  Product.create( name: "Bacon", price: 100, description: "By the slab for the whole fam!", category_ids: ["1"], store_id: 1)
  Product.create( name: "Sarsaparilla", price: 3, description: "Before Coke, there was sarsaparilla.", category_ids: ["1"], store_id: 1)

  ##CLOTHING
  Product.create( name: "Basic Tunic", price: 75, description: "Plain ol' get-up for simple folk.", category_ids: ["2"], store_id: 1)
  Product.create( name: "Leather Armor", price: 250, description: "Good fer fendin' off 'coons and der sharp claws.", category_ids: ["2"], store_id: 1)
  Product.create( name: "Ponchos", price: 25, description: "It gets rainy on the trail. Better bring a poncho.", category_ids: ["2"], store_id: 1)
  Product.create( name: "Moccasins", price: 196, description: "Made with real Apache tears!", category_ids: ["2"], store_id: 1)
  Product.create( name: "Camouflage", price: 50, description: "Der buffalo won't be able to see yer.", category_ids: ["2"], store_id: 1)

  ##WEAPONS
  Product.create( name: "Blunderbuss", price: 150, description: "Big ol' gun, and loads of fun!", category_ids: ["3"], store_id: 1)
  Product.create( name: "Navy Revolver", price: 500, description: "Great for fightin' off vermits!", category_ids: ["3"], store_id: 1)
  Product.create( name: "Volcano Pistol", price: 891, description: "Bandits ain't gonna be stealin' none of you'ns rations.", category_ids: ["3"], store_id: 1)
  Product.create( name: "Kentucky Rifle", price: 250, description: "Good fer huntin' squirrels 'n' such.", category_ids: ["3"], store_id: 1)
  Product.create( name: "Buffalo Rifle", price: 1000, description: "Dis here's a one-shot K.O. Big gun fer big game.", category_ids: ["3"], store_id: 1)

  ##TOOLS
  Product.create( name: "Stone Hunting Knife", price: 98, description: "Good fer fur.", category_ids: ["3", "4"], store_id: 1)
  Product.create( name: "Snake Charm", price: 25, description: "Never git bit by a slippery snake 'gin!", category_ids: ["4"], store_id: 1)
  Product.create( name: "Compass", price: 62, description: "West is where yer headed, so's ya know.", category_ids: ["4"], store_id: 1)
  Product.create( name: "Sleeping Bag", price: 3, description: "Regain staminer! Warm 'n' cozy.", category_ids: ["4"], store_id: 1)
  Product.create( name: "Carpenter's Tools", price: 400, description: "Fer fixin' up der wagon in a jiff!", category_ids: ["4"], store_id: 1)
  Product.create( name: "Divining Rod", price: 500, description: "Water, water, anywhere? And lots and lots to drink!", category_ids: ["4"], store_id: 1)

  ##MEDICINE
  Product.create( name: "Miracle Cure", price: 3000, description: "Completely cures anything.", category_ids: ["5"], store_id: 1)
  Product.create( name: "Antivenom", price: 15, description: "Heals yer snakebite in a jiff.", category_ids: ["5"], store_id: 1)
  Product.create( name: "Lemon", price: 15, description: "Cures scurvy and tastes great too!", category_ids: ["1", "5"], store_id: 1)
  Product.create( name: "Medicine bag", price: 1000, description: "All yer fixin's in one handy sack.", category_ids: ["5"], store_id: 1)
  Product.create( name: "Cod Liver Oil", price: 10, description: "Tastes like dung. But good fer yer body.", category_ids: ["5"], store_id: 1)

  ##ESSENTIALS
  Product.create( name: "Oxen", price: 4000, description: "Strong, durable, and more MPG than yer SUV.", category_ids: ["6"], store_id: 1)
  Product.create( name: "Guide", price: 15000, description: "Well hey there, partner! I'm here to help.", category_ids: ["6"], store_id: 1)
  Product.create( name: "Wagon", price: 15000, description: "Made of wood, so you know it's good.", category_ids: ["6"], store_id: 1)
  Product.create( name: "Tombstone", price: 1000, description: "Cause one person always gets off'd on the Oregon Trail. Always.", category_ids: ["6"], store_id: 1)

  ##RETIRED
  Product.create( name: "Peacoat", price: 3000, description: "Classy coat for the classy gent.", category_ids: ["1"], retired: true, store_id: 1)

  #LINE ITEMS
  ##1
  LineItem.create(product_id: 1, cart_id: nil, order_id: 1, quantity: 3, price: 24)
  LineItem.create(product_id: 2, cart_id: nil, order_id: 1, quantity: 4, price: 200)
  LineItem.create(product_id: 3, cart_id: nil, order_id: 1, quantity: 5, price: 500)
  ##2
  LineItem.create(product_id: 25, cart_id: nil, order_id: 2, quantity: 1, price: 300)
  LineItem.create(product_id: 26, cart_id: nil, order_id: 2, quantity: 15, price: 205)
  LineItem.create(product_id: 6, cart_id: nil, order_id: 2, quantity: 4, price: 1000)
  ##3
  LineItem.create(product_id: 7, cart_id: nil, order_id: 3, quantity: 7, price: 600)
  LineItem.create(product_id: 10, cart_id: nil, order_id: 3, quantity: 1, price: 5)
  ##4
  LineItem.create(product_id: 1, cart_id: nil, order_id: 4, quantity: 1, price: 377)
  LineItem.create(product_id: 15, cart_id: nil, order_id: 4, quantity: 1, price: 111)
  ##5
  LineItem.create(product_id: 13, cart_id: nil, order_id: 5, quantity: 1, price: 800)
  ##6
  LineItem.create(product_id: 12, cart_id: nil, order_id: 6, quantity: 6, price: 123)
  LineItem.create(product_id: 11, cart_id: nil, order_id: 6, quantity: 2, price: 111)
  LineItem.create(product_id: 17, cart_id: nil, order_id: 6, quantity: 2, price: 89)
  ##7
  LineItem.create(product_id: 9, cart_id: nil, order_id: 7, quantity: 2, price: 4)
  ##8
  LineItem.create(product_id: 8, cart_id: nil, order_id: 8, quantity: 20, price: 800)
  ##9
  LineItem.create(product_id: 31, cart_id: nil, order_id: 9, quantity: 1, price: 444)
  LineItem.create(product_id: 32, cart_id: nil, order_id: 9, quantity: 2, price: 1230)
  LineItem.create(product_id: 33, cart_id: nil, order_id: 9, quantity: 3, price: 500)
  LineItem.create(product_id: 10, cart_id: nil, order_id: 9, quantity: 4, price: 110)
  ##10
  LineItem.create(product_id: 24, cart_id: nil, order_id: 10, quantity: 5, price: 80)
  LineItem.create(product_id: 23, cart_id: nil, order_id: 10, quantity: 6, price: 10)

  #ORDERS
  Order.create(status: "pending", user_id: 1, total_cost: 3372, card_number: "4242424242424242")
  Order.create(status: "pending", user_id: 4, total_cost: 7375, card_number: "4242424242424242")
  Order.create(status: "cancelled", user_id: 1, total_cost: 4205, card_number: "4242424242424242")
  Order.create(status: "cancelled", user_id: 1, total_cost: 488, card_number: "4242424242424242")
  Order.create(status: "paid", user_id: 4, total_cost: 800, card_number: "4242424242424242")
  Order.create(status: "paid", user_id: 1, total_cost: 1138, card_number: "4242424242424242")
  Order.create(status: "shipped", user_id: 4, total_cost: 8, card_number: "4242424242424242")
  Order.create(status: "shipped", user_id: 4, total_cost: 16000, card_number: "4242424242424242")
  Order.create(status: "returned", user_id: 1, total_cost: 4844, card_number: "4242424242424242")
  Order.create(status: "returned", user_id: 4, total_cost: 460, card_number: "4242424242424242")


#Cloak and Dagger***************************************************************
Store.create(name: "Cloak and Dagger", description: "Hide Yo Self", path: "cloakanddagger", status: "live", user_id: 2)

  # CATEGORIES
  Category.create(name: "Mustaches", store_id: 2)
  Category.create(name: "Cloaks", store_id: 2)
  Category.create(name: "Daggers", store_id: 2)

  ##Mustaches
  Product.create( name: "Hippy Mustache", price: 240, description: "Dude", category_ids: ["7"], store_id: 2)
  Product.create( name: "Rebel Mustache", price: 400, description: "Anaarchy", category_ids: ["7"], store_id: 2)
  Product.create( name: "Suburban Mustache", price: 424, description: "Too lazy to shave.", category_ids: ["7"], store_id: 2)

  ##GRUB
  Product.create( name: "Theatre Cloak", price: 24, description: "Dramatic", category_ids: ["8"], store_id: 2)
  Product.create( name: "Everyday Cloak", price: 234, description: "For casual wear", category_ids: ["8"], store_id: 2)
  Product.create( name: "Holiday Cloak", price: 524, description: "Complete with reinder", category_ids: ["8"], store_id: 2)

  ##GRUB
  Product.create( name: "Threatening Dagger", price: 24, description: "Dramatic", category_ids: ["9"], store_id: 2)
  Product.create( name: "Small Dagger", price: 234, description: "For casual wear", category_ids: ["9"], store_id: 2)
  Product.create( name: "Big Dagger", price: 524, description: "Really more of a sword", category_ids: ["9"], store_id: 2)

  #LINE ITEMS
  ##11
  LineItem.create(product_id: 34, cart_id: nil, order_id: 11, quantity: 3, price: 24)
  LineItem.create(product_id: 35, cart_id: nil, order_id: 11, quantity: 2, price: 24)
  LineItem.create(product_id: 36, cart_id: nil, order_id: 11, quantity: 5, price: 24)
  LineItem.create(product_id: 37, cart_id: nil, order_id: 11, quantity: 1, price: 24)


  #ORDERS
  Order.create(status: "pending", user_id: 7, total_cost: 3372, card_number: "4242424242424242")


#gSchool************************************************************************
Store.create(name: "gSchool", description: "We build developers", path: "gschool", status: "live", user_id: 3)
  
  # CATEGORIES
  Category.create(name: "Developers", store_id: 3)
  Category.create(name: "Projects", store_id: 3)
  Category.create(name: "Free Work", store_id: 3)

  ##Developers
  Product.create( name: "John", price: 4242, description: "Will work for money", category_ids: ["10"], store_id: 3)
  Product.create( name: "Danny Garcia", price: 4242, description: "Danarchy", category_ids: ["10"], store_id: 3)
  Product.create( name: "Aimee Maher", price: 4242, description: "Likes Comics, will photoshop", category_ids: ["10"], store_id: 3)
  Product.create( name: "Chelsea Komlo", price: 4242, description: "Likes Tests", category_ids: ["10"], store_id: 3)

  ##Projects
  Product.create( name: "Jetfuel", price: 240000, description: "Link shortener", category_ids: ["11"], store_id: 3)
  Product.create( name: "SalesEngine", price: 2340000, description: "For your dataz", category_ids: ["11"], store_id: 3)
  Product.create( name: "StoreEngine", price: 5240000, description: "This site but version 1.0", category_ids: ["11"], store_id: 3)

  #LINE ITEMS
  ##11
  LineItem.create(product_id: 43, cart_id: nil, order_id: 12, quantity: 5, price: 4242)
  LineItem.create(product_id: 44, cart_id: nil, order_id: 12, quantity: 5, price: 4242)
  LineItem.create(product_id: 45, cart_id: nil, order_id: 12, quantity: 5, price: 4242)
  LineItem.create(product_id: 46, cart_id: nil, order_id: 12, quantity: 5, price: 4242)


  #ORDERS
  Order.create(status: "pending", user_id: 7, total_cost: 84840, card_number: "4242424242424242")


