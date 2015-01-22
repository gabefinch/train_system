require('spec_helper')

describe('Station') do
  describe('.all') do
    it("returns empty array if no stations are saved") do
      expect(Station.all()).to(eq([]))
    end
  end
  describe('#save') do
    it('saves stations into database') do
      test_station1 = Station.new({:name => "Gresham"})
      test_station1.save()
      test_station2 = Station.new({:name => "Ruby Junction"})
      test_station2.save()
      test_station3 = Station.new({:name => "Epicodus"})
      test_station3.save()
      expect(Station.all()).to(eq([test_station1, test_station2, test_station3]))
    end
  end

  describe("#id") do
    it('returns id from an instance of station') do
      test_station1 = Station.new({:name => "Gresham"})
      test_station1.save()
      test_station2 =Station.new({:name => "Ruby Junction"})
      test_station2.save()
      id = test_station2.id()
      expect(id.class()).to(eq(Fixnum))
    end
  end

  describe('.find_by_id') do
    it("returns station object given its id") do
      test_station1 = Station.new({:name => "Gresham"})
      test_station1.save()
      test_station2 =Station.new({:name => "Ruby Junction"})
      test_station2.save()
      expect(Station.find_by_id(test_station1.id())).to(eq(test_station1))
    end
  end

end
