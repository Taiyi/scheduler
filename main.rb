require 'sinatra' 
require 'haml'
require 'yaml'

$engineerList = YAML.load_file('Engineers.yml')['engineers']


def getEngineer()
	#Returns a random engineer from engineers.yml.
	$engineerList.sample
end

get '/' do 
  haml :index 
end

get '/sdf' do 
  "test" 
end