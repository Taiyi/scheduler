require 'sinatra' 
require 'haml'
require 'yaml'
require 'gon-sinatra'
Sinatra::register Gon::Sinatra

def resetSchedule()
   $schedule = {}
end

def getSchedule()
	return YAML.load_file('schedule.yml')
end

def saveSchedule(schedule)
	File.open('schedule.yml', 'w') {|f| f.write schedule.to_yaml }
	return
end

def addEngineer(schedule, selected, year, month, day)
	dateArray = [year, month, day]
	schedule[selected] = dateArray
end

def deleteEngineer(schedule, target)
	schedule.delete(target)
end

def switchEngineers(schedule, target, selected)
	temp = schedule[target]
	if schedule.key?(selected) 
		schedule[target] = schedule[selected]
	else
		schedule.delete(target)
	end
	schedule[selected] = temp
end

$schedule = getSchedule()

get '/' do 
	@engineerList = YAML.load_file('engineers.yml')['engineers']
	$schedule = getSchedule()
	gon.schedule = $schedule
	haml :index 
end

get '/:target/:selected/:year/:month/:day' do
	target = params[:target]
	selected = params[:selected]
	year = params[:year].to_i
	month = params[:month].to_i+1 #month is returned 0-indexed so increment by 1 for readability
	day = params[:day].to_i #monday of week and considered the first day

	if target == "None"
		addEngineer($schedule, selected, year, month, day)
	elsif selected == "None"
		deleteEngineer($schedule, target)
	elsif  target != "None" and selected != "None"
		switchEngineers($schedule, target, selected)
	end

	status 204
end

get '/save' do
	saveSchedule($schedule)
	status 204
end

get '/revert' do 
	redirect "/", 303
end

get '/reset' do 
	resetSchedule()
	redirect "/", 303
end