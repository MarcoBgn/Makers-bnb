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
    click_button('Sign Out')
    sign_in
    click_button("Requests")
    expect(page).to have_content "Request for 'A Beautiful Relaxing Space'"
  end

end
