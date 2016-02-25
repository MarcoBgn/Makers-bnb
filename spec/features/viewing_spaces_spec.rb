feature 'Viewing links:' do

  before do
    sign_up
  end

  scenario 'Click on a space and view its details' do
    list_space
    first(".list").click_link("space")
    expect(page).to have_content "Pick a night:"
    expect(page).to have_content 'A beautiful relaxing space'
  end
end
