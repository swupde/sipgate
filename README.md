# Sipgate Ruby Gem

A Ruby interface for the [Sipgate API](https://developer.sipgate.io/), providing easy access to Sipgate's VoIP and telecommunications services. This gem allows you to manage users, send faxes, access call history, and interact with faxlines programmatically.

> [!NOTE]
> This gem uses PAT (Personal Access Token) for authentication.

## Features

- **User Management**: Retrieve and manage Sipgate users
- **Fax Services**: Send faxes programmatically
- **Call History**: Access call and communication history
- **Faxline Management**: Manage faxlines and their configurations

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sipgate', git: 'https://github.com/swupde/sipgate.git'
```

And then execute:
```bash
$ bundle install
```

### Validating Installation

To verify the gem is installed correctly:

```ruby
require 'sipgate'
puts Sipgate::VERSION  # Should output: 0.2.1
```

**Note**: There is an older version (0.1.2) available on RubyGems.org, but this repository contains the newer version (0.2.1) with additional features and improvements.

## Configuration

Create an initializer file `config/initializers/sipgate.rb` (for Rails applications) or configure directly:

```ruby
Sipgate.configure do |config|
  config.username = 'your_sipgate_username'
  config.password = 'your_sipgate_password'
  config.faxline_id = 'your_faxline_id' # optional, for fax operations
  config.user_id = 'your_user_id' # optional, defaults to first user
end
```

## Usage

### User Management

```ruby
# Get all users
users = Sipgate::User.all

# Get the first user
first_user = users.first
puts "#{first_user.firstname} #{first_user.lastname} (#{first_user.email})"

# Check if user is admin
puts "Admin: #{first_user.admin}"
```

### Sending Faxes

```ruby
# Send a fax
fax = Sipgate::Fax.new
result = fax.send_fax(
  recipient: '+49123456789',
  filename: 'path/to/document.pdf'
)
```

### Accessing History

```ruby
# Get call/communication history
history = Sipgate::History.all
history.each do |entry|
  puts "#{entry.type}: #{entry.source} -> #{entry.target} at #{entry.created}"
end
```

### Faxline Management

```ruby
# Get faxlines
faxlines = Sipgate::Faxline.all
faxlines.each do |faxline|
  puts "Faxline: #{faxline.id} - #{faxline.alias}"
end
```

## API Reference

This gem provides Ruby classes that correspond to Sipgate API resources:

- `Sipgate::User` - User management and information
- `Sipgate::Fax` - Fax sending and management
- `Sipgate::History` - Communication history access
- `Sipgate::Faxline` - Faxline configuration and management

## Requirements

- Ruby 2.3+
- Active Sipgate account with API access
- Faraday gem for HTTP requests

## Development

After checking out the repo, run:

```bash
bundle install
```

To run tests:

```bash
rake test
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
