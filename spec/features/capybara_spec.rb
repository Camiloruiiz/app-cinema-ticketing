require 'spec_helper.rb'

describe 'Front-end ticketing Cinema', :type => :feature do

  it 'responds with Home page' do
    visit '/' #Arrange
    #Act
    expect(page).to have_title "Cinelandia" #Assert
  end

  it 'click in the button purchase and film form' do
  	visit '/' #Arrange
    Pony.override_options = { :via => :test }

  	click_on('buy_tickets') #Act

    #Act
  	fill_in('name', :with => 'Camilo')
  	fill_in('lastname', :with => 'Ruiz')
  	fill_in('mail', :with => 'camilorojas@esquemacreativo.com')
  	select('Sin City', :from => 'list_films')
  	click_on('send')

  	#Assert
  	expect(page).to have_title "Confirmation"
  	expect(page).to have_content('Hello Camilo Ruiz, your ticket to Sin City It was successfully generated, you will soon receive an email with the details of your purchase.')
  end
end
