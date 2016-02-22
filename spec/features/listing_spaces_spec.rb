require 'spec_helper'

# As a Signed In User,
# so I can promote my spaces,
# I would like to list a new space
feature 'listing spaces' do
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
end
