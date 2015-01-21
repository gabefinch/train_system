class Station
attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes[:name]
    @id = attributes[:id]
  end

  define_singleton_method(:all) do
    all = []
    returned_stations = DB.exec("SELECT * FROM stations;")
    returned_stations.each() do |station|
      name = station.fetch("name")
      id = station.fetch("id").to_i
      temp_station = Station.new({:name => name, :id => id})
      all.push(temp_station)
    end
    all
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO stations (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |other|
    name = self.name().==(other.name())
    id = self.id().==(other.id())
    name.&(id)
  end

  define_singleton_method(:on_line) do |line|
    station_ids = []
    line_stations = []

    returned_rows = DB.exec("SELECT * FROM line_stations WHERE line_id = #{line.id()};")
    returned_rows.each() do |row|
      station_id = row["station_id"].to_i()
      station_ids.push(station_id)
    end

    stations_all = Station.all()
    stations_all.each() do |station|
      if station_ids.include?(station.id())
        line_stations.push(station)
      end
    end
    line_stations
  end
end
