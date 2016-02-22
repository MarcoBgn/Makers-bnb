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
end