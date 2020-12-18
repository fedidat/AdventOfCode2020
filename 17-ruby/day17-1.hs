import qualified Data.Map as Maps
import qualified Data.Set as Sets

type Point = (Int, Int, Int)

type Cube = Sets.Set (Point)

main :: IO ()
main = do
  file <- readFile("day17.txt")
  let input = parse(file)
  print ("Part 1: " ++ show(part1(input)))

parse :: String -> Cube
parse = process 0 0 Sets.empty

--accumulate points for each char
process :: Int -> Int -> Sets.Set (Point) -> [Char] -> Sets.Set (Point)
process _ _ set "" = set
process x y set (point:input) =
  case point of
    '#'  -> process (succ x) y (Sets.insert (x, y, 0) set) input
    '.'  -> process (succ x) y set input
    '\n' -> process 0 (succ y) set input
    _    -> error "Invalid character"

--execute 6 rounds
part1 :: Cube -> Int
part1 = Sets.size . (!! 6) . iterate reactorcycle

--union original set with all neighbors, filtered by activation rules
reactorcycle :: Cube -> Cube
reactorcycle s =
  let ns = neighbors s
   in Sets.union
        (Maps.keysSet (Maps.filter (`elem` [2, 3]) (ns `Maps.restrictKeys` s)))
        (Maps.keysSet (Maps.filter (== 3) (ns `Maps.withoutKeys` s)))

--generate all blocks within 1 distance in any axis except self
neighbors :: Cube -> Maps.Map (Point) Int
neighbors s =
  Maps.unionsWith
    (+)
    [ Maps.mapKeys (\(x, y, z) -> (x + dx, y + dy, z + dz)) m
    | let m = Maps.fromSet (const 1) s
    , dx <- [-1, 0, 1]
    , dy <- [-1, 0, 1]
    , dz <- [-1, 0, 1]
    , dx /= 0 || dy /= 0 || dz /= 0
    ]
