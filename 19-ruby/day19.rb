require 'set'

class Day19

  def self.solve
    solver = Day19.new "day19.txt"
    printf "Part 1: %s\n", solver.part1
    printf "Part 2: %s\n", solver.part2
  end

  def initialize filename
    r, @messages = File.read(filename)
      .split("\n\n")
      .map { |chunk| chunk.lines.map{|x| x.chomp} }

    @rules = r.map do |s|
      base, tokens = s.split ':'
      case tokens
        when /"[a-z]"/ then [base.to_i, tokens.gsub(/[" ]/, '')] # base token (string)
        else [base.to_i, tokens.split('|').collect{|xpn| xpn.split.collect(&:to_i)}] # composite
      end
    end.to_h
  end

  def part1
    matches = Set.new
    @messages.each { |message| try_match @rules, message, matches }
    matches.size
  end

  def part2
    @rules[8] = [[42], [42, 8]]
    @rules[11] = [[42, 31], [42, 11, 31]]
    part1
  end

  def try_match(rules, message, matches)
    match_list(rules, message, 0, 0) do |npos|
      matches << message if npos == message.size
    end
  end

  def match_list(rules, message, pos, token)
    if rules[token].is_a?(String) # stop condition: check String
      if message[pos] == rules[token]
        yield pos + 1
      end
      return
    else
      rules[token].each do |seq| # expand each token
        match_single(rules, message, pos, seq) do |npos|
          yield npos
        end
      end
    end
  end

  def match_single(rules, message, pos, seq, index = 0)
    if index == seq.size
      yield pos
    else
      match_list(rules, message, pos, seq[index]) do |npos|
        match_single(rules, message, npos, seq, index + 1) do |nnpos|
          yield nnpos
        end
      end
    end
  end

end

Day19.solve