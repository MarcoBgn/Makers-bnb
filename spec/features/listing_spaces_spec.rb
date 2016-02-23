
feature 'listing spaces' do

  scenario 'I can put name, price and description to a space' do
    create_space
    expect(page).to have_content('A beautiful relaxing space')
    expect(page).to have_content('It is yellow')
    expect(page).to have_content('£5 per night')
  end

  
  scenario 'I can list multiple spaces' do
    create_space
    create_space(name: 'A horrible stressful space', price: '10')
    expect(page).to have_content('A beautiful relaxing space')
    expect(page).to have_content('It is yellow')
    expect(page).to have_content('£5 per night')
    expect(page).to have_content('£10 per night')
    expect(page).to have_content('A horrible stressful space')
  end
  
  scenario 'I can\'t list spaces without a name' do
    visit('/spaces/new')
    fill_in 'price', :with => '6'
    fill_in 'description', :with => 'random text here' 
    expect{ click_button 'List my Space' }.not_to change(Space, :count)
  end

end
