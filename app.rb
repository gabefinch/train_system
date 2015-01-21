require('sinatra')
require('sinatra/reloader')
also_reload('/lib/**/*.rb')
require('pg')
require('./lib/line')
require('./lib/station')

DB = PG.connect({:dbname => "train_system"})

get('/') do
  @all_stations = Station.all()
  erb(:index)
end

post('/add_station') do
  station_name = params.fetch('station_name')
  Station.new({:name => station_name}).save()
  redirect back
end
