feature 'Editing spaces' do

  before do
    sign_up
    list_space
  end

  scenario 'space name can be editied after created' do
    visit '/users/account'
    expect(page).to have_content 'A beautiful relaxing space'
    first(".list").click_link("space")
    fill_in :name, with: 'My updated space'
    click_button 'Update Space'
    expect(page).not_to have_content 'A beautiful relaxing space'
    expect(page).to have_content 'My updated space'
  end

  scenario 'space name can be editied after created' do
    visit '/users/account'
    expect(page).to have_content 'It is yellow'
    first(".list").click_link("space")
    fill_in :description, with: 'Oh!'
    click_button 'Update Space'
    expect(page).not_to have_content 'It is yellow'
    expect(page).to have_content 'Oh!'
  end

  scenario 'space name can be editied after created' do
    visit '/users/account'
    expect(page).to have_content '£5 per night'
    first(".list").click_link("space")
    fill_in :price, with: '10000'
    click_button 'Update Space'
    expect(page).not_to have_content '£5 per night'
    expect(page).to have_content '£10000 per night'
  end



  scenario "can't edit spaces you don't own"do
    click_button 'Sign Out'
    sign_up(email: 'seconduser@email.com', username: 'seconduser')
    visit '/edit/1'
    expect(page).to have_xpath('//users/account')
  end

end
