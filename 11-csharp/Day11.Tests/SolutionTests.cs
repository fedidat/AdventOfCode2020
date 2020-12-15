using System;
using Xunit;

namespace Day11.Tests
{
    public class SampleTest
    {
        [Fact]
        public void Part1()
        {
            int result = Solution.part1("input/Day11-sample.txt");
            Assert.Equal(37, result);
        }

        [Fact]
        public void Part2()
        {
            int result = Solution.part2("input/Day11-sample.txt");
            Assert.Equal(26, result);
        }
    }
    public class RealTest
    {
        [Fact]
        public void Part1()
        {
            int result = Solution.part1("input/Day11.txt");
            Assert.Equal(2299, result);
        }

        [Fact]
        public void Part2()
        {
            int result = Solution.part2("input/Day11.txt");
            Assert.Equal(2047, result);
        }
    }
}
