puts 'Cleaning database...'
Item.destroy_all
User.destroy_all

puts 'Creating users...'

yellow_dress = "https://gloimg.rglcdn.com/rosegal/pdm-product-pic/Clothing/2018/01/04/goods-img/1520888199426319333.jpg"
orange_dress = "http://res.cloudinary.com/dz7bo1h7x/image/upload/v1527772491/n5cy7raoveb6fqfpkag3.jpg"
pink_dress = "http://res.cloudinary.com/dz7bo1h7x/image/upload/v1527772491/cizyyt205j9v99rwporf.jpg"
black_dress = "http://res.cloudinary.com/dz7bo1h7x/image/upload/v1527867463/black_dress.jpg"

henri = User.create(
  address: "Big ben London",
  first_name: "Henri",
  last_name: "Paris",
  email: "paris_henri@yahoo.fr",
  password: "123456"
)

User.create(
  address: "Tower Bridge",
  first_name: "Arthur",
  last_name: "Maisonnier",
  email: "arthurmaisonnier@gmail.com",
  password: "123456"
)


puts 'Creating items...'

itemfirst = Item.new(
  name: "blue dress",
  description: "this is a very nice cocktail dress",
  size: "m",
  user: henri,
  availability: "true",
  color: "blue",
  rental_price_cents: 500,
  buying_price_cents: 1000,
  sku: "bluedress",
  category: "dress",
  available_start_date: Date.parse('29-04-2018'),
  available_end_date: Date.parse('29-04-2020')
)

itemfirst.remote_photo_url = black_dress
itemfirst.save


itemsecond = Item.new(
  name: "coral dress",
  description: "this is an ugly nice cocktail dress",
  size: "m",
  user: henri,
  availability: "true",
  color: "yellow",
  rental_price_cents: 600,
  buying_price_cents: 2000,
  sku: "coraldress",
  category: "dress",
  available_start_date: Date.parse('29-04-2018'),
  available_end_date: Date.parse('29-04-2020')
)

itemsecond.remote_photo_url = orange_dress
itemsecond.save

itemthird = Item.new(
  name: "black dress",
  description: "this is a very nice wedding dress",
  size: "XL",
  user: henri,
  availability: "true",
  photo: "xgafbbdnz3dkh9ddruck.jpg",
  color: "black",
  rental_price_cents: 700,
  buying_price_cents: 3000,
  sku: "blackdress",
  category: "dress",
  available_start_date: Date.parse('29-04-2018'),
  available_end_date: Date.parse('29-04-2020')
)

itemthird.remote_photo_url = black_dress
itemthird.save


itemfour = Item.new(
  name: "pink dress",
  description: "this is a very nice summer dress",
  size: "s",
  user: henri,
  availability: "true",
  color: "pink",
  rental_price_cents: 900,
  buying_price_cents: 4000,
  sku: "pinkdress",
  category: "dress",
  available_start_date: Date.parse('29-04-2018'),
  available_end_date: Date.parse('29-04-2020')
)

itemfour.remote_photo_url = pink_dress
itemfour.save

itemfive = Item.new(
  name: "red dress",
  description: "this is a very nice party dress",
  size: "m",
  user: henri,
  availability: "true",
  color: "red",
  rental_price_cents: 300,
  buying_price_cents: 1000,
  sku: "reddress",
  category: "dress",
  available_start_date: Date.parse('29-04-2018'),
  available_end_date: Date.parse('29-04-2020')
)

itemfive.remote_photo_url = pink_dress
itemfive.save

itemsix = Item.new(
  name: "yellow dress",
  description: "this is a very corporate dress",
  size: "m",
  user: henri,
  availability: "true",
  color: "yellow",
  rental_price_cents: 500,
  buying_price_cents: 1000,
  sku: "yellowdress",
  category: "dress",
  available_start_date: Date.parse('29-04-2018'),
  available_end_date: Date.parse('29-04-2020')
)

itemsix.remote_photo_url = yellow_dress
itemsix.save

puts 'Created #{Item.count} items'
