require 'sinatra' 
require 'haml'
require 'yaml'
require 'date'
require 'json'

#rerun 'ruby main.rb'

class Schedule
	@schedule = YAML.load_file('schedule.yml')
end

def getEngineer()
	#Returns a random engineer from engineers.yml.
	engineerList = YAML.load_file('engineers.yml')['engineers']
	engineerList.sample
end

def getSchedule()
	#Returns last saved schedule
	YAML.load_file('schedule.yml')
end

def saveSchedule()
	#Saves current schedule
	File.open('schedule.yml', 'w') {|f| f.write d.to_yaml }
end

def removeEntry(schedule)
	#removes entry from current schedule
end

get '/' do 
	@engineerList = YAML.load_file('engineers.yml')['engineers']
	haml :index 
end

get '/sdf' do 
	"test" 
end