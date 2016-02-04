require 'spec_helper.rb'

describe 'Home', :type => :feature do
  it 'responds with successful status' do
    visit '/'
    expect(page.status_code).to eq(200)
  end
end