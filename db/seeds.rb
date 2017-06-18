# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# lets put some stockitems
Category.destory_all
Category.create({name_de: "", name_en: ""})
Stockitem.destroy_all

c = Category.create({name_de: "Abstellkammer", name_en: "Storeroom"})
Stockitem.create({title_de: "Staubsauger", details_hint_de: "", c})
Stockitem.create({title_de: "Dampfreiniger", details_hint_de: "", c})
Stockitem.create({title_de: "Bügeleisen", details_hint_de: "", c})
Stockitem.create({title_de: "Wäschemangel", details_hint_de: "", c})
Stockitem.create({title_de: "Robotersauger", details_hint_de: "", c})
Stockitem.create({title_de: "Einfache Reinigungsmittel", details_hint_de: "", c})
Stockitem.create({title_de: "Leiter", details_hint_de: "", c})
#Stockitem.create({title_de: "", details_hint_de: "", c})

c = Category.create({name_de: "Camping", name_en: "Camping"})
Stockitem.create({title_de: "Zelt", details_hint_de: "", c})
Stockitem.create({title_de: "Isomatte (aufblasbar)", details_hint_de: "", c})
Stockitem.create({title_de: "Campingkocher", details_hint_de: "", c})
Stockitem.create({title_de: "Wanderrucksack", details_hint_de: "Größe", c})
Stockitem.create({title_de: "Camping Laterne", details_hint_de: "", c})
Stockitem.create({title_de: "Hängematte", details_hint_de: "", c})
Stockitem.create({title_de: "Schlafsack", details_hint_de: "Größe", c})
#Stockitem.create({title_de: "", details_hint_de: "", c})

c = Category.create({name_de: "Küche", name_en: "Kitchen"})
Stockitem.create({title_de: "Smoothie Mixer", details_hint_de: "", c})
Stockitem.create({title_de: "Fondueset", details_hint_de: "", c})
Stockitem.create({title_de: "Raclette", details_hint_de: "", c})
Stockitem.create({title_de: "Brotbackautomat", details_hint_de: "", c})
Stockitem.create({title_de: "Küchenmaschine", details_hint_de: "", c})
Stockitem.create({title_de: "Fritteuse", details_hint_de: "", c})
Stockitem.create({title_de: "Waffeleisen", details_hint_de: "", c})
Stockitem.create({title_de: "Entsafter", details_hint_de: "", c})
Stockitem.create({title_de: "Sandwichtoaster", details_hint_de: "", c})
Stockitem.create({title_de: "Dampfgarer", details_hint_de: "", c})
Stockitem.create({title_de: "Dörrautomat", details_hint_de: "", c})
Stockitem.create({title_de: "Einfache Küchenutensilien", details_hint_de: "Töpfe, Pfannen, Sieb, Teigrolle u.ä.", c})
#Stockitem.create({title_de: "", details_hint_de: "", c})

c = Category.create({name_de: "Garten", name_en: "Garden"})
Stockitem.create({title_de: "Bierbankgarnitur", details_hint_de: "", c})
Stockitem.create({title_de: "Rasenmäher", details_hint_de: "", c})
Stockitem.create({title_de: "Gartenhäcksler", details_hint_de: "", c})
Stockitem.create({title_de: "Grill", details_hint_de: "", c})
Stockitem.create({title_de: "Gartenpavillon", details_hint_de: "", c})
Stockitem.create({title_de: "Slagline", details_hint_de: "", c})
Stockitem.create({title_de: "Minitrampolin", details_hint_de: "", c})
Stockitem.create({title_de: "Trampolin", details_hint_de: "", c})
Stockitem.create({title_de: "Pool", details_hint_de: "", c})
Stockitem.create({title_de: "Heckenschneider", details_hint_de: "", c})
#Stockitem.create({title_de: "", details_hint_de: "", c})

c = Category.create({name_de: "Sport", name_en: "Sports"})
Stockitem.create({title_de: "Surfbrett", details_hint_de: "", c})
Stockitem.create({title_de: "Snowboard", details_hint_de: "", c})
Stockitem.create({title_de: "Neoprenanzug", details_hint_de: "Größe", c})
Stockitem.create({title_de: "Flossen", details_hint_de: "Größe", c})
Stockitem.create({title_de: "Tauchmaske", details_hint_de: "", c})
Stockitem.create({title_de: "Fahrrad", details_hint_de: "Typ", c})
Stockitem.create({title_de: "Slagline", details_hint_de: "", c})
Stockitem.create({title_de: "Inline Skates", details_hint_de: "Größe", c})
Stockitem.create({title_de: "Stand-Up Paddleboard", details_hint_de: "", c})
Stockitem.create({title_de: "Ski", details_hint_de: "Typ und Größe", c})
Stockitem.create({title_de: "Schlauchboot", details_hint_de: "Größe", c})
Stockitem.create({title_de: "Paddelboot", details_hint_de: "Größe", c})
#Stockitem.create({title_de: "", details_hint_de: "", c})

c = Category.create({name_de: "Musik", name_en: "Music"})
Stockitem.create({title_de: "Trommel", details_hint_de: "", c})
Stockitem.create({title_de: "Gitarre", details_hint_de: "", c})
Stockitem.create({title_de: "E-Piano", details_hint_de: "", c})
Stockitem.create({title_de: "Geige", details_hint_de: "", c})
#Stockitem.create({title_de: "", details_hint_de: "", c})

c = Category.create({name_de: "Büro", name_en: "Bureau"})
Stockitem.create({title_de: "Drucker", details_hint_de: "", c})
Stockitem.create({title_de: "Scanner", details_hint_de: "", c})
Stockitem.create({title_de: "Beamer", details_hint_de: "", c})
Stockitem.create({title_de: "Schredder", details_hint_de: "", c})
#Stockitem.create({title_de: "", details_hint_de: "", c})

c = Category.create({name_de: "Kleidung Männer", name_en: "Men's Clothes"})
Stockitem.create({title_de: "Anzug", details_hint_de: "Größe", c})
frack = Stockitem.create({title_de: "Frack", details_hint_de: "Größe", c})
Stockitem.create({title_de: "Faschingskostüm", details_hint_de: "Größe und Typ", c})
Stockitem.create({title_de: "Halloweenkostüm", details_hint_de: "Größe und Typ", c})
#Stockitem.create({title_de: "", details_hint_de: "", c})

c = Category.create({name_de: "Kleidung Frauen", name_en: "Women's Clothes"})
Stockitem.create({title_de: "Abendkleid", details_hint_de: "Größe", c})
Stockitem.create({title_de: "Kostüm", details_hint_de: "Größe", c})
Stockitem.create({title_de: "Hosenanzug", details_hint_de: "Größe", c})
Stockitem.create({title_de: "Faschingskostüm", details_hint_de: "Größe und Typ", c})
Stockitem.create({title_de: "Halloweenkostüm", details_hint_de: "Größe und Typ", c})
Stockitem.create({title_de: "Sporttrickot", details_hint_de: "Größe und Typ", c})
#Stockitem.create({title_de: "", details_hint_de: "", c})

c = Category.create({name_de: "Werkstatt", name_en: "Workshop"})
Stockitem.create({title_de: "Bohrmaschine", details_hint_de: "", c})
Stockitem.create({title_de: "Schleifmaschine", details_hint_de: "", c})
Stockitem.create({title_de: "Drehmomentschlüssel", details_hint_de: "", c})
Stockitem.create({title_de: "Akkuschrauber", details_hint_de: "", c})
Stockitem.create({title_de: "Einfache Werkzeuge", details_hint_de: "Schrauberzieher, Hammer, Schraubenschlüssel u.ä.", c})
Stockitem.create({title_de: "Winkelschleifer", details_hint_de: "", c})
dremel = Stockitem.create({title_de: "Dremel", details_hint_de: "", c})
Stockitem.create({title_de: "Standbohrmaschine", details_hint_de: "", c})
#Stockitem.create({title_de: "", details_hint_de: "", c})
#Stockitem.create({title_de: "", details_hint_de: "", c})

if ENV['RAILS_ENV'].to_s == 'development' || ENV['RAILS_ENV'].to_s == ''
  # two users
  User.destroy_all

  user_martin = User.new
  user_martin.email = 'martinstefanputtke@posteo.de'
  user_martin.password = 'martin'
  user_martin.password_confirmation = 'martin'
  user_martin.nickname = "martin"
  user_martin.firstname = ""
  user_martin.lastname = ""
  user_martin.phoneno = ""
  user_martin.showemail = true
  user_martin.showphone = false
  user_martin.save!

  user_peter = User.new
  user_peter.email = 'peter@example.com'
  user_peter.password = 'peterp'
  user_peter.password_confirmation = 'peterp'
  user_peter.nickname = "peter"
  user_peter.firstname = ""
  user_peter.lastname = ""
  user_peter.phoneno = ""
  user_peter.showemail = true
  user_peter.showphone = false
  user_peter.save!

  # users need locations
  Location.destroy_all
  location_1 = user_martin.locations.create({street: "Hanauer Str.", number: "47", postcode: "", city: "Alzenau", country: ""})
  location_2 = user_martin.locations.create({street: "Goethestr.", number: "20", postcode: "", city: "Alzenau", country: ""})
  location_3 = user_peter.locations.create({street: "Haagweg", number: "12", postcode: "", city: "Wasserlos", country: ""})

  # a few articles
  Article.destroy_all
  user_martin.articles.create({title: "Dremel", details: "high tech", location_id: location_1.id, rate: "chocolate", stockitem_id: dremel.id})
  user_martin.articles.create({title: "Frack", details: "Größe XL", location_id: location_2.id, rate: "smile", stockitem_id: frack.id})
  user_peter.articles.create({title: "Milchkuh", details: "gescheckt", location_id: location_3.id, rate: "smile", stockitem_id: nil})
end
