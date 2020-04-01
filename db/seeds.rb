# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Shelter.destroy_all
Pet.destroy_all
ApplicationPet.destroy_all
ShelterReview.destroy_all

shelter_1 = Shelter.create(name: "Denver Animal Shelter",
                           address: "500 Invisible St.",
                           city: "Denver",
                           state: "Colorado",
                           zip: "80201")

shelter_2 = Shelter.create(name: "Downtown Animal Shelter",
                           address: "2550 WeWatta St.",
                           city: "Denver",
                           state: "Colorado",
                           zip: "80222")

shelter_3 = Shelter.create(name: "Aurora Animal Shelter",
                           address: "3665 E. Colfax Ave.",
                           city: "Aurora",
                           state: "Colorado",
                           zip: "80399")

pet_1 = Pet.create(image: 'https://i.etsystatic.com/6800741/r/il/624c21/1191091098/il_fullxfull.1191091098_i1jl.jpg',
                 name: 'Rover',
                 age: 3,
                 sex: "Male",
                 shelter: shelter_1,
                 description: "He's a Biter!",
                 status: "Adoptable")

pet_2 = Pet.create(image: "https://media1.fdncms.com/sevendaysvt/imager/u/blog/28218452/animalissue2-1-43f2a278bdb53e2e.jpg?cb=1565792097",
                 name: "Johnny",
                 age: 3,
                 sex: "Female",
                 shelter: shelter_1,
                 description: "Cute hedgehog!",
                 status: "Adoptable")

pet_3 = Pet.create(image: 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/chihuahua-dog-running-across-grass-royalty-free-image-1580743445.jpg?crop=0.984xw:0.738xh;0,0.0938xh&resize=980:*',
                 name: "George",
                 age: 2,
                 sex: "Male",
                 shelter: shelter_2,
                 description: "Spunky!",
                 status: "Adoptable")

pet_4 = Pet.create(image: "https://i.ytimg.com/vi/AdSpm574rUU/maxresdefault.jpg",
                 name: "Leon",
                 age: 2,
                 sex: "Male",
                 shelter: shelter_2,
                 description: "Spunky!",
                 status: "Adoptable")

pet_5 = Pet.create(image: 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/chihuahua-dog-running-across-grass-royalty-free-image-1580743445.jpg?crop=0.984xw:0.738xh;0,0.0938xh&resize=980:*',
                 name: "Obi-Wan",
                 age: 2,
                 sex: "Male",
                 shelter: shelter_2,
                 description: "Spunky!",
                 status: "Adoptable")

pet_6 = Pet.create(image: 'https://i.etsystatic.com/6800741/r/il/624c21/1191091098/il_fullxfull.1191091098_i1jl.jpg',
                 name: 'Jerry',
                 age: 3,
                 sex: "Male",
                 shelter: shelter_2,
                 description: "He's a Biter!",
                 status: "Adoptable")


review1 = shelter_1.shelter_reviews.create!(title: "Horrible Shelter",
                                  rating: "1/5",
                                  content: "They stole my dog!",
                                  image: "https://i.ytimg.com/vi/tLY-qCnnPQM/maxresdefault.jpg")

review2 = shelter_1.shelter_reviews.create!(title: "Great Shelter",
                                  rating: "4/5",
                                  content: "They didn't steal my dog!")

review1 = shelter_2.shelter_reviews.create!(title: "Horrible Shelter",
                               rating: "1/5",
                               content: "They stole my dog!",
                               image: "https://i.ytimg.com/vi/tLY-qCnnPQM/maxresdefault.jpg")

review2 = shelter_2.shelter_reviews.create!(title: "Great Experience!",
                               rating: "3/5",
                               content: "Grabbed a new dog and ran away with it!",
                               image: "https://i.ytimg.com/vi/tLY-qCnnPQM/maxresdefault.jpg")

review3 = shelter_2.shelter_reviews.create!(title: "Horrible Shelter",
                               rating: "1/5",
                               content: "They stole my dog!")
