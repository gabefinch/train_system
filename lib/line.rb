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

end
