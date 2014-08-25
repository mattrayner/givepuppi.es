# Create all of the users we want within the application
def add_users
  puts 'Creating Users...'
  user = User.create( firstname: 'Matt',
                surname: 'Rayner',
                email: 'matt@givepuppi.es',
                password: 'password',
                admin: true ) unless User.all.count > 0

  if User.last == user
    puts '  User created with email \'matt@givepuppi.es\''
  else
    puts '  Error - User was not added to the database. There may already be users present.'
  end
end

def create_puppies
  puts 'Creating Puppies...'

  # Are there already puppies in the DB? (don't want to duplicate)
  if Puppy.all.count > 0
    puts '  Error - Puppies already exist in the database. You should only seed once or you\'ll get duplicates.'
    return nil
  end

  puts '  Getting puppies to be seeded...'
  puppy_files = Dir["db/seed_puppies/*"]

  puts '  Creating puppy objects...'
  puppy_files.each do |puppy_file|
    puts "    Building puppy for #{puppy_file}"

    file = Rails.root.join(puppy_file)
    puppy = Puppy.new( image: File.open( file ) )
    puppy.orientation = puppy.get_orientation_of_image
    puppy.save

    if puppy.new_record?
      puts '      Unable to create puppy, please try again or contact administrator.'
    else
      puts '      OK'
    end
  end

  puts "  Created #{Puppy.all.count} puppies."
end

add_users
create_puppies