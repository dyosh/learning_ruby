require "csv"
require "sunlight/congress"
require "erb"
require "date"

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

class User
  attr_accessor :id, :first_name, :last_name, :home_phone, :reg_date
  def initialize(id, first_name, last_name, home_phone, reg_date)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @home_phone = home_phone
    @reg_date = reg_date
  end
end

class RegistrationStats
  attr_accessor :hour_frequency, :day_frequency
  def initialize
    @days_of_week = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    @hour_frequency = Hash.new(0)
    @day_frequency = Hash.new(0)
  end

  def get_hour(time)
    time.split(" ")[1].split(":")[0].to_i
  end

  def get_minute(time)
    time.split(" ")[1].split(":")[1].to_i
  end

  def increase_hour_frequency(time)
    # time has the format: m/d/y h:mm
    @hour_frequency[self.get_hour(time)] += 1
  end

  def increase_day_frequency(date)
    date = date.split(" ")
    # returns value for day of week. Sunday => 0 .. Saturday => 6
    @day_frequency[@days_of_week[Date.strptime(date[0], '%m/%d/%y').wday]] += 1
  end
end

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def clean_phone_number(phone_number)
  naked_number = phone_number.scan(/\d/).join('')
  if naked_number.length == 11 && naked_number[0] == "1"
    naked_number = naked_number[1..-1]
  elsif naked_number.length != 10
    naked_number = "0000000000"
  end
  return "(" + naked_number[0..2] + ")" + naked_number[3..5] + "-" + naked_number[6..-1]
end

def legislator_by_zipcode(zipcode)
  Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def save_thank_you_letters(id, form_letter)
  Dir.mkdir("output") unless Dir.exists?("output")
  filename = "output/thanks_#{id}.html"
  File.open(filename, 'w') { |file| file.puts(form_letter) }
end

def save_user_info(user_list_template)
  Dir.mkdir("users") unless Dir.exists?("users")
  filename = "users/user_list.txt"
  File.open(filename, 'w') { |file| file.puts(user_list_template) }
end

def save_time_data(hour_freq_template)
  Dir.mkdir("registration") unless Dir.exists?("registration")
  filename = "registration/reg_info.txt"
  File.open(filename, 'w') { |file| file.puts(hour_freq_template) }
end

puts "EventManager initialized."
contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol

################################################################################
#                          ERB Template Files
################################################################################
template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter

reg_time_template = File.read "reg_info.erb"
erb_reg_time_template = ERB.new reg_time_template

user_template = File.read "user_list.erb"
erb_user_template = ERB.new user_template
################################################################################

user_info = []
reg_info = RegistrationStats.new

contents.each do |row|
  id = row[0]
  first_name = row[:first_name]
  last_name = row[:last_name]
  reg_date = row[:regdate]
  zipcode = clean_zipcode(row[:zipcode])
  home_phone = clean_phone_number(row[:homephone])
  legislators = legislator_by_zipcode(zipcode)

  user_info.push(User.new(id, first_name, last_name, home_phone, reg_date))

  reg_info.increase_hour_frequency(reg_date) # keep track of registration dates by hour
  reg_info.increase_day_frequency(reg_date)  # keep track of registration dates by day

  form_letter = erb_template.result(binding)
  save_thank_you_letters(id, form_letter)
end

save_time_data(erb_reg_time_template.result(binding))
save_user_info(erb_user_template.result(binding))
