require 'sinatra' 
require 'haml'
require 'yaml'
require 'gon-sinatra'
Sinatra::register Gon::Sinatra

$schedule = YAML.load_file('schedule.yml')

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
	elsif @selected == "None"
		$schedule.delete(@target)
	else
		@temp = $schedule[@target]
		if $schedule.key?(@selected) 
			$schedule[@target] = $schedule[@selected]
		else
			$schedule.delete(@target)
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
	redirect "/", 303
end