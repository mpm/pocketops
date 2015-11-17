namespace :pops do
  task 'setup' do
    pw = Pocketops.config.generate_user_password
    puts "Created user account 'rails' with password '#{pw}'."
    puts "Store this password somewhere, you need it to run sudo"
    Pocketops.ansible.execute('bootstrap') &&
    Pocketops.ansible.execute('site')
  end

  task 'deploy' do
    Pocketops.ansible.execute('deploy')
  end

  task 'inventory' do
    inventory = Pocketops::Inventory.new(Pocketops.config.hosts)
    puts inventory.to_json
  end
end
