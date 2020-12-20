require_relative "day19"
require "test/unit"

class Day19Test < Test::Unit::TestCase
    
    def test_part1_sample
      assert_equal(2, Day19.new("day19-samplep1.txt").part1)
    end
    
    def test_part2_sample
      assert_equal(12, Day19.new("day19-samplep2.txt").part2)
    end
    
    def test_part1
      assert_equal(180, Day19.new("day19.txt").part1)
    end
    
    def test_part2
      assert_equal(323, Day19.new("day19.txt").part2)
    end

end