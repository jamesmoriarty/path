class Node
  attr_accessor :weight, :neighbors

  def initialize(weight: weight, neighbors: [])
    @weight    = weight
    @neighbors = neighbors
  end

  def self.bf_search(start)
    open = Array.new
    open.push(start)

    distance = Hash.new
    distance[start] = 0

    while(current = open.shift)
      current.neighbors.each do |neighbor|
        unless distance[neighbor]
          distance[neighbor] = distance[current] + 1
          open.push(neighbor)
        end
      end
    end

    return distance
  end
end
