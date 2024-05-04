# app/services/fake_data_service.rb

require 'faker'
require 'digest'
require 'securerandom'

def generate_uuid_from_string(str)
  # Generate a MD5 hash of the string
  hash = Digest::MD5.hexdigest(str)

  # Convert the first 16 characters of the hash into UUID-like format
  uuid = "#{hash[0, 8]}-#{hash[8, 4]}-#{hash[12, 4]}-#{hash[16, 4]}"
  return uuid
end

def errorSimulator(input_string, error_value)
  num_corrupted_characters = [error_value, input_string.length].min

  # Create an array of unique random indices within the bounds of the input string
  indices = input_string.length.times.to_a.sample(num_corrupted_characters)

  indices.each do |index|
    # Select a random error type
    error_type = [:delete, :add, :swap].sample

    case error_type
    when :delete
      # Delete character at the selected index if within bounds
      input_string.slice!(index) if index < input_string.length
    when :add
      # Add a random character at the selected index if within bounds
      random_character = ('a'..'z').to_a.sample
      input_string.insert(index, random_character) if index <= input_string.length
    when :swap
      # Swap characters at the selected index and the next index if both within bounds
      next_index = index + 1
      if next_index < input_string.length
        input_string[index], input_string[next_index] = input_string[next_index], input_string[index]
      end
    end
  end

  return input_string
end

class FakeDataService
  COUNTRY_CODES = {
    'en-US' => '+1',
    'de' => '+49',
    'fe' => '+33'
  }
  def self.generate_data(seed, locale = 'en-US', error)
    Faker::Config.random = Random.new(seed)
    Faker::Config.locale = locale

    # Randomly select whether to include country code or not
    include_country_code = Random.new(seed).rand < 0.5

    # Generate a phone number with or without country code based on the include_country_code flag
    phone_number = if include_country_code
                     country_code = COUNTRY_CODES[locale]
                     "#{country_code} #{Faker::PhoneNumber.phone_number}"
                   else
                     Faker::PhoneNumber.phone_number
                   end

    # Use a fixed value (e.g., seed) as the basis for generating the identifier
    identifier = generate_uuid_from_string(seed.to_s)

    {
      name: errorSimulator(Faker::Name.name, error),
      address:errorSimulator( Faker::Address.full_address, error),
      phone_number: errorSimulator(phone_number, error),
      identifier: identifier
    }
  end
end
