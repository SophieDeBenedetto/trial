# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#species constant
SPECIES = ["barnyard", "bird", "cat", "dog", "horse", "pig", "reptile", "smallfurry"]
ZIPCODES = [10001, 10002, 10003, 10004, 10005, 10006, 10007, 10009, 10010, 10011, 10012, 10013, 10014, 10016, 10017, 10018, 10019, 10020, 10021, 10022, 10023, 10024, 10025, 10026, 10027, 10028, 10029, 10030, 10031, 10032, 10033, 10034, 10035, 10036, 10037, 10038, 10039, 10040, 10044, 10065, 10069, 10075, 10103, 10110, 10111, 10112, 10115, 10119, 10128, 10152, 10153, 10154, 10162, 10165, 10167, 10168, 10169, 10170, 10171, 10172, 10173, 10174, 10177, 10199, 10271, 10278, 10279, 10280, 10282, 10301, 10302, 10303, 10304, 10305, 10306, 10307, 10308, 10309, 10310, 10311, 10312, 10314, 10451, 10452, 10453, 10454, 10455, 10456, 10457, 10458, 10459, 10460, 10461, 10462, 10463, 10464, 10465, 10466, 10467, 10468, 10469, 10470, 10471, 10472, 10473, 10474, 10475, 11004, 11005, 11101, 11102, 11103, 11104, 11105, 11106, 11109, 11201, 11203, 11204, 11205, 11206, 11207, 11208, 11209, 11210, 11211, 11212, 11213, 11214, 11215, 11216, 11217, 11218, 11219, 11220, 11221, 11222, 11223, 11224, 11225, 11226, 11228, 11229, 11230, 11231, 11232, 11233, 11234, 11235, 11236, 11237, 11238, 11239, 11351, 11354, 11355, 11356, 11357, 11358, 11359, 11360, 11361, 11362, 11363, 11364, 11365, 11366, 11367, 11368, 11369, 11370, 11371, 11372, 11373, 11374, 11375, 11377, 11378, 11379, 11385, 11411, 11412, 11413, 11414, 11415, 11416, 11417, 11418, 11419, 11420, 11421, 11422, 11423, 11424, 11425, 11426, 11427, 11428, 11429, 11430, 11432, 11433, 11434, 11435, 11436, 11451, 11691, 11692, 11693, 11694, 11697]


#species zipcode

PETFINDER = Petfinder::Client.new('bf43919be64d0ffed94aa9fa2acfd9d0', '11f2621e8fac20123e25a1807f0e61fe')

PETFINDER.find_pets(SPECIES.sample, ZIPCODES.sample, count: 50).each do |pf|
  # binding.pry
  pet = Pet.find_or_create_by(species: pf.animal, name: pf.name, size: pf.size, sex: pf.sex, age: pf.age, description: pf.description)
  pf.breeds.each do |breed|
    pet.breeds << Breed.find_or_create_by(name: breed)
  end
  pf.photos.each do |photo|
    if !photo.medium.empty? || !photo.medium.nil?
      pet.picture = photo.medium
    else
      pet.picture = '/Users/cyrusghazanfar/Desktop/trial/app/assets/images/default_pet.jpg'
    end
  end
  pf_shelter = PETFINDER.shelter(pf.shelter_id)
  shelter = Shelter.find_or_create_by(name:pf_shelter.name, email: pf_shelter.email, phone: pf_shelter.phone, state: pf_shelter.state, city: pf_shelter.city, zip: pf_shelter.zip)
  pet.zip_code = shelter.zip
  shelter.save
  pet.shelter_id = shelter.id
  pet.save
  # binding.pry
end

# PETFINDER.find_pets('cat', 10013)
