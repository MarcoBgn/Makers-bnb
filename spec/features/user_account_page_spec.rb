feature 'User account' do

  scenario "displays default message when no spaces have been listed"do
    sign_up_2
    click_button 'Account'
    expect(page).to have_content 'You currently have no spaces listed'
  end

  before do
    create_other_space
    sign_up
    list_space
  end

  scenario "shows spaces you own on account page" do
    click_button 'Account'
    expect(page).to have_content 'A beautiful relaxing space'
    expect(page).not_to have_content 'A terrible space'
  end

  scenario "redirects you to sign in page if not signed in" do
    click_button 'Sign Out'
    visit '/users/account'
    expect(current_path).to eq '/sessions/new'
  end

end
