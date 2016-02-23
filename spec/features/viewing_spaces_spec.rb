feature 'Viewing links:' do
  
  scenario 'Click on a space and view its details' do
    create_space
    first(".list").click_link("space")
    expect(page).to have_content "Pick a Night:"
    expect(page).to have_content 'A beautiful relaxing space'
  end
end