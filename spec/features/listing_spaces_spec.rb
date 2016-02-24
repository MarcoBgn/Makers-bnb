
feature 'listing spaces' do

  before do
    sign_up
  end

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
    expect(page).to have_content('A beautiful relaxing space')
  end

  scenario 'I can add a price for my space' do
    list_space
    expect(page).to have_content('£5 per night')
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
