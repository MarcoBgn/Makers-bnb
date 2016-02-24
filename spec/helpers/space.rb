module SpaceHelpers
  def list_space(name: 'A beautiful relaxing space',
                 description: 'It is yellow',
                 price: '5',
                 available_from: '2016-07-01',
                 available_to: '2016-08-01')
    visit('/spaces/new')
    fill_in('name', :with => name)
    fill_in('description', :with => description)
    fill_in('price', :with => price)
    fill_in('available_from', :with => available_from)
    fill_in('available_to', :with => available_to)
    click_button 'List my Space'
  end
end