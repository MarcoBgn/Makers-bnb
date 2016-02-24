describe Request do

  let!(:request) do
    Request.create(user_id: 1, space_id: 2)
  end

  it 'has a requesting user id' do
    expect(request.user_id).to eq 1
  end

  it 'has a space id' do
    expect(request.space_id).to eq 2
  end
end
