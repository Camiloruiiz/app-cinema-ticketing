
require_relative '../../app/basic'
require 'spec_helper.rb'

describe 'Home', :type => :feature do
  it 'responds with successful status' do
    visit '/'
    page.status_code.should == 200
  end
end