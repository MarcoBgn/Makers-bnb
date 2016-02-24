feature 'listing spaces' do

  scenario 'I can name a space' do
    list_space
    expect(page).to have_content('A beautiful relaxing space')
    expect(page).to have_content('It is yellow')
    expect(page).to have_content('£5 per night')
  end

  scenario 'I can list multiple spaces' do
    list_space
    list_space(name: 'A horrible stressful space')
    expect(page).to have_content('A beautiful relaxing space')
    expect(page).to have_content('A horrible stressful space')
  end

  scenario 'I can add description of my space' do
    list_space
    expect(page).to have_content('It is yellow')
    expect(page).to have_content('£5 per night')
  end

  scenario 'I can add a price for my space' do
    list_space
    expect(page).to have_content('£5 per night')
  end

  scenario 'I can add available dates to the listing' do
    list_space
    expect(page).to have_content('2016-07-01')
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

  scenario 'cannot enter available from date before today' do
    expect{list_space(available_from: Date.today.prev_day)}.not_to change(Space, :count)
    expect(page).to have_content('do not enter a date before today')
  end

  scenario 'cannot enter available to date before today' do
    expect{list_space(available_to: Date.today.prev_day)}.not_to change(Space, :count)
    expect(page).to have_content('do not enter a date before today')
  end

  scenario 'cannot enter unrecognizable available from date' do
    expect{list_space(available_from: 'crazy string')}.not_to change(Space, :count)
    expect(page).to have_content('Please complete the required fields')
  end

  scenario 'cannot enter unrecognizable available to date' do
    expect{list_space(available_to: 'crazy string')}.not_to change(Space, :count)
    expect(page).to have_content('Please complete the required fields')
  end
end
