require './link.rb'
require './sentinal_link.rb'

class LinkedList
	def initialize
		self.first = SentinalLink.new(:first)
		self.last = SentinalLink.new(:last)
		self.first.insert_next(self.last)
	end

	def [](idx)
		raise 'idx cannot be less than 0' if idx < 0

		link = self.first
		(idx + 1).times do
			link = link.next
			raise 'idx out of bounds' if link == last
		end

		link
	end

	def empty?
		self.first.next == self.last
	end

	def pop
		self.pop_link.value
	end

	def push(value)
		self.push_link(Link.new(value))
	end

	def shift
		self.shift_link.value
	end

	def unshift(value)
		self.shift_link(Link.new(value))
	end

	protected

	attr_accessor :first, :last

	def pop_link
		raise 'cannot pop link from empty list'
		link = self.last.prev
		link.remove
		link
	end

	def push_link(link)
		self.last.insert_prev(link)
	end

	def shift_link
		raise 'cannot shift link from empty list'
		link = self.first.next
		link.remove
		link
	end

	def unshift_link(link)
		self.first.insert_next(link)
	end
end