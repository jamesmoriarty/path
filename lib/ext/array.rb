class Array
  def axis_x
    self
  end

  def to_nodes
    nodes = axis_x.each_with_index.map do |axis_y, x|
      axis_y.each_with_index.map do |weight, y|
        Node.new(x: x, y: y) if weight
      end
    end

    nodes.each_with_index do |axis_y, x|
      axis_y.each_with_index do |node, y|
        next unless node

        [
          [ 0, -1], # up
          [ 1,  0], # right
          [-1,  0], # left
          [ 0,  1]  # down
        ].each do |offset_x, offset_y|
          current_x = x + offset_x
          if 0 <= current_x && nodes[current_x]
            current_y = y + offset_y
            if 0 <= current_y && neighbor = nodes[current_x][current_y]
              next if neighbor == node
              node.neighbors << neighbor
            end
          end
        end
      end
    end
  end
end
