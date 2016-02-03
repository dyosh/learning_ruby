=begin

print "Enter something here: "
user_input = gets.chomp
user_input.downcase!

if user_input.include? "s"
	user_input.gsub!(/s/, "th")
	puts "#{user_input}"
	# puts "#{user_input} contains an 's'"
else
	puts "There are no \"s\" characters involved here."
end

########################################################
i = 20
loop do
	i -= 1
	puts "#{i}"
	break if i <= 0
end

########################################################
nums = [1,2,3,4,5]
nums.each do |num|
	print num * 2
	print "\n"
end

########################################################

5.times { print "chunky monkey!" }
print "\n"

5.times do
	print "WTF"
end
print "\n"

########################################################

i = 1
while i <= 50 do
	print i
	i += 1
end
########################################################

i = 1
until i == 51 do
	print i
	i += 1
end
########################################################

for i in 1..50
	print i
	i += 1
end
########################################################

i = 0
loop do
	print "Ruby!"
	i += 1
	break if i == 30
end

########################################################

puts "Enter a sentence: "
text = gets.chomp

puts "Enter letter to be REDACTED"
redact = gets.chomp

updated = ""
words = text.split(" ")
words.each do |word|
	if word == redact
		updated += "REDACTED "
	else
		updated += word + " "
	end
end

puts updated
########################################################

friends = ["Milhouse", "Ralph", "Nelson", "Otto"]

family = {	"Homer" => "dad",
			"Marge" => "mom",
			"Lisa" => "sister",
			"Maggie" => "sister",
			"Abe" => "grandpa",
			"Santa's Little Helper" => "Dog"
		}

friends.each { |friend| puts "#{friend}" }
family.each { |member| puts "#{member}" }
########################################################

s = [["ham", "swiss"], ["turkey", "cheddar"], ["roast beef", "gruyere"]]

s.each do | sub_array |
	sub_array.each do |x|
		puts x
	end
end
########################################################

secret_identities = {
  "The Batman" => "Bruce Wayne",
  "Superman" => "Clark Kent",
  "Wonder Woman" => "Diana Prince",
  "Freakazoid" => "Dexter Douglas"
}

# since logic fits on one line, do it with {} instead of do || ... end
secret_identities.each { |key, value| puts "#{key}: #{value}" }

# secret_identities.each do |key, value|
# 	puts "#{key}: #{value}"
# end

########################################################

lunch_order = {
  "Ryan" => "wonton soup",
  "Eric" => "hamburger",
  "Jimmy" => "sandwich",
  "Sasha" => "salad",
  "Cole" => "taco"
}

lunch_order.each { |key, value| puts "#{value}" }

########################################################
puts "Enter a sentence here: "
text = gets.chomp
words = text.split(" ")
frequencies = Hash.new(0) # defaults intial values to 0

words.each { |word| frequencies[word] += 1 }
puts frequencies
frequencies = frequencies.sort_by { |word, count| count }
frequencies.reverse!
frequencies.each { |word, count| puts "#{word}: #{count}" }

########################################################

def prime(n)
	puts "Thats not an integer." unless n.is_a? Integer
	is_prime = true
	for i in 2..n-1
		if n % i == 0
			is_prime = false
			break
		end
	end

	if is_prime
		puts "#{n} is a prime number!"
	else
		puts "#{n} is not a prime number!"
	end
end

prime(2)
prime(9)
prime(11)
prime(51)
prime(97)

########################################################

def what_up(greeting, *bros)
	bros.each { |bro| puts "#{greeting} #{bro}!"}
end

what_up("What up", "Dan", "Dana", "Martha", "Sarah")
########################################################

def add(a, b)
	return a + b
end

def greeter(name)
	return "Hi #{name}"
end

def by_three?(num)
	if num % 3 == 0
		return true
	else
		return false
	end
end

sum = add(5, 2)
puts sum

########################################################

# method that capitalizes a word
def capitalize(string)
	puts "#{string[0].upcase}#{string[1..-1]}"
end

capitalize("dan") # prints "Dan"
capitalize("yin") # prints "Yin"

# block that capitalizes each string in the array
["dan", "yin"].each { |string| puts "#{string[0].upcase}#{string[1..-1]}" }

########################################################

[1,2,3,4,5].each { |i| print i }
[1,2,3,4,5].each { |i| puts i * 5 }

my_array = [3, 4, 8, 7, 1, 6, 5, 9, 2]
my_array.sort!
print my_array
puts

book_1 = "A Wrinkle in Time"
book_2 = "A Brief History of Time"
# <=> returns 0 if equal, 1 if leftside > rightside, -1 otherwise
puts book_1 <=> book_2

books = ["Charlie and the Chocolate Factory", "War and Peace", "Utopia", "A Brief History of Time", "A Wrinkle in Time"]
# Sort books in ascending order, in-place
books.sort! { |a, b| a <=> b }
puts books

#Sort books in descending order, in-place
books.sort! { |a, b| b <=> a }
puts books

########################################################

def alphabetize(arr, rev=false)
	if rev
		arr.sort { |item1, item2| item2 <=> item1 }
	else
		arr.sort { |item1, item2| item1 <=> item2 }
	end
end

books = ["Heart of Darkness", "Code Complete", "The Lorax", "The Prophet", "Absalom, Absalom!"]
puts "A-Z: #{alphabetize(books)}"
puts "Z-A: #{alphabetize(books, true)}"

def alphabetize2(arr, rev=false)
		arr.sort!
		if rev
			arr.reverse!
		end

		return arr
end

puts alphabetize2([4, 5, 2345, 1, 51], rev=true)

########################################################

matz = 	{	"First Name" => "Yukihiro",
					"Last_name"	=> "Matsumoto",
				 	"Age"				=> 27,
				 	"Nationality" => "Japanese",
				 	"Nickname"		=> "Maz"
				}

matz.each do |key, value|
	puts "#{value}"
end

puts "Single Line Statement"
matz.each { |key, value| puts "#{value}" }

########################################################

no_nil_hash = Hash.new("Teddy Bear!")

# SYMBOLS
# Immutable
# Only one copy of any symbol exists at a given time, so they save memory
# Symbol-as-keys are faster than strings-as-keys because of the above two reasons

puts "string".object_id # some numerical value
puts "string".object_id # a different numerical value

puts :symbol.object_id # some numerical value
puts :symbol.object_id # same numerical value

a = "string"
b = "string"

a == b # true
a.object_id == b.object_id # false

my_first_symbol = :sym

symbol_hash = {
	:one => 1,
	:two => 2,
	:three => 3
}

puts symbol_hash[:one]

strings = ["HTML", "CSS", "JavaScript", "Python", "Ruby"]
symbols = []
strings.each { |item| symbols.push(item.to_sym) } 				# Converts string -> symbol
# .intern and .to_sym do exactly the same thing. Up to preference
strings.each { |item| symbols.push(item.intern) }

movies = {
	:name => "Rawr",
	:synop => "The best movie ever"
}

# :symbol => value  is the same  as symbol: value

grades = {
	alice: 100,
	bob: 92,
	chris: 95,
	dave: 97
}

puts grades.select { |name, grade| grade < 97 }
puts grades.select { |k, v| k == :alice }


my_hash = {
	one: 1,
	two: 2,
	three: 3
}

puts my_hash.each_key { |k| print k, " " }
puts my_hash.each_value { |value| print value, " " }

########################################################


def is_valid_choice?(choice)
	choices = ['add', 'update', 'display', 'delete']
	valid_choice = false
	while !valid_choice
		for i in 0..choices.length-1
			if choices[i] == choice
				valid_choice = true
				break
			end
		end

		if !valid_choice
			puts "Sorry, you need to enter a valid command."
			choice = gets.chomp.downcase
		end
	end
	return choice
end

def is_valid_rating?(rating)
	if rating >= 0 && rating <= 4
		return rating
	else
		valid_rating = false
		while !valid_rating
			puts "Sorry, you need to enter a valid rating (0 - 4)."
			rating = gets.chomp.to_i
			if rating >= 0 && rating <= 4
				return rating
			end
		end
	end
end

movies = {
	:Memento => 3,
	:Primer => 4,
	:Ishtar => 1
}

puts "What would you like to do?"
puts "-- Type 'add' to add a movie."
puts "-- Type 'update' to update a movie."
puts "-- Type 'display' to display all movies."
puts "-- Type 'delete' to delete a movie."

choice = is_valid_choice?(gets.chomp.downcase)
case choice
when 'add'
	puts "What movie do you want to add?"
	title = gets.chomp
	if movies[title.to_sym].nil?
		puts "What's the rating? (Type a number 0 to 4)"
		rating = is_valid_rating?(gets.chomp.to_i)
		movies[title.to_sym] = rating
		puts "#{title} has been added with a rating of #{rating}."
	else
		puts "That movie already exists! It's rating is #{movies[title.to_sym]}."
	end
when 'update'
	puts "What movie do you want to update?"
	title = gets.chomp
	if movies[title.to_sym].nil?
		puts "Movie not found!"
	else
		puts "What's the new rating? (0-4)."
		rating = is_valid_rating?(gets.chomp.to_i)
		movies[title.to_sym] = rating
		puts "#{title} has been updated with a new rating of #{rating}."
	end
when 'display'
	movies.each do |movie, rating|
		puts "#{movie}: #{rating}"
	end
when 'delete'
	puts "What movie do you want to delete?"
	title = gets.chomp
	if movies[title.to_sym].nil?
		puts "Movie not found!"
	else
		movies.delete(title.to_sym)
		puts "#{title} has been removed."
	end
else
	puts "Sorry, I didn't understand you."
end

########################################################

ruby_is_eloquent = true
ruby_is_ugly = false

puts "Ruby is eloquent!" if ruby_is_eloquent
puts "Ruby isn't ugly!" unless ruby_is_ugly

# One line if statement does not need an end.
puts "It's true!" if true


puts 3 < 4 ? "3 is less than 4!" : "3 is not less than 4."

language = "Ruby"
case language
when "JS" then puts "Websites!"
when "Python" then puts "Science!"
when "Ruby" then puts "Web apps!"
else puts "I don't know!"
end

########################################################
# CONDITIONAL ASSIGNMENT ||=

favorite_book = nil
puts favorite_book

favorite_book ||= "Cat's Cradle"
puts favorite_book

favorite_book ||= "Why's (Poignant) Guide to Ruby"
puts favorite_book

favorite_book ||= "Shibassss"
puts favorite_book

########################################################
# seems like for loops arent used too often in Ruby

5.times { puts "Odelay!" }
[1,2,3].each { |x| puts x * 10 }

my_array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

my_array.each do |num|
	puts num % 2 == 0 ? num : "not even"
end

########################################################
95.upto(100) { |num| print num, " " }
puts
100.downto(0) { |num| print num, " " }
puts

"A".upto("z") { |char| print char, " " }
puts

########################################################
# Call and Responses
puts [1,2,3].respond_to?(:push) # true
puts [1,2,3].respond_to?(:to_sym) # false, can't turn an array into a symbol!

age = 27
puts age.respond_to?(:next) # true

# concatenation operator (aka the 'shovel')
arr = [1,2,3].push(4)
new_arr = [5,6,7] << 8

arr.each { |num| print num, " " }
puts
new_arr.each do |num|
	print num, " "
end
puts

name = "Yukihiro"
name << " Matsumoto"
puts name

########################################################
# String Interpolation

drink = "coffee"
print "I love #{drink}!!! \n"

favorite_things = ["Ruby", "espresso", "candy"]
puts "A few of my favorite things:"

favorite_things.each do |thing|
	puts "I love #{thing}!!!!"
end

########################################################

# The Refactor Factory!

$VERBOSE = nil
require 'prime'

def first_n_primes(n)
	return "n must be an integer." unless n.is_a? Integer
	return "n must be greater than 0." if n <= 0
	prime_array ||= []

	# Ruby 1.8
	# prime = Prime.new
	# n.times { prime_array << prime.next }
	# return prime_array

	# As of Ruby 1.9 onwards
	# Prime class makes the array automatically.
	prime = Prime.instance
	prime.first n
end

puts first_n_primes(15)

########################################################

my_nums = [1, 2, 3]
my_nums.collect! { |num| num ** 2 } # mutates the array
puts my_nums

more_nums = [1, 2, 3]
more_nums.each { |num| num ** 2 } # doesn't mutate the array
puts more_nums

########################################################

def block_test
	puts "We're in the method!"
	puts "Yielding to the block..."
	yield
	puts "We're back in the method!"
end

block_test { puts ">>> We're in the block!" }

def yield_name(name)
	puts "In the method! Let's yield."
	yield("Kim")
	puts "In between the yields!"
	yield(name)
	puts "Block complete! Back in the method."
end

yield_name("Dan") { |name| puts "My name is #{name}." }

########################################################
# PROCS
multiples_of_3 = Proc.new do |n|
	n % 3 == 0
end

(1..100).to_a.select(&multiples_of_3)

cube = Proc.new { |x| x ** 3 }

[1,2,3].collect!(&cube)
[4,5,6].map!(&cube)
# The .collect! and .map! methods do the exact same thing
# The & is used to convert the proc into a block (since
# .collect and .map normally take a block).

# .floor method rounds a float down to the nearest integer
floats = [1.2, 3.45, 0.91, 7.727, 11.42, 482.911]
round_down = Proc.new { |x| x.floor }

print ints = floats.collect!(&round_down), "\n"
print floats, "\n"

array ||= [1,2,3,4]
array ||= []
print array.empty?, "\n"
array.clear
print array, "\n"

########################################################

# WHY PROCS?
# 1. Procs are fully-fledged objects. They have all the powers and abilities
#    of objects. (Blocks do not).
# 2. Unlike blocks, procs can be called over and over without rewriting them.
#    This prevents you from having to retype the contents of your block every
#    time you need to execute a particular bit of code.

group_1 = [4.1, 5.5, 3.2, 3.3, 6.1, 3.9, 4.7]
group_2 = [7.0, 3.8, 6.2, 6.1, 4.4, 4.9, 3.0]
group_3 = [5.5, 5.1, 3.9, 4.3, 4.9, 3.2, 3.2]

# Complete this as a new Proc
over_4_feet = Proc.new { |height| height >= 4 }

can_ride_1 = group_1.select(&over_4_feet)
can_ride_2 = group_2.select(&over_4_feet)
can_ride_3 = group_3.select(&over_4_feet)

# Change these three so that they use your new over_4_feet Proc
# can_ride_1 = group_1.select { |height| height >= 4 }
# can_ride_2 = group_2.select { |height| height >= 4 }
# can_ride_3 = group_3.select { |height| height >= 4 }


def greeter
	puts "inside greeter"
	yield
	puts "after proc yield"
end

phrase = Proc.new { puts "Hi there!" }
greeter(&phrase)

# Unlike blocks, we can call procs directly by using Ruby's .call method.
test = Proc.new { puts "testing!" }
test.call

# Convert symbols to procs
strings = ["1", "2", "3"]
nums = strings.map(&:to_i)
puts nums

numbers_array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
str_nums = numbers_array.map(&:to_s)
puts str_nums

########################################################
# LAMBDAS

lambda { puts "Hello!" }
# is just about the same as
Proc.new { puts "Hello!" }

def lambda_demo(a_lambda)
	puts "I'm the method!"
	a_lambda.call
end

lambda_demo(lambda { puts "I'm the lambda!" })


strings = ["leonardo", "donatello", "raphael", "michaelangelo"]
symbolize = lambda { |param| param.to_sym }
# & converts proc or lambda to a block
symbols = strings.collect(&symbolize)
puts symbols

########################################################
# LAMBDAS vs PROCS

# => 1. Lambdas check the number of arguments passed to it, while a proc does not.
# 			This means that a lambda will throw an error if you pass it the wrong number
#       of arguments, whereas a proc will ignore unexpected arguments and assign nil
#       to any that are missing.
# => 2. When a lambda returns, it passes control back to the calling method. When
#       a proc returns, it does so immediately, without going back to the calling method.

def batman_ironman_proc
	victor = Proc.new { return "Batman will win!" }
	victor.call
	"Iron Man will win!"
end
# puts batman_ironman_proc

def batman_ironman_lambda
	victor = lambda { return "Batman will win!" }
	victor.call
	"Ironman will win!"
end
# puts batman_ironman_lambda

my_array = ["raindrops", :kettles, "whiskers", :mittens, :packages]
symbol_filter = lambda { |x| x.is_a? Symbol }
symbols = my_array.select(&symbol_filter)

symbol_check = []
my_array.each do |x|
	if x.is_a? Symbol
		symbol_check.push(x)
	end
end
puts symbol_check

odds_n_ends = [:weezard, 42, "Trady Blix", 3, true, 19, 12.345]
ints = odds_n_ends.select { |item| item.is_a? Integer }
puts ints

ages = [23, 101, 7, 104, 11, 94, 100, 121, 101, 70, 44]
under_100 =  Proc.new { |age| age < 100 }
youngsters = ages.select(&under_100)
puts youngsters

################################################################################
# Quick Review
# => 1. A block is just a bit of code between do..end or {}. It is not an object
#       on it's own, but it can be passed to methods like .each or .select
# => 2. A proc is a saved block we can use over and over
# => 3. A lambda is just like a proc, only it cares about the number of arguments
#       it gets and returns to its calling method rather than returning immediately
################################################################################

crew = {
  captain: "Picard",
  first_officer: "Riker",
  lt_cdr: "Data",
  lt: "Worf",
  ensign: "Ro",
  counselor: "Troi",
  chief_engineer: "LaForge",
  doctor: "Crusher"
}

first_half = lambda { |key, value| value < "M" }
a_to_m = crew.select(&first_half)
puts a_to_m

################################################################################
# CLASSES

class Language
	def initialize(name, creator)
		@name = name
		@creator = creator
	end

	def description
		puts "I'm #{@name} and I was created by #{@creator}"
	end
end

ruby = Language.new("Ruby", "Yukihiro Matsumoto")
python = Language.new("Python", "Guido van Rossum")
javascript = Language.new("JavaScript", "Brendan Eich")

ruby.description
python.description
javascript.description

################################################################################
# SCOPE
# $ is for global variables
# @ is for instance variables
# @@ is for class variables

class Computer
	$manufacturer = "Mango Computer, Inc"
	@@files = { hello: "Hello, World!" }

	def initialize(username, password)
		@username = username
		@password = password
	end

	def current_user
 		@username
	end

	def self.display_files
		@@files
	end
end

# Make a new Computer instance
hal = Computer.new("Dave", 12345)

puts "Current user: #{hal.current_user}"
# @username belongs to the hal instance

puts "Manufacturer: #{$manufacturer}"
# $manufacturer is global! We can get it directly.

puts "Files: #{Computer.display_files}"
# @@files belongs to the Computer class

################################################################################
# Utilizing class variables (@@)
class Person
	@@people_count = 0

	def initialize(name)
		@name = name
		@@people_count += 1
	end

	def self.number_of_instances
		return @@people_count
	end
end

matz = Person.new("Yukihiro")
dan = Person.new("Yosh")

puts "The number of Person instances: #{Person.number_of_instances}"

################################################################################
# Inheritance

class ApplicationError
	def display_error
		puts "Error! Error!"
	end
end

class SuperBadError < ApplicationError

end

err = SuperBadError.new
err.display_error

# Overriding

class Creature
	def initialize(name)
		@name = name
	end

	def fight
			return "Punch to the chops!"
	end
end

class Dragon < Creature
	def fight
		puts "Instead of breathing fire..."
		super
		# return "Breathes fire!"
	end
end

turtle = Creature.new("tony")
puts turtle.fight

dragon = Dragon.new("elliot")
puts dragon.fight

# When you call super from inside a method, that tells Ruby to look in the
# superclass of the current class and find a method with the same name as
# the one from which super is called. If it finds it, Ruby will use the
# superclasses' version of the method.

class Message
	@@message_count = 0
	def initialize(from, to)
		@from = from
		@to = to
		@@message_count += 1
	end
end

class Email < Message
	def initialize(from, to)
		super(from, to)				# when would this actually be used in practice?
	end
end

my_message = Message.new("Dan", "Dana")
email = Email.new("yosh", "dosh")

################################################################################

class Machine
	@@users = {}

	def initialize(username, password)
		@username = username
		@password = password
		@@users[username] = password
		@files = {}
	end

	def create(filename)
		time = Time.now
		@files[filename] = time
		puts "#{filename} was created by #{@username} at #{time}"
	end

	def delete(filename)
		if @files.include? filename
			@files.delete_if { |key, value| key == filename }
			puts "#{filename} has been deleted"
		else
			puts "#{filename} was not found."
		end
	end

	def display_files
		puts "Display all files..."
		@files.each { |filename, value| puts filename }
	end

	def self.get_users
		@@users
	end
end

my_machine = Machine.new("eric", 01234)
your_machine = Machine.new("dan", 56781)

your_machine.create("todo.txt")

my_machine.create("groceries.txt")
my_machine.create("crazy_business.txt")
my_machine.delete("groceries.txt")
my_machine.display_files


# puts "Users: #{Machine.get_users}"

################################################################################
# PUBLIC and PRIVATE

class Person
	def initialize(name, age)
		@name = name
		@age = age
	end

	public	# this method can be called from outside of the class
	def about_me
		puts "I'm #{@name} and I'm #{@age} years old!"
	end

	private	# this method can't!
	def bank_account_number
		@account_number = 1234456
		puts "My bank account number is #{@account_number}."
	end
end

dan = Person.new("Dan", 27)
dan.about_me
dan.test
dan.bank_account_number

################################################################################
# attr_reader  and  attr_writer

# if we wanted to access a @name instance variable we would have to do...
# def name
#   @name
# end
# instead we can do this.

class Person
	attr_reader :name
	attr_writer :name
	def initialize(name)
		@name = name
	end
end

# Ruby does something like this for us
# def name
# 	@name
# end
#
# def name=(value)
# 	@name = value
# end

# If we want to both read and write a particular variable, there's an even
# shorter way to do this. Instead of writing out attr_reader and attr_writer
# seperately, you can just use attr_accessor to denote the get/set methods.

class Student
	attr_accessor :name
	def initialize(name)
		@name = name
	end
end

dan = Student.new("dan")
dan.name = "test"
puts dan.name

################################################################################
# MODULES
#
# One of the main purposes of modules is to separate methods and constants
# into named spaces. This is called namespacig, and it's how Ruby doesn't
# confuse Math::PI and Circle::PI
# ::  is called the scope resolution operator.
module Circle
	PI = 3.141592653589793

	def Circle.area(radius)
		PI * radius**2
	end

	def Circle.Circumference(radius)
		2 * PI * radius
	end
end

puts Circle.area(5)

puts Math::PI

require 'date'
puts Date.today


# Can also include modules within a class (mixin)
class Angle
	# now we can use the Math module and not have to access it using Math::cos
	include Math
	attr_accessor :radians

	def initialize(radians)
		@radians = radians
	end

	def cosine
		cos(@radians)
	end
end

test = Angle.new(0)
puts test.cosine

################################################################################
# MIXINS
# When a module is used to mix additional behavior and information into a class

module Action
	def jump(name)
		@distance = rand(4) + 2
		puts "#{name} jumped forward #{@distance} feet!"
	end
end

class Rabbit
	include Action
	attr_reader :name
	def initialize(name)
		@name = name
	end
end

class Cricket
	include Action
	attr_reader :name
	def initialize(name)
		@name = name
	end
end

peter = Rabbit.new("Peter")
jiminy = Cricket.new("Jiminy")

peter.jump(peter.name)
jiminy.jump(jiminy.name)

################################################################################
# EXTEND
# Whereas include mixes a module's methods in at the instance level (allowing
# instances of a particular class to use the methods), the extend keyword
# mixes a module's methods at the class level. This means that class itself
# can use the methods, as opposed to instances of the class.


# ThePresent has a .now method that we'll extend to TheHereAnd
module ThePresent
	def now
    puts "It's #{Time.new.hour > 12 ? Time.new.hour - 12 : Time.new.hour}:#{Time.new.min} #{Time.new.hour > 12 ? 'PM' : 'AM'} (EST)."
	end
end

class TheHereAnd
	# include ThePresent
	extend ThePresent
end

TheHereAnd.now

################################################################################
=end
# Last Project

class Account
	attr_reader :name, :balance
	def initialize(name, balance=100)
		@name = name
		@balance = balance
	end

	def display_balance(pin_number)
		puts pin_number == pin ? "Balance #{@balance}" : pin_error
	end

	def withdraw(pin_number, amount)
			if pin_number == pin
				@balance -= amount
				puts "Withdrew #{amount}. New balance: $#{@balance}."
			else
				puts pin_error
			end
	end

	def deposit(pin_number, amount)
		if pin_number == pin
			@balance += amount
			puts "Deposited of $#{amount} successful. New balance: $#{@balance}."
		else
			puts pin_error
		end
	end

	private
	def pin
		@pin = 1234
	end

	def pin_error
		"Access denied: invalid PIN."
	end
end

my_account = Account.new("Dan", 100)
my_account.display_balance(1234)
my_account.deposit(1234, 250)
my_account.display_balance(1234)
puts my_account.balance
