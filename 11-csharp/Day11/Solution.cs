using System;
using System.IO;
using System.Collections.Generic;

namespace Day11 {
    class Point{
        public int row, col;
        public Point(int row, int col) {
            (this.row, this.col) = (row, col);
        }
        public Point Add(Point p) {
            this.row += p.row;
            this.col += p.col;
            return this;
        }
        public override bool Equals(Object obj)
        {
            if ((obj == null) || ! this.GetType().Equals(obj.GetType()))
                return false;
            else
                return (row == ((Point) obj).row) && (col == ((Point) obj).col);
        }
        public override int GetHashCode()
        {
            return (row << 2) ^ col;
        }
    }

    class Grid {
        Dictionary<Point, int> last = new Dictionary<Point, int>(), grid = new Dictionary<Point, int>();
        private readonly List<Point> adj = new List<Point>()
        {
            new Point(-1,-1), new Point(-1,0), new Point(-1,1), new Point(0,-1),
            new Point(0,1), new Point(1,-1), new Point(1,0), new Point(1,1)
        };

        public Grid(string[] input) {
            for (int i=0; i<input.Length; i++)
                for (int j=0; j<input[0].Length; j++)
                    this.grid[new Point(i, j)] = input[i][j];
        }

        public int Neighbors(Point p, bool visible = false) {
            int count = 0;
            foreach(var offset in adj){
                Point toEval = new Point(p.row, p.col);
                if(visible)
                    while(grid.GetValueOrDefault(toEval.Add(offset)) == '.');
                else
                    toEval.Add(offset);

                if (grid.GetValueOrDefault(toEval) == '#')
                    count++;
            }
            return count;
        }

        public void Round(bool visible = false) {
            var next = new Dictionary<Point, int>(grid);
            foreach (KeyValuePair<Point, int> entry in grid)
                if (grid.GetValueOrDefault(entry.Key) == 'L' && this.Neighbors(entry.Key, visible) == 0)
                    next[entry.Key] = '#';
                else if (grid.GetValueOrDefault(entry.Key) == '#' && this.Neighbors(entry.Key, visible) >= (visible ? 5 : 4))
                    next[entry.Key] = 'L';
            this.last = this.grid;
            this.grid = next;
        }

        public bool Changed() {
            foreach (KeyValuePair<Point, int> entry in grid)
                if (last.GetValueOrDefault(entry.Key) != entry.Value)
                    return true;
            foreach (KeyValuePair<Point, int> entry in last)
                if (grid.GetValueOrDefault(entry.Key) != entry.Value)
                    return true;
            return false;
        }

        public int Occupied() {
            int count = 0;
            foreach (KeyValuePair<Point, int> entry in grid)
                if (entry.Value == '#')
                    count++;
            return count;
        }
    }

    public class Solution {
        public static int part1(string filename) {
            string[] input = File.ReadAllLines(filename);
            Grid grid = new Grid(input);
            while (grid.Changed())
                grid.Round();
            return grid.Occupied();
        }
        public static int part2(string filename) {
            string[] input = File.ReadAllLines(filename);
            Grid grid = new Grid(input);
            while (grid.Changed())
                grid.Round(true);
            return grid.Occupied();
        }

        static void Main(string[] args) {
            int part1Result = part1("input/Day11.txt");
            Console.WriteLine("Part 1: " + part1Result + " occupied seats after stabilization");
            int part2Result = part2("input/Day11.txt");
            Console.WriteLine("Part 2: " + part2Result + " occupied seats after stabilization");
        }
    }
}
