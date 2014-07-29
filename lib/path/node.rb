class Node
  attr_accessor :neighbors, :from, :distance, :x, :y

  def initialize(x: nil, y: nil, from: nil, distance: nil, neighbors: [])
    @x, @y     = x, y
    @from      = from
    @distance  = distance
    @neighbors = neighbors
  end

  def self.bf_search(start)
    start.distance = 0

    open    = Array.new
    open.push(start)

    visited = Hash.new
    visited[start] = true

    while(current = open.shift)
      current.neighbors.each do |neighbor|
        unless visited[neighbor]
          visited[neighbor] = true
          neighbor.from     = current
          neighbor.distance = current.distance + 1
          open.push(neighbor)
        end
      end
    end
  end
end
