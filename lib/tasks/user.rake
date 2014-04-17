namespace :user do
  desc "Create a new user (args: NAME and EMAIL)"
  task add: :environment do
    full_name = ENV["NAME"]
    email = ENV["EMAIL"]
    if full_name
      first_name = full_name.split[0]
      last_name = full_name.split[1]
    end

    puts "Adding user '#{full_name}' with email address '#{email}'..."
    new_user = User.new(
      first_name: first_name,
      last_name: last_name,
      email: email
    )
    password = Digest::SHA1.hexdigest([Time.now, rand].join)[0..10]
    new_user.password = new_user.password_confirmation = password
    if new_user.save
      puts "User has been created:"
      puts "  First Name: #{first_name}"
      puts "  Last Name: #{last_name}"
      puts "  Email Address: #{email}"
      puts "  Password: #{password}"
    else
      puts "Cannot create the user:"
      new_user.errors.full_messages.each do |msg|
        puts "* #{msg}"
      end
    end
  end

end
