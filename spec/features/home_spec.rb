require 'spec_helper.rb'

describe 'Home', :type => :feature do
  it 'responds with successful status' do
    visit '/'
    expect(page.status_code).to eq(200)
  end
  
  it 'click in the button purchase in /form' do
  	visit '/'
  	click_on('buy_tickets')
  	expect(page.status_code).to eq(200)
  	expect(page).to have_content('Book your tickets:')
  end
  
  it 'film form in /form' do
  	visit '/'
  	click_on('buy_tickets')
  	expect(page.status_code).to eq(200)
  	expect(page).to have_content('Book your tickets:')
  	fill_in('name', :with => 'Camilo')
  	fill_in('lastname', :with => 'Ruiz')
  	fill_in('mail', :with => 'camilorojas@esquemacreativo.com')
  	select('Inside Out', :from => 'list_films')
  	click_on('send')
  	expect(page.status_code).to eq(200)
  	expect(page).to have_content('Hello Camilo Ruiz, your ticket to Inside Out It was successfully generated, you will soon receive an email with the details of your purchase')
  end
end