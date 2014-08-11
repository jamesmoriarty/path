module Path
  class Node
    attr_accessor :data, :neighbors

    def initialize(data: data, neighbors: [])
      @data      = data
      @neighbors = neighbors
    end

    def self.df_search(from, to, heuristic)
      priority = Array.new
      priority.push(to)

      steps = Hash.new
      steps[to] = 0

      while(current = priority.shift) do
        break if current.neighbors.include?(from)

        current.neighbors.each do |neighbor|
          unless steps[neighbor]
            steps[neighbor] = steps[current] + 1
            priority.push(neighbor)
            priority.sort_by! { |to| heuristic.call(to, from) }
          end
        end
      end

      return steps
    end

    def self.bf_search(from, to)
      frontier = Array.new
      frontier.push(to)

      steps = Hash.new
      steps[to] = 0

      while(current = frontier.shift) do
        break if current.neighbors.include?(from)

        current.neighbors.each do |neighbor|
          unless steps[neighbor]
            steps[neighbor] = steps[current] + 1
            frontier.push(neighbor)
          end
        end
      end

      return steps
    end
  end
end
