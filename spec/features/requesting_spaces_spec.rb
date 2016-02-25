feature 'Requesting spaces' do
  before do
    sign_up
    list_space
  end

  scenario 'users can request to book spaces' do
    first(".list").click_link("space")
    fill_in :request_date, with: '03/03/2016'
    expect{click_button 'Request booking'}.to change(Request, :count)
    expect(page).to have_content 'Booking requested'
  end
end
