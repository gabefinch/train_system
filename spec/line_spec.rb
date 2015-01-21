require('spec_helper')

describe('Line') do
  describe('.all') do
    it('returns empty array if no lines are saved') do
      expect(Line.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('saves line into database') do
      test_line1 = Line.new({:name => "Blue", :id => nil})
      test_line1.save()
      test_line2 = Line.new({:name => "Red", :id => nil})
      test_line2.save()
      test_line3 = Line.new({:name => "Orange", :id => nil})
      test_line3.save()
      expect(Line.all()).to(eq([test_line1, test_line2, test_line3]))
    end
  end

  describe("#id") do
    it('returns id from an instance of line') do
      test_line1 = Line.new({:name => "Blue", :id => nil})
      test_line1.save()
      test_line2 = Line.new({:name => "Red", :id => nil})
      test_line2.save()
      id = test_line2.id()
      expect(id.class()).to(eq(Fixnum))
    end
  end
  describe("#add_station") do
    it("links a station to a line in line_stations table") do
      test_line1 = Line.new({:name => "Blue", :id => nil})
      test_line1.save()
      test_station1 = Station.new({:name => "Ruby Junction", :id => nil})
      test_station1.save()
      test_line1.add_station(test_station1)
      expect(Station.stations_on_line(test_line1)).to(eq([test_station1]))
    end
  end

  describe(".lines_at_station") do
    it("returns an array of lines passing through a station") do
      test_line1 = Line.new({:name => "Blue", :id => nil})
      test_line1.save()
      test_station1 = Station.new({:name => "Ruby Junction", :id => nil})
      test_station1.save()
      test_line1.add_station(test_station1)
      expect(Line.lines_at_station(test_station1)).to(eq([test_line1]))
    end
  end
end
