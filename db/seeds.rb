# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# lets put some stockitems
Stockitem.destroy_all

Stockitem.create({title: "Staubsauger", details_hint: "", rate: "1€/Tag", room: "Abstellkammer"})
Stockitem.create({title: "Dampfreiniger", details_hint: "", rate: "5€/Tag", room: "Abstellkammer"})
Stockitem.create({title: "Bügeleisen", details_hint: "", rate: "1€/Tag", room: "Abstellkammer"})
Stockitem.create({title: "Wäschemangel", details_hint: "", rate: "3€/Tag", room: "Abstellkammer"})
Stockitem.create({title: "Robotersauger", details_hint: "", rate: "5€/Tag", room: "Abstellkammer"})
Stockitem.create({title: "Einfache Reinigungsmittel", details_hint: "", rate: "1€/Tag", room: "Abstellkammer"})
Stockitem.create({title: "Leiter", details_hint: "", rate: "2€/Tag", room: "Abstellkammer"})
#Stockitem.create({title: "", details_hint: "", rate: "1€/Tag", room: "Abstellkammer"})

Stockitem.create({title: "Zelt", details_hint: "", rate: "20€/Woche", room: "Camping"})
Stockitem.create({title: "Isomatte (aufblasbar)", details_hint: "", rate: "5€/Woche", room: "Camping"})
Stockitem.create({title: "Campingkocher", details_hint: "", rate: "5€/Woche", room: "Camping"})
Stockitem.create({title: "Wanderrucksack", details_hint: "Größe", rate: "10€/Woche", room: "Camping"})
Stockitem.create({title: "Camping Laterne", details_hint: "", rate: "5€/Woche", room: "Camping"})
Stockitem.create({title: "Hängematte", details_hint: "", rate: "5€/Woche", room: "Camping"})
Stockitem.create({title: "Schlafsack", details_hint: "Größe", rate: "5€/Woche", room: "Camping"})
#Stockitem.create({title: "", details_hint: "", rate: "1€/Tag", room: "Camping"})

Stockitem.create({title: "Smoothie Mixer", details_hint: "", rate: "3€/Tag", room: "Küche"})
Stockitem.create({title: "Fondueset", details_hint: "", rate: "3€/Tag", room: "Küche"})
Stockitem.create({title: "Raclette", details_hint: "", rate: "5€/Tag", room: "Küche"})
Stockitem.create({title: "Brotbackautomat", details_hint: "", rate: "5€/Woche", room: "Küche"})
Stockitem.create({title: "Küchenmaschine", details_hint: "", rate: "3€/Tag", room: "Küche"})
Stockitem.create({title: "Fritteuse", details_hint: "", rate: "3€/Tag", room: "Küche"})
Stockitem.create({title: "Waffeleisen", details_hint: "", rate: "3€/Tag", room: "Küche"})
Stockitem.create({title: "Entsafter", details_hint: "", rate: "3€/Tag", room: "Küche"})
Stockitem.create({title: "Sandwichtoaster", details_hint: "", rate: "2€/Tag", room: "Küche"})
Stockitem.create({title: "Dampfgarer", details_hint: "", rate: "3€/Tag", room: "Küche"})
Stockitem.create({title: "Dörrautomat", details_hint: "", rate: "3€/Tag", room: "Küche"})
Stockitem.create({title: "Einfache Küchenutensilien", details_hint: "Töpfe, Pfannen, Sieb, Teigrolle u.ä.", rate: "1€/Tag", room: "Küche"})
#Stockitem.create({title: "", details_hint: "", rate: "1€/Tag", room: "Küche"})

Stockitem.create({title: "Bierbankgarnitur", details_hint: "", rate: "5€/Tag", room: "Garten"})
Stockitem.create({title: "Rasenmäher", details_hint: "", rate: "1€/Tag", room: "Garten"})
Stockitem.create({title: "Gartenhäcksler", details_hint: "", rate: "10€/Tag", room: "Garten"})
Stockitem.create({title: "Grill", details_hint: "", rate: "3€/Tag", room: "Garten"})
Stockitem.create({title: "Gartenpavillon", details_hint: "", rate: "3€/Tag", room: "Garten"})
Stockitem.create({title: "Slagline", details_hint: "", rate: "3€/Tag", room: "Garten"})
Stockitem.create({title: "Minitrampolin", details_hint: "", rate: "3€/Tag", room: "Garten"})
Stockitem.create({title: "Trampolin", details_hint: "", rate: "10€/Tag", room: "Garten"})
Stockitem.create({title: "Pool", details_hint: "", rate: "10€/Tag", room: "Garten"})
Stockitem.create({title: "Heckenschneider", details_hint: "", rate: "3€/Tag", room: "Garten"})
#Stockitem.create({title: "", details_hint: "", rate: "1€/Tag", room: "Garten"})

Stockitem.create({title: "Surfbrett", details_hint: "", rate: "25€/Woche", room: "Sport"})
Stockitem.create({title: "Snowboard", details_hint: "", rate: "25€/Woche", room: "Sport"})
Stockitem.create({title: "Neoprenanzug", details_hint: "Größe", rate: "10€/Woche", room: "Sport"})
Stockitem.create({title: "Flossen", details_hint: "Größe", rate: "5€/Woche", room: "Sport"})
Stockitem.create({title: "Tauchmaske", details_hint: "", rate: "5€/Woche", room: "Sport"})
Stockitem.create({title: "Fahrrad", details_hint: "Typ", rate: "5€/Tag", room: "Sport"})
Stockitem.create({title: "Slagline", details_hint: "", rate: "3€/Tag", room: "Sport"})
Stockitem.create({title: "Inline Skates", details_hint: "Größe", rate: "3€/Tag", room: "Sport"})
Stockitem.create({title: "Stand-Up Paddleboard", details_hint: "", rate: "5€/Tag", room: "Sport"})
Stockitem.create({title: "Ski", details_hint: "Typ und Größe", rate: "25€/Woche", room: "Sport"})
Stockitem.create({title: "Schlauchboot", details_hint: "Größe", rate: "5€/Tag", room: "Sport"})
Stockitem.create({title: "Paddelboot", details_hint: "Größe", rate: "10€/Tag", room: "Sport"})
#Stockitem.create({title: "", details_hint: "", rate: "1€/Tag", room: "Sport"})

Stockitem.create({title: "Trommel", details_hint: "", rate: "1€/Tag", room: "Musikinstrumente"})
Stockitem.create({title: "Gitarre", details_hint: "", rate: "3€/Tag", room: "Musikinstrumente"})
Stockitem.create({title: "E-Piano", details_hint: "", rate: "5€/Tag", room: "Musikinstrumente"})
Stockitem.create({title: "Geige", details_hint: "", rate: "5€/Tag", room: "Musikinstrumente"})
#Stockitem.create({title: "", details_hint: "", rate: "1€/Tag", room: "Musikinstrumente"})

Stockitem.create({title: "Drucker", details_hint: "", rate: "0.10€/Seite", room: "Büro"})
Stockitem.create({title: "Scanner", details_hint: "", rate: "0.10€/Scan", room: "Büro"})
Stockitem.create({title: "Beamer", details_hint: "", rate: "5€/Tag", room: "Büro"})
Stockitem.create({title: "Schredder", details_hint: "", rate: "2€/Tag", room: "Büro"})
#Stockitem.create({title: "", details_hint: "", rate: "1€/Tag", room: "Büro"})

Stockitem.create({title: "Anzug", details_hint: "Größe", rate: "10€/Tag", room: "Kleidung Männer"})
frack = Stockitem.create({title: "Frack", details_hint: "Größe", rate: "10€/Tag", room: "Kleidung Männer"})
Stockitem.create({title: "Faschingskostüm", details_hint: "Größe und Typ", rate: "5€/Tag", room: "Kleidung Männer"})
Stockitem.create({title: "Halloweenkostüm", details_hint: "Größe und Typ", rate: "5€/Tag", room: "Kleidung Männer"})
#Stockitem.create({title: "", details_hint: "", rate: "1€/Tag", room: "Kleidung Männer"})

Stockitem.create({title: "Abendkleid", details_hint: "Größe", rate: "10€/Tag", room: "Kleidung Frauen"})
Stockitem.create({title: "Kostüm", details_hint: "Größe", rate: "5€/Tag", room: "Kleidung Frauen"})
Stockitem.create({title: "Hosenanzug", details_hint: "Größe", rate: "10€/Tag", room: "Kleidung Frauen"})
Stockitem.create({title: "Faschingskostüm", details_hint: "Größe und Typ", rate: "5€/Tag", room: "Kleidung Frauen"})
Stockitem.create({title: "Halloweenkostüm", details_hint: "Größe und Typ", rate: "5€/Tag", room: "Kleidung Frauen"})
Stockitem.create({title: "Sporttrickot", details_hint: "Größe und Typ", rate: "5€/Tag", room: "Kleidung Frauen"})
#Stockitem.create({title: "", details_hint: "", rate: "1€/Tag", room: "Kleidung Frauen"})

Stockitem.create({title: "Bohrmaschine", details_hint: "", rate: "3€/Tag", room: "Werkstatt"})
Stockitem.create({title: "Schleifmaschine", details_hint: "", rate: "5€/Tag", room: "Werkstatt"})
Stockitem.create({title: "Drehmomentschlüssel", details_hint: "", rate: "1€/Tag", room: "Werkstatt"})
Stockitem.create({title: "Akkuschrauber", details_hint: "", rate: "3€/Tag", room: "Werkstatt"})
Stockitem.create({title: "Einfache Werkzeuge", details_hint: "Schrauberzieher, Hammer, Schraubenschlüssel u.ä.", rate: "1€/Tag", room: "Werkstatt"})
Stockitem.create({title: "Winkelschleifer", details_hint: "", rate: "5€/Tag", room: "Werkstatt"})
dremel = Stockitem.create({title: "Dremel", details_hint: "", rate: "5€/Tag", room: "Werkstatt"})
Stockitem.create({title: "Standbohrmaschine", details_hint: "", rate: "2€/Benutzung", room: "Werkstatt"})
#Stockitem.create({title: "", details_hint: "", rate: "1€/Tag", room: "Werkstatt"})
#Stockitem.create({title: "", details_hint: "", rate: "1€/Tag", room: ""})

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
location_1 = user_martin.locations.create({street_and_no: "Hanauer Str. 47", postcode: "", city: "Alzenau", country: ""})
location_2 = user_martin.locations.create({street_and_no: "Goethestr. 20", postcode: "", city: "Alzenau", country: ""})
location_3 = user_peter.locations.create({street_and_no: "Haagweg. 12", postcode: "", city: "Wasserlos", country: ""})

# a few articles
Article.destroy_all
user_martin.articles.create({title: "Dremel", details: "high tech", location_id: location_1.id, quality: 3, rate: "3€ pro Tag", gratis: false, stockitem_id: dremel.id})
user_martin.articles.create({title: "Frack", details: "Größe XL", location_id: location_2.id, quality: 5, rate: "5€ pro Tag", gratis: false, stockitem_id: frack.id})
user_peter.articles.create({title: "Milchkuh", details: "gescheckt", location_id: location_3.id, quality: 5, rate: "5€ pro Tag", gratis: true, stockitem_id: nil})
