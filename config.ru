require "./main"

set :public_folder, File.join(File.dirname(__FILE__), "public")


use Rack::Static, :urls => ["/public"]

Sinatra::Application.run!