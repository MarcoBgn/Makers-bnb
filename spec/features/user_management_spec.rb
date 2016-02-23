feature 'User Management Feature:' do
  scenario 'A new user can be created' do
    expect{sign_up}.to change(User, :count)
  end

  scenario "Can't sign up when password and confirmation don't match" do
    expect{sign_up(password_confirmation: 'wrong password')}.not_to change(User, :count)
    expect(page).to have_content 'Password does not match the confirmation'
  end

  scenario "Can't sign up when email is already in use" do
    sign_up
    expect{sign_up}.not_to change(User, :count)
    expect(page).to have_content 'Email is already taken'
  end

  scenario "Can't sign up when username is already in use" do
    sign_up
    expect{sign_up(email: 'testing2@doubletests.com')}.not_to change(User, :count)
    expect(page).to have_content 'Username is already taken'
  end

  scenario "User is greeted after signing up" do
    sign_up
    expect(page).to have_content 'Welcome, John Smith'
  end
  
  scenario "User can sign in" do
    sign_up
    click_button "Sign Out"
    click_button "Login"
    fill_in :email, with: 'test@ymail.com'
    fill_in :password, with: 's£cr3t'
    click_button 'Login'
    expect(page).to have_content "Welcome, John Smith"
  end
  
  
  scenario "User can sign out" do
    sign_up
    click_button "Sign Out"
    expect(page).not_to have_content "Welcome, John Smith"
    expect(page).to have_content "See you later, John Smith"
  end
  
  
end
