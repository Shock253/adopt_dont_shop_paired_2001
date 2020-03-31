require "rails_helper"

RSpec.describe "Application show page" do
  before :each do
    Shelter.destroy_all
    Pet.destroy_all
    @shelter_1 = Shelter.create!(name: "Denver Animal Shelter",
                              address: "500 Invisible St.",
                              city: "Denver",
                              state: "Colorado",
                              zip: "80201")

    @pet_1 = Pet.create(image: 'app/assets/images/border_collie.jpg',
                    name: 'Rover',
                    age: 3,
                    sex: "Male",
                    shelter: @shelter_1,
                    description: "He's a biter.",
                    status: "adoptable")

    @pet_2 = Pet.create(image: 'app/assets/images/border_collie.jpg',
                    name: 'George',
                    age: 3,
                    sex: "Male",
                    shelter: @shelter_1,
                    description: "He's a biter.",
                    status: "adoptable")

    @application = Application.create(
                    name: "John Wick",
                    address: "450 S. Cherry St.",
                    city: "Aldoran",
                    state: "CO",
                    zip: "19999",
                    phone_number: "8007891234",
                    description: "I have a big yard")

    ApplicationPet.create(application: @application, pet: @pet_1)
    ApplicationPet.create(application: @application, pet: @pet_2)

  end

  it "has application info displayed" do
    visit "/applications/#{@application.id}"

    expect(page).to have_content("John Wick")
    expect(page).to have_content("450 S. Cherry St.")
    expect(page).to have_content("Aldoran")
    expect(page).to have_content("CO")
    expect(page).to have_content("19999")
    expect(page).to have_content("8007891234")
    expect(page).to have_content("I have a big yard")

    within "#pet-#{@pet_1.id}" do
      click_link "Rover"
      expect(page).to have_current_path("/pets/#{@pet_1.id}")
    end
    visit "/applications/#{@application.id}"

    within "#pet-#{@pet_2.id}" do
      click_link "George"
      expect(page).to have_current_path("/pets/#{@pet_2.id}")
    end
  end

  it "can approve pet applications" do
    visit "/applications/#{@application.id}"

    within "#pet-#{@pet_1.id}" do
      click_link "Approve #{@pet_1.name} for Adoption"
    end

    expect(page).to have_current_path("/pets/#{@pet_1.id}")

    expect(page).to have_content("Pending Adoption")
    expect(page).to have_content("John Wick")
  end

  it "can approve all pets in an application" do
    visit "/applications/#{@application.id}"

    within "#check-box-#{@pet_1.id}" do
      check "pet_ids_"
    end

    within "#check-box-#{@pet_2.id}" do
      check "pet_ids_"
    end

    click_button "Approve Pets"
    expect(page).to have_current_path("/pets")

    visit "/pets/#{@pet_1.id}"
    expect(page).to have_content("Pending Adoption")
    expect(page).to have_content("John Wick")

    visit "/pets/#{@pet_2.id}"
    expect(page).to have_content("Pending Adoption")
    expect(page).to have_content("John Wick")
  end

  it "can not approve the same pet for multiple applications" do
    application_2 = Application.create(
                    name: "Luke Skywalker",
                    address: "450 S. Cherry St.",
                    city: "Aldoran",
                    state: "CO",
                    zip: "19999",
                    phone_number: "8007891234",
                    description: "I have a big yard")

    ApplicationPet.create(application: application_2, pet: @pet_1)

    visit "/applications/#{@application.id}"
    within "#pet-#{@pet_1.id}" do
      click_link "Approve #{@pet_1.name} for Adoption"
    end

    visit "/applications/#{application_2.id}"

    within "#pet-#{@pet_1.id}" do
      expect(page).to_not have_link("Approve #{@pet_1.name}")
      expect(page).to have_content("#{@pet_1.name} is currently pending adoption.")
    end

    click_button "Approve Pets"
    expect(page).to have_current_path("/applications/#{application_2.id}")
    expect(page).to have_content("There are currently no pets selected for approval to adopt!")
  end

  it "can revoke applications for a pet that has been approved" do
    application_2 = Application.create(
                    name: "Luke Skywalker",
                    address: "450 S. Cherry St.",
                    city: "Aldoran",
                    state: "CO",
                    zip: "19999",
                    phone_number: "8007891234",
                    description: "I have a big yard")

    ApplicationPet.create(application: application_2, pet: @pet_1)

    visit "/applications/#{@application.id}"
    within "#pet-#{@pet_1.id}" do
      click_link "Approve #{@pet_1.name} for Adoption"
    end

    visit "/applications/#{application_2.id}"
    within "#pet-#{@pet_1.id}" do
      expect(page).to_not have_link("Revoke #{@pet_1.name}'s Application")
    end

    visit "/applications/#{@application.id}"
    within "#pet-#{@pet_1.id}" do
      click_link "Revoke #{@pet_1.name}'s Application"
    end

    expect(page).to have_current_path("/applications/#{@application.id}")

    within "#pet-#{@pet_1.id}" do
      expect(page).to have_link("Approve #{@pet_1.name} for Adoption")
    end

    visit "/pets/#{@pet_1.id}"
    expect(page).to_not have_content("Pending Adoption")
    expect(page).to have_content("Adoptable")
  end
end
