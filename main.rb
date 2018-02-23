require 'sinatra' 
require 'haml'
require 'yaml'
require 'date'
require 'json'
require 'gon-sinatra'
Sinatra::register Gon::Sinatra

#rerun 'ruby main.rb'

$schedule = YAML.load_file('schedule.yml')

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
	$schedule = YAML.load_file('schedule.yml')
	gon.schedule = $schedule
	haml :index 
end

get '/:target/:selected/:year/:month/:day' do
	@target = params[:target]
	@selected = params[:selected]
	@year = params[:year].to_i
	@month = params[:month].to_i+1 #month is returned 0-indexed so increment by 1 for readability
	@day = params[:day].to_i #monday of week and considered the first day

	@dateArray = [@year, @month, @day]

	if @target == "None"
		$schedule[@selected] = @dateArray
	else
		@temp = $schedule[@target]
		if $schedule.key?(@selected) 
			$schedule[@target] = $schedule[@selected]
		else
			$schedule.delete(@selected)
		end
		$schedule[@selected] = @temp
	end

	status 204
end

get '/save' do
	File.open('schedule.yml', 'w') {|f| f.write $schedule.to_yaml }
	status 204
end

get '/revert' do
	"hello world"
end
