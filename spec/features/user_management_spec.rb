
feature 'User Management Feature:' do
  
  scenario 'A new user can be created' do
    visit '/'
    fill_in :email, with: 'test@ymail.com'
    fill_in :password, with: "s£cr3t"
    fill_in :password_confirmation, with: "s£cr3t"
    fill_in :name, with: "John Smith"
    fill_in :username, with: "user123"
    expect{click_button "Sign Up"}.to change(User, :count)
  end
end