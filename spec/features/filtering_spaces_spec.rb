
feature 'filtering spaces by available dates' do

  before do
    sign_up
  end

  scenario 'I can find a space by available dates' do
    list_space
    fill_in('available_from', :with => '2016/07/10')
    fill_in('available_to', :with => '2016/08/01')
    click_button 'List Spaces'
    expect(page).to have_content('A beautiful relaxing space')
  end
  scenario "It doesn't show spaces that don't have required available dates" do
    list_space
    list_space(name: 'A space that will remain unseen', available_from: '2016-09-01', available_to: '2016-09-05')
    fill_in('available_from', :with => Date.today.strftime)
    fill_in('available_to', :with => Date.today.next_day.strftime)
    click_button 'List Spaces'
    expect(page).not_to have_content('A space that will remain unseen')
  end

  scenario "nothing is shown when there are no spaces with appropriate dates"do
  list_space(name: 'A space that will remain unseen', available_from: '2016-09-01', available_to: '2016-09-05')
  list_space(name: 'A space that will also remain unseen', available_from: '2016-10-01', available_to: '2016-11-01')
  fill_in('available_from', :with => '2016/07/10')
  fill_in('available_to', :with => '2016/08/01')
  click_button 'List Spaces'
  expect(page).to have_content('No spaces available for requested dates')

  end
  scenario "shows more than one space that has appropriate dates" do
    list_space(name: 'A space that will be seen', available_from: '2016-09-01', available_to: '2016-09-05')
    list_space(name: 'A space that will also be seen', available_from: '2016-09-03', available_to: '2016-09-07')
    fill_in('available_from', :with => '2016/09/01')
    fill_in('available_to', :with => '2016/09/05')
    click_button 'List Spaces'
    expect(page).to have_content('A space that will be seen')
    expect(page).to have_content('A space that will also be seen')
  end

  scenario 'cannot enter available from date before today' do
    visit('/spaces')
    fill_in('available_from', :with => Date.today.prev_day)
    fill_in('available_to', :with => Date.today)
    click_button 'List Spaces'
    expect(page).to have_content('do not enter a date before today')
  end

  scenario 'cannot enter available to date before today' do
    visit('/spaces')
    fill_in('available_from', :with => Date.today)
    fill_in('available_to', :with => Date.today.prev_day)
    click_button 'List Spaces'
    expect(page).to have_content('do not enter a date before today')
  end

  scenario 'cannot enter available to date before available from date' do
    visit('/spaces')
    fill_in('available_from', :with => Date.today.next_month)
    fill_in('available_to', :with => Date.today)
    click_button 'List Spaces'
    expect(page).to have_content('do not enter a start date that is after the finish date')
  end
end
