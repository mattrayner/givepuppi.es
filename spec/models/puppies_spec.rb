require 'rails_helper'

RSpec.describe Puppy do
  before :each do
    when_i_create_a_number_of_puppies
  end

  describe 'can search by orientation' do
    before :each do
      and_i_search_by_orientation
    end

    it '.horizonal' do
      there_are_five_horizontal_puppies
    end

    it '.vertical' do
      there_are_three_vertical_puppies
    end

    it '.square' do
      there_are_four_square_puppies
    end
  end

  describe 'can search by disabled status' do
    it '.disabled' do
      there_are_five_disabled_puppies
    end

    it '.enabled' do
      there_are_twelve_enabled_puppies
    end
  end
end

# Create a number of puppies for each of the orientations we can have.
#
# @author Matt Rayner
def when_i_create_a_number_of_puppies
  create_list :puppy, 5, orientation: 'hor'
  create_list :puppy, 3, orientation: 'ver'
  create_list :puppy, 4, orientation: 'squ'
  create_list :puppy, 5, disabled: true
end

# Get a collection of puppies for each of the orientations possible.
#
# @author Matt Rayner
def and_i_search_by_orientation
  @horizontal = Puppy.enabled.horizontal
  @vertical = Puppy.enabled.vertical
  @square = Puppy.enabled.square
end

# @author Matt Rayner
def there_are_five_horizontal_puppies
  expect(@horizontal.size).to eql 5
end

# @author Matt Rayner
def there_are_three_vertical_puppies
  expect(@vertical.size).to eql 3
end

# @author Matt Rayner
def there_are_four_square_puppies
  expect(@square.size).to eql 4
end

# Get a collection of disabled puppies and check the number
#
# @author Matt Rayner
def there_are_five_disabled_puppies
  expect(Puppy.disabled.size).to eql 5
end

# Get a collection of enabled puppies and check the number
#
# @author Matt Rayner
def there_are_twelve_enabled_puppies
  expect(Puppy.enabled.size).to eql 12
end