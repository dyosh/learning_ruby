# puts "EventManager Initialized"
# if File.exist? "event_attendees.csv"
#   contents = File.read "event_attendees.csv"
# end
# puts contents

# lines = File.readlines "event_attendees.csv"
# lines.each { |line| puts line }

=begin
# A problem with this solution is that the content of our header row could
# change in the future. Additional columns could be added or the existing
# columns updated.
lines = File.readlines "event_attendees.csv"
lines.each do |line|
  next if line == " ,RegDate,first_Name,last_Name,Email_Address,HomePhone,Street,City,State,Zipcode\n"
  columns = line.split(",")
  first_name = columns[2]
  last_name = columns[3]
  puts "#{first_name} #{last_name}"
end
=end

=begin
# A second way to solve this problem is for us to track the
# index of the current line
lines = File.readlines "event_attendees.csv"
row_index = 0
lines.each do |line|
  row_index = row_index + 1
  next if row_index == 1
  columns = line.split(",")
  name = columns[2]
  puts name
end
=end

# This is such a common operation that Array defines Array#eachwithindex

=begin
lines = File.readlines "event_attendees.csv"
lines.each_with_index do |line, index|
  next if index == 0
  columns = line.split(",")
  name = columns[2]
  puts name
end
=end

################################################################################
#                      ITERATION 1: PARSING WITH CSV
################################################################################

# require "csv"
# puts "EventManager initiliazed"
#
# contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol
# contents.each do |row|
#   # Converting the headers to symbols will make our column names more uniform
#   # and easier to remember. The header 'first_Name' will be converted to
#   # :first_name
#   name = row[:first_name]
#   zipcode = row[:zipcode]
#   puts "#{name} #{zipcode}"
# end

################################################################################
#                     ITERATION 2: CLEANING UP ZIP CODES
################################################################################

# require "csv"
# puts "EventManager initialized"
#
# # def clean_zipcodes(zipcode)
# #   if zipcode.nil?
# #     zipcode = "00000"
# #   elsif zipcode.length > 5
# #     zipcode = zipcode[0..4]
# #   elsif zipcode.length < 5
# #     while zipcode.length < 5
# #       zipcode.insert(0, "0")
# #     end
# #   else
# #     zipcode
# #   end
# # end
#
# def clean_zipcodes(zipcode)
#   zipcode.to_s.rjust(5,"0")[0..4]
# end
#
# contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol
# contents.each do |row|
#   name = row[:first_name]
#   zipcode = clean_zipcodes(row[:zipcode])
#
#   puts "#{name} #{zipcode}"
# end

################################################################################
#                     ITERATION 3: USING SUNLIGHT
################################################################################

# require 'csv'
# require 'sunlight/congress'
#
# Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"
#
# def clean_zipcode(zipcode)
#   zipcode.to_s.rjust(5,"0")[0..4]
# end
#
# puts "EventManager initialized."
#
# contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol
#
# contents.each do |row|
#   name = row[:first_name]
#
#   zipcode = clean_zipcode(row[:zipcode])
#
#   legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)
#
#   puts "#{name} #{zipcode} #{legislators}"
# end

################################################################################
#                     Collecting Legislator Names
################################################################################

=begin
require 'csv'
require 'sunlight/congress'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

puts "EventManager initialized."

contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol

contents.each do |row|
  name = row[:first_name]

  zipcode = clean_zipcode(row[:zipcode])

  legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)

  legislator_names = legislators.map do |legislator|
    "#{legislator.first_name} #{legislator.last_name}"
  end

  legislators_string = legislator_names.join(", ")
  puts "#{name} #{zipcode} #{legislators_string}"
  # puts "#{name} #{zipcode} #{legislators}"
end
=end

################################################################################
#                Moving Displaying Legislator to a Method
################################################################################

=begin
require "csv"
require "sunlight/congress"

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def legislator_by_zipcode(zipcode)
  legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)

  legislator_names = legislators.map do |legislator|
    "#{legislator.first_name} #{legislator.last_name}"
  end

  legislator_names.join(", ")
end

puts "EventManager initialized."

contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol

contents.each do |row|
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislator_by_zipcode(zipcode)

  puts "#{name} #{zipcode} #{legislators}"
end
=end

################################################################################
#                               Using Templates
################################################################################

=begin
require 'csv'
require 'sunlight/congress'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

puts "EventManager initialized."

contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol

contents.each do |row|
  name = row[:first_name]

  zipcode = clean_zipcode(row[:zipcode])

  legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)

  legislator_names = legislators.map do |legislator|
    "#{legislator.first_name} #{legislator.last_name}"
  end

  legislators_string = legislator_names.join(", ")
  puts "#{name} #{zipcode} #{legislators_string}"
  # puts "#{name} #{zipcode} #{legislators}"
end
=end

################################################################################
#                           Using ERB Templates
################################################################################

=begin
require "csv"
require "sunlight/congress"

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def legislator_by_zipcode(zipcode)
  legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)

  legislator_names = legislators.map do |legislator|
    "#{legislator.first_name} #{legislator.last_name}"
  end

  legislator_names.join(", ")
end

puts "EventManager initialized."

contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol

template_file = File.read "form_letter.html"

contents.each do |row|
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislator_by_zipcode(zipcode)

  personal_letter = template_file.gsub('FIRST_NAME', name)
  personal_letter.gsub!('LEGISLATORS', legislators)

  puts personal_letter
  # puts "#{name} #{zipcode} #{legislators}"
end
=end

################################################################################
#                        ITERATION 4: FORM LETTERS
################################################################################

=begin
require "csv"
require "sunlight/congress"
require "erb"

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def legislator_by_zipcode(zipcode)
  Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

puts "EventManager initialized."

contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol

template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter

contents.each do |row|
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislator_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)
  puts form_letter
end
=end

################################################################################
#                     Outputting form letters to a file
################################################################################

=begin
require "csv"
require "sunlight/congress"
require "erb"

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def legislator_by_zipcode(zipcode)
  Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

puts "EventManager initialized."

contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol

template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislator_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  Dir.mkdir("output") unless Dir.exists?("output")

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') { |file| file.puts form_letter }

end
=end

################################################################################
#                 Moving Form Letter Generation to a Method
################################################################################

=begin
require "csv"
require "sunlight/congress"
require "erb"

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def legislator_by_zipcode(zipcode)
  Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def save_thank_you_letters(id, form_letter)
  Dir.mkdir("output") unless Dir.exists?("output")

  filename = "output/thanks_#{id}.html"
  File.open(filename, 'w') { |file| file.puts(form_letter) }
end

puts "EventManager initialized."

contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol

template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislator_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)
  save_thank_you_letters(id, form_letter)
end
=end

################################################################################
#                     ITERATION: CLEAN PHONE NUMBERS
################################################################################
# Ruby has a Date library which contains classes for Date and DateTime.
# DateTime#strptime is a method that allows us to parse date-time strings and convert them into Ruby objects.
# DateTime#strftime is a good reference on the characters necessary to match the specified date-time format.
# Use Date#hour to find out the hour of the day.
