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


end
