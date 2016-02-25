  def sign_up(email: 'test@ymail.com', password_confirmation: 's£cr3t', username: 'user123')
    visit '/'
    fill_in :email, with: email
    fill_in :password, with: "s£cr3t"
    fill_in :password_confirmation, with: password_confirmation
    fill_in :name, with: "John Smith"
    fill_in :username, with: username
    click_button 'Create Account'
  end

  def sign_in(password: 's£cr3t')
    click_button "Login"
    fill_in :email, with: 'test@ymail.com'
    fill_in :password, with: password
    click_button 'Submit'
  end

  def list_space(name: 'A beautiful relaxing space',
                 description: 'It is yellow',
                 price: '5',
                 available_from: Date.today.strftime,
                 available_to: Date.today.next_month.strftime)
    visit('/spaces/new')
    fill_in('name', :with => name)
    fill_in('description', :with => description)
    fill_in('price', :with => price)
    fill_in('available_from', :with => available_from)
    fill_in('available_to', :with => available_to)
    click_button 'List my Space'
  end
