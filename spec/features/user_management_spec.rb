feature 'User Management Feature:' do
  scenario 'A new user can be created' do
    expect{sign_up}.to change(User, :count)
  end

  scenario "Can't sign up when password and confirmation don't match" do
    expect{sign_up(password_confirmation: 'wrong password')}.not_to change(User, :count)
    expect(page).to have_content 'Password does not match the confirmation'
  end

  scenario "Can't sign up with an incorrect email format" do
    expect{sign_up(email: 'testing.com')}.not_to change(User, :count)
  end

  context 'when an account is created' do
    before do
      sign_up
    end

    scenario 'the user is directed to the spaces page'do
    expect(current_path).to eq "/spaces"
    end

    scenario "Can't sign up when email is already in use" do
      expect{sign_up}.not_to change(User, :count)
      expect(page).to have_content 'Email is already taken'
    end

    scenario "Can't sign up when username is already in use" do
      expect{sign_up(email: 'testing2@doubletests.com')}.not_to change(User, :count)
      expect(page).to have_content 'Username is already taken'
    end

    scenario "User is greeted after signing up" do
      expect(page).to have_content 'Welcome, John Smith'
    end

    context 'and the user is signed out' do
      before do
        click_button "Sign Out"
      end

      scenario "User can sign in with correct details" do
        sign_in
        expect(page).to have_content "Welcome, John Smith"
      end

      scenario "User can't sign in with incorrect details" do
        sign_in(password: 'wrong password')
        expect(page).to have_content 'The email or password is incorrect'
      end
    end

    scenario "User can sign out" do
      click_button "Sign Out"
      expect(page).not_to have_content "Welcome, John Smith"
      expect(page).to have_content "See you later, John Smith"
    end
  end

end
