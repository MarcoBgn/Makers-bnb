require 'spec_helper'

feature 'listing spaces' do
  # As a Signed In User,
  # so I can promote my spaces,
  # I would like to list a new space
  scenario 'I can list a new space' do
    visit('/spaces')
    click_button 'List a Space'
    click_button 'List my Space'
    expect(page.status_code).to eq(200)
  end

  # As a User,
  # so I can distinguish my spaces,
  # I would like to be able to name them
  scenario 'I can name a space' do
    list_space
    expect(page).to have_content('A beautiful relaxing space')
  end

  # As a Signed in User
  # So I can list all my spaces,
  # I would like to be able to add multiple spaces
  scenario 'I can list multiple spaces' do
    list_space
    list_space(name: 'A horrible stressful space')
    expect(page).to have_content('A beautiful relaxing space')
    expect(page).to have_content('A horrible stressful space')
  end

  # As a user,
  # so the subject of my spaces is clear,
  # I would like to be able to add a description of my space
  scenario 'I can add description of my space' do
    list_space
    expect(page).to have_content('It is yellow')
  end

  # As a user,
  # so I can correctly advertise my spaces,
  # I would like to be able to list the price my space costs per night
  scenario 'I can add a price for my space' do
    list_space
    expect(page).to have_content('£5 per night')
  end

  # As a User,
  # so that I can list the space when I want,
  # I would like to be able to add available dates to the listing
  scenario 'I can add available dates to the listing' do
    list_space
    expect(page).to have_content('2016-01-01')
    expect(page).to have_content('2016-08-01')
  end

  scenario "the name field cannot be left empty"do
    expect{list_space(name: nil)}.not_to change(Space, :count)
    expect(page).to have_content('Please complete the required fields')
  end

  scenario "the price field cannot be left empty"do
    expect{list_space(price: nil)}.not_to change(Space, :count)
    expect(page).to have_content('Please complete the required fields')
  end

  scenario "the available_from field cannot be left empty"do
    expect{list_space(available_from: nil)}.not_to change(Space, :count)
    expect(page).to have_content('Please complete the required fields')
  end
  scenario "the available_to field cannot be left empty"do
    expect{list_space(available_to: nil)}.not_to change(Space, :count)
    expect(page).to have_content('Please complete the required fields')
  end
end
