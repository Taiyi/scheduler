require "./main"

map "/public" do
 run Rack::Directory.new("./public")
end

set :public_folder, File.join(APP_ROOT, "public")

run Sinatra::Application