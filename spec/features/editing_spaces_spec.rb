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
    expect(page).to have_content 'My updated space'
  end

end
