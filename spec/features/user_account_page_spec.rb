feature 'User account' do

  before do
    create_other_space
    sign_up
    list_space
  end

  scenario "shows spaces you own on account page" do
    visit '/users/account'
    expect(page).to have_content 'A beautiful relaxing space'
    expect(page).not_to have_content 'A terrible space'
  end

end
