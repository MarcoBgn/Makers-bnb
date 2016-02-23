require 'spec_helper'

feature 'filtering spaces by available dates' do
  scenario 'I can find a space by available dates' do
    list_space
    fill_in('available_from', :with => '2016/02/01')
    fill_in('available_to', :with => '2016/08/01')
    click_button 'List Spaces'
    expect(page).to have_content('A beautiful relaxing space')
  end
end