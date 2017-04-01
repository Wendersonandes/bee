# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Marca.destroy_all
Modelo.destroy_all
Mat.destroy_all
Color.destroy_all
Type.destroy_all

Marca.create(name: "3D Cloner")
Marca.create(name: "3D Factories")
Marca.create(name: "3D Machine")
Marca.create(name: "3D Systems")
Marca.create(name: "Afinia")

Modelo.create(name: "cloner1", marca_id: Marca.find_by(name: "3D Cloner").id, desgaste: 0.0025)
Modelo.create(name: "cloner2", marca_id: Marca.find_by(name: "3D Cloner").id, desgaste: 0.0025)




Modelo.create(name: "2", marca_id: Marca.find_by(name: "3D Factories").id, desgaste: 0.0025)
Modelo.create(name: "3", marca_id: Marca.find_by(name: "3D Machine").id, desgaste: 0.0025)
Modelo.create(name: "4", marca_id: Marca.find_by(name: "3D Systems").id, desgaste: 0.0025)
Modelo.create(name: "5", marca_id: Marca.find_by(name: "Afinia").id, desgaste: 0.0025)

Mat.create(name: "PLA", potencia: 0.36, densidade: 1.24)
Mat.create(name: "ABS", potencia: 0.36, densidade: 1.03)
Mat.create(name: "COBRE", potencia: 0.36, densidade: 2)
Mat.create(name: "OUTRO", potencia: 0.36, densidade: 2)

Color.create(name: "Vermelho")
Color.create(name: "Amarelo")
Color.create(name: "Azul")
Color.create(name: "Verde")

Type.create(name: "Engenharia")
Type.create(name: "Decoracao")
Type.create(name: "Moda")
Type.create(name: "Outros")

