def sign_up(email: 'test@ymail.com', password_confirmation: 's£cr3t', username: 'user123')
  visit '/'
  fill_in :email, with: email
  fill_in :password, with: "s£cr3t"
  fill_in :password_confirmation, with: password_confirmation
  fill_in :name, with: "John Smith"
  fill_in :username, with: username
  click_button 'Sign Up'
end

def sign_in(password: 's£cr3t')
  click_button "Login"
  fill_in :email, with: 'test@ymail.com'
  fill_in :password, with: password
  click_button 'Submit'
end
