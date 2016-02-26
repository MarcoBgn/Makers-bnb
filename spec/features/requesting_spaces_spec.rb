feature 'Requesting spaces' do
  before do
    sign_up
    list_space
  end

  scenario 'users can request to book spaces' do
    first(".list").click_link("space")
    fill_in :request_date, with: Date.today.next_day.strftime
    expect{click_button 'Request booking'}.to change(Request, :count)
    expect(page).to have_content 'Booking requested'
  end

  scenario 'users can see a list of requests made by other users' do
    click_button('Sign Out')
    sign_up(email: 'email@email.com', username: 'username')
    click_link('Space')
    first(".list").click_link("space")
    fill_in :request_date, with: Date.today.next_day.strftime
    click_button "Request booking"
    expect(page).to have_content "Booking requested"
    click_button("Requests")
    expect(page).to have_content "Requested for: #{Date.today.next_day.strftime}"
  end

  scenario "Can't request a space without logging in"do
    click_button('Sign Out')
    first(".list").click_link("space")
    fill_in :request_date, with: Date.today.next_day.strftime
    click_button "Request booking"
    expect(page).to have_content 'Please log in to request a space'
  end
  scenario "Can't request a space except on available dates" do
    first(".list").click_link("space")
    fill_in :request_date, with: Date.today.next_month(2).strftime
    click_button "Request booking"
    expect(page).to have_content 'Space not available on the requested date'
  end

end
