module Path
  class Node
    attr_accessor :data, :neighbors

    def initialize(data: data, neighbors: [])
      @data    = data
      @neighbors = neighbors
    end

    def self.bf_search(start)
      open = Array.new
      open.push(start)

      distances = Hash.new
      distances[start] = 0

      while(current = open.shift)
        current.neighbors.each do |neighbor|
          unless distances[neighbor]
            distances[neighbor] = distances[current] + 1
            open.push(neighbor)
          end
        end
      end

      return distances
    end
  end
end
