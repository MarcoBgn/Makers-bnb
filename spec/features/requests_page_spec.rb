feature 'Requests' do

  before do
    create_other_space
    sign_up
    list_space
    first(".list").click_link("space")
    fill_in :request_date, with: Date.today.strftime
    click_button 'Request booking'
  end

  scenario "Can be approved by the owner" do
    click_button "Sign Out"
    sign_in(email: 'seconduser@email.com')
    click_button "Requests"
    click_link "request"
    expect(page).to have_content "Request for 'A terrible space'"
    expect(page).to have_content "From: test@ymail.com"
    expect(page).to have_content "No. of requests for this space: 1"
    expect(page).to have_selector(:link_or_button, 'Confirm request from: test@ymail.com')
    click_button "confirm_button"
    expect(page).to have_content("Request status: confirmed")
  end

  scenario "Can be denied by the owner" do
    click_button "Sign Out"
    sign_in(email: 'seconduser@email.com')
    click_button "Requests"
    click_link "request"
    expect(page).to have_content "Request for 'A terrible space'"
    expect(page).to have_content "From: test@ymail.com"
    expect(page).to have_content "No. of requests for this space: 1"
    expect(page).to have_selector(:link_or_button, 'Confirm request from: test@ymail.com')
    click_button "deny_button"
    expect(page).to have_content("Request status: denied")
  end

  let!(:request) do
    Request.first.id
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
    expect(page).to have_content Date.today.strftime
    expect(page).to have_content 'John Smith'
  end

  scenario "can click requests to view them" do
    click_button 'Sign Out'
    sign_in(email: 'seconduser@email.com')
    click_button 'Requests'
    first(".list").click_link("request")
    expect(current_path).to eq "/requests/confirm/#{request}"
  end
end
