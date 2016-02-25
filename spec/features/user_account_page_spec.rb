feature 'User account' do

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

  scenario "shows requests made"do
  first(".list").click_link("space")
  fill_in :request_date, with: Date.today.strftime
  click_button 'Request booking'
  click_button 'Requests'
  expect(page).to have_content 'A terrible space'
  end

end
