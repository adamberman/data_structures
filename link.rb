class Link
	attr_accessor :value
	attr_reader :prev, :next

	def initialize(value)
		self.value = value
	end

	def insert_prev(link)
		raise 'link is not detached' unless link.is_detached?

		link.prev = self.prev
		link.next = self
		self.prev.next = link if self.prev
		self.prev = link
	end

	def insert_next(link)
		raise 'link is not detached' unless link.is_detached?

		link.next = self.next
		link.prev = self
		self.next.prev = link if self.next
		self.next = link
	end

	def is_detached?
	end

	def remove
	end

	protected

	attr_writer :prev, :next
end