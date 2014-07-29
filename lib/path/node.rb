class Node
  attr_accessor :weight, :neighbors

  def initialize(weight: weight, neighbors: [])
    @weight    = weight
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
