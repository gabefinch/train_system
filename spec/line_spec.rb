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
end
