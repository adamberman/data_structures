require './hash_map.rb'
require './linked_list.rb'

class LRUCache
	attr_reader :hits, :misses

	def initialize(size, &prc)
		@store = LinkedList.new
		@cache = HashMap.new
		@size = size
		@prc = prc

		self.hits = 0
		self.misses = 0
	end

	def [](key)
		if @cache.include?(key)
			link = @cache[key]
			link.remove
			@store.push(link.value)

			self.hits += 1

			return link.value
		end

		self.misses += 1

		@cache.delete(@store.shift) if @cache.count >= @size

		value = @prc.call(key)
		@cache[key] = @store.push(value)

		value
	end

	protected
	attr_writer :hits, :misses
end