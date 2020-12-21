function solve_sample()
    solve("day20-sample.txt")
end

function solve(filename::String = "day20.txt")
    tiles = get_input(filename)
    part1solution, N, state = part1(tiles)
    println("Part 1: " * string(part1solution))
    println("Part 2: " * string(part2(tiles, N, state)))
end

function get_input(filename::String)
    str = read(open(filename), String)
    tiles = Dict{Int,Matrix{Char}}()
    for tile ∈ split(str, "\n\n")
        n = parse(Int, tile[6 : 9])
        tiles[n] = Matrix{Char}(undef, 10, 10)
        for x ∈ 1 : 10, y ∈ 1 : 10
            tiles[n][x, y] = tile[x + 11y]
        end
    end
    return tiles
end

function part1(tiles::Dict{Int64,Array{Char,2}})
    N = Int(√length(tiles))
    state = fill((0, 0), N, N)
    fix_map(tiles, state, 1, 1)
    prod(first.(state[[1, end], [1, end]])), N, state
end

function part2(tiles::Dict{Int64,Array{Char,2}}, N::Int, state::Array{Tuple{Int64,Int64},2})
    monster_str=
        "..................#." *
        "#....##....##....###" *
        ".#..#..#..#..#..#..."
    monster = reshape(collect(monster_str), (20, 3))
    
    image = Matrix{Char}(undef, 8 * N, 8 * N)
    for x∈1:N, y∈1:N
        t = rotate_reverse(tiles[state[x, y][1]], state[x, y][2])
        image[(1 : 8) .+ 8 * (x - 1), (1 : 8) .+ 8 * (y - 1)] = permutedims(t[2 : end - 1, 2 : end - 1])
    end

    max_monsters = 0;
    for i ∈ -4 : 3
        rotated_image = rotate_reverse(image, i)
        monsters_count = 0;
        for x ∈ 1 : size(rotated_image, 1) - size(monster, 1) + 1, y ∈ 1 : size(rotated_image, 2) - size(monster, 2) + 1
            found = true;
            for sx ∈ 1 : size(monster, 1), sy ∈ 1 : size(monster, 2)
                if monster[sx, sy] == '#' && rotated_image[x + sx - 1, y + sy - 1] != '#'
                    found = false
                end
            end
            monsters_count += found;
        end
        max_monsters = max(max_monsters,monsters_count)
    end
    count(image .== '#') - max_monsters * count(monster .== '#')
end

function fix_map(tiles::Dict{Int64,Array{Char,2}}, state::Array{Tuple{Int64,Int64},2}, x::Int, y::Int)
    for k∈setdiff(keys(tiles),first.(state)), i∈-4:3
        state[x,y] = (k,i);
        if ((y == 1 || matchHorizontalEdge(tiles, state[x, y - 1], state[x, y]))
            && (x == 1 || matchVerticalEdge(tiles, state[x - 1, y],state[x, y]))
            && ((x, y) == size(state) || fix_map(tiles, state, mod1(x + 1, size(state,1)), y + (x == size(state, 1)))))
            return true
        end
    end
    state[x, y] = (0, 0)
    false
end

function rotate_reverse(tile::Matrix{Char}, i::Int)
    i<0 ? rotl90(reverse(tile,dims = 1), i) : rotl90(tile, i)
end

function matchHorizontalEdge(tiles, t1::Tuple{Int,Int}, t2::Tuple{Int,Int})
    rotate_reverse(tiles[t1[1]], t1[2])[end, :] == rotate_reverse(tiles[t2[1]], t2[2])[1, :]
end

function matchVerticalEdge(tiles, t1::Tuple{Int,Int}, t2::Tuple{Int,Int})
    rotate_reverse(tiles[t1[1]], t1[2])[:, end] == rotate_reverse(tiles[t2[1]], t2[2])[:, 1]
end

solve_sample()
solve()