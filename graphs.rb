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