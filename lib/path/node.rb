class Node
  attr_accessor :neighbors, :visited, :from, :distance, :x, :y
  alias :visited? visited

  def initialize(x: nil, y: nil, from: nil, distance: 0, neighbors: [])
    @x, @y     = x, y
    @visited   = false
    @from      = from
    @distance  = distance
    @neighbors = neighbors
  end

  def visit!
    @visited = true
  end

  def self.bf_search(start)
    start.visit!
    open = Array.new
    open.push(start)

    while(current = open.shift)
      current.neighbors.each do |neighbor|
        unless neighbor.visited?
          neighbor.visit!
          neighbor.from     = current
          neighbor.distance = current.distance + 1
          open.push(neighbor)
        end
      end
    end
  end
end
