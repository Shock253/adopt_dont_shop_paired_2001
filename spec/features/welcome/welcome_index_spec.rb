require 'rails_helper'

RSpec.describe "welcome index page", type: :feature do
  it "can link to Shelters page" do
    visit "/"
    expect(page).to have_content("Welcome to Adopt Don't Shop")
    click_link "All Shelters"
    expect(page).to have_current_path("/shelters")
  end

  it "can link to Pets page" do
    visit "/"
    expect(page).to have_content("Welcome to Adopt Don't Shop")
    click_link "All Pets"
    expect(page).to have_current_path("/pets")
  end
end
