class Vertex
	def initialize(value)
		@value = value
		@outward_edges = []
		@inward_edges = []
	end
end

class Edge
	attr_reader :from_vertex, :to_vertex, :cost

	def initialize(from_vertex, to_vertex, cost = 1)
		@from_vertex = from_vertex
		@to_vertex = to_vertex
		@cost = cost
		@from_vertex.outward_edges << self
		@to_vertex.inward_edges << self
	end

	def destroy
		@from_vertex.outward_edges.delete(self)
		@to_vertex.inward_edges.delete(self)
		@from_vertex = nil
		@to_vertex = nil
	end
end

def dykstras(start_vertex)
	final_paths = {}
	possible_paths = {
		start_vertex => {
			prev_edge: nil,
			total_cost: 0
		}
	}

	while true
		min_vertex, min_data = possible_paths.min_by { |_, v| v[:total_cost] }
		break if min_vertex.nil?

		final_paths[min_vertex] = min_data
		possible_paths.delete(min_vertex)

		min_vertex.edges.each do |edge|
			next_vertex = (edge.to_vertex == min_vertex) ? edge.from_vertex : edge.to_vertex
			next_cost = min_data[:total_cost] + edge.cost

			next_data = possible_paths[:next_vertex]

			unless next_data && next_data[:total_cost] < next_cost
				possible_paths[next_vertex] = {
					prev_edge: edge,
					total_cost: next_cost
				}
			end
		end
	end

	final_paths
end