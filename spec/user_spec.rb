describe User do
  let!(:user) do
    User.create(email: "test@test.co.uk",
                password: "secret",
                password_confirmation: "secret",
                name: "John Smith",
                username: "User123")
  end

  it "Has an email field" do
    expect(user.email).to eq "test@test.co.uk"
  end

  it "Has a name field" do
    expect(user.name).to eq "John Smith"
  end

  it "Has a username field" do
    expect(user.username).to eq "User123"
  end

end
