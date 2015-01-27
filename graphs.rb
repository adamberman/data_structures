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

def dijkstras(start_vertex)
	# for when're mathematically positive this is the best route
	final_paths = {}

	# for storing the best route so far, begin by placing the starting vertex
	possible_paths = {
		start_vertex => {

			# store the edge that gets you there, as well as the total cost from the start
			prev_edge: nil,
			total_cost: 0
		}
	}

	while true

		# find the vertex in the possible paths that has the lowest cost so far

		min_vertex, min_data = possible_paths.min_by { |_, v| v[:total_cost] }

		# if there are no more vertices...
		break if min_vertex.nil?

		# because it has the lowest cost available, it is not possible that any
		# other route could get you there quicker, so we can add that route to
		# final paths and delete it form possible paths
		final_paths[min_vertex] = min_data
		possible_paths.delete(min_vertex)

		min_vertex.edges.each do |edge|

			# go through the min vertex's edges and find the connecting vertices
			next_vertex = (edge.to_vertex == min_vertex) ? edge.from_vertex : edge.to_vertex
			
			# calculate the cost for the connecting vertex in question
			next_cost = min_data[:total_cost] + edge.cost

			# check to see if you've been to that vertex before
			next_data = possible_paths[:next_vertex]

			# if you've never been there before or your route there is cheaper,
			# add/update the vertex in possible_paths
			unless next_data && next_data[:total_cost] < next_cost
				possible_paths[next_vertex] = {
					prev_edge: edge,
					total_cost: next_cost
				}
			end

			# repeat the cycle, now with possibly many vertices in possible paths,
			# adding the shortest cost available to final_path and removing it from
			# possible_paths
		end
	end

	final_paths
end