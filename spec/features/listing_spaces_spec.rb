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
    visit('/spaces/new')
    fill_in('name', :with => 'A beautiful relaxing space')
    click_button 'List my Space'
    expect(page).to have_content('A beautiful relaxing space')
  end

  # As a Signed in User
  # So I can list all my spaces,
  # I would like to be able to add multiple spaces
  scenario 'I can list multiple spaces' do
    visit('/spaces/new')
    fill_in('name', :with => 'A beautiful relaxing space')
    click_button 'List my Space'
    visit('/spaces/new')
    fill_in('name', :with => 'A horrible stressful space')
    click_button 'List my Space'
    expect(page).to have_content('A beautiful relaxing space')
    expect(page).to have_content('A horrible stressful space')
  end

  # As a user,
  # so the subject of my spaces is clear,
  # I would like to be able to add a description of my space
  scenario 'I can add description of my space' do
    visit('/spaces/new')
    fill_in('description', :with => 'It is yellow')
    click_button 'List my Space'
    expect(page).to have_content('It is yellow')
  end

  # As a user,
  # so I can correctly advertise my spaces,
  # I would like to be able to list the price my space costs per night
  scenario 'I can add a price for my space' do
    visit('/spaces/new')
    fill_in('price', :with => '5')
    click_button 'List my Space'
    expect(page).to have_content('£5 per night')
  end

  # As a User,
  # so that I can list the space when I want,
  # I would like to be able to add available dates to the listing
  scenario 'I can add available dates to the listing' do
    visit('/spaces/new')
    fill_in('available_from', :with => '2016-01-01')
    fill_in('available_to', :with => '2016-08-01')
    click_button 'List my Space'
    expect(page).to have_content('2016-01-01')
    expect(page).to have_content('2016-08-01')
  end
end
