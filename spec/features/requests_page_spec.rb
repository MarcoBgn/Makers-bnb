feature 'Requests' do

  before do
    create_other_space
    sign_up
    list_space
    first(".list").click_link("space")
    fill_in :request_date, with: Date.today.strftime
    click_button 'Request booking'
  end

  scenario "shows requests made" do
    click_button 'Requests'
    expect(page).to have_content 'A terrible space'
  end

  scenario "shows requests received" do
    click_button 'Sign Out'
    sign_in(email: 'seconduser@email.com')
    click_button 'Requests'
    expect(page).to have_content 'A terrible space'
  end

end
