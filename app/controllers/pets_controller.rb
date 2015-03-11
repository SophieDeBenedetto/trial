class PetsController < ApplicationController

  PETFINDER = Petfinder::Client.new('bf43919be64d0ffed94aa9fa2acfd9d0', '11f2621e8fac20123e25a1807f0e61fe')

  def search #lets set this up in route so it appears :as => "search"
    @pet = Pet.new
    #send form data in params to create
  end

  def results
  end


  def destroy_shelters
    Shelter.destroy_all
  end

  def results

    @animals = Pet.all
    @animals.collect do |animal|
      animal.shelter_name = Shelter.find_or_create_by(name: PETFINDER.shelter(animal.shelter_id).name, email: PETFINDER.shelter(animal.shelter_id).email, phone: PETFINDER.shelter(animal.shelter_id).phone, city: PETFINDER.shelter(animal.shelter_id).city, zip: PETFINDER.shelter(animal.shelter_id).zip).name
      animal.save
    end
  end

  # def create

  def create
    # binding.pry
    #redirect to results
  end

  #   Pet.destroy_all
  #    @pets = PETFINDER.find_pets(pet_finder_type, pet_finder_zip, count: 500)
  #    if params['pets']['breed'].empty?
  #     @selected_animals = @pets.select do |pet|
  #       pet.age == params['pets']['age']  &&
  #       pet.size == params['pets']['size'] &&
  #       pet.sex == params['pets']['sex']
  #     end
  #   else
  #     @selected_animals = @pets.select do |pet|
  #       pet.age == params['pets']['age']  &&
  #       pet.size == params['pets']['size'] &&
  #       pet.sex == params['pets']['sex'] &&
  #       pet.breeds.include?(params['pets']['breeds'])
  #     end
  #   end



  #     @selected_animals.each do |selected_animal|
  #       @desired_pet = Pet.create(name: selected_animal.name)
  #       @desired_pet.age = selected_animal.age
  #       @desired_pet.size = selected_animal.size
  #       @desired_pet.sex = selected_animal.sex
  #       @desired_pet.breed = selected_animal.breeds
  #       @desired_pet.picture = selected_animal.photos.first.medium
  #       @desired_pet.description = selected_animal.description
  #       @desired_pet.shelter_id = selected_animal.shelter_id
  #       @desired_pet.last_update = selected_animal.last_update
  #       @desired_pet.save
  #     end
  #   binding.pry
  # end

  def destroy_pets
    Pet.destroy_all
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def clean_params
      params['pets']['count'] = 25
      params['pets'].delete_if {|key, value| value == ""}
      # binding.pry
    end

    def pet_finder_type
      params[:pets_search][:type]
    end


    def pet_finder_zip
      params[:pets_search][:zip]
    end
end
