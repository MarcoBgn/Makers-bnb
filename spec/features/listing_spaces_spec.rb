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
end
