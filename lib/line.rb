class Line
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes[:name]
    @id = attributes[:id]
  end

  define_singleton_method(:all) do
    all = []
    returned_lines = DB.exec("SELECT * FROM lines")
    returned_lines.each() do |line|
      name = line.fetch("name")
      id = line.fetch("id").to_i()
      temp_line =Line.new({:name => name, :id => id})
      all.push(temp_line)
    end
    all
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO lines (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |other|
    name = self.name().==(other.name())
    id = self.id().==(other.id())
    name.&(id)
  end

  define_method(:add_station) do |station|
    DB.exec("INSERT INTO line_stations (line_id, station_id) VALUES (#{self.id()}, #{station.id()});")
  end

  define_singleton_method(:lines_at_station) do |station|
    line_ids = []
    returned_lines = []

    returned_rows = DB.exec("SELECT * FROM line_stations WHERE station_id = #{station.id()};")
    returned_rows.each() do |row|
      line_id = row["line_id"].to_i()
      line_ids.push(line_id)
    end

    lines_all = Line.all()
    lines_all.each() do |line|
      if line_ids.include?(line.id())
        returned_lines.push(line)
      end
    end
    returned_lines
  end
  define_singleton_method(:find_by_id) do |id|
    match = nil
    Line.all().each() do |line|
      if line.id().==(id)
        match = line
      end
    end
    match
  end

end
