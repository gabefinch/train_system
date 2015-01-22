require('sinatra')
require('sinatra/reloader')
also_reload('/lib/**/*.rb')
require('pg')
require('./lib/line')
require('./lib/station')

DB = PG.connect({:dbname => "train_system"})

get('/') do
  @all_stations = Station.all()
  @all_lines = Line.all()
  erb(:index)
end

post('/add_station') do
  station_name = params.fetch('station_name')
  Station.new({:name => station_name}).save()
  redirect back
end


post('/add_line') do
  line_name = params.fetch('line_name')
  Line.new({:name => line_name}).save()
  redirect back
end

get('/station/:id') do
  id = params.fetch("id").to_i()
  @station = Station.find_by_id(id)
  erb(:station)
end


get("/line/:id") do
  id = params.fetch("id").to_i()
  @line = Line.find_by_id(id)
  erb(:line)
end
