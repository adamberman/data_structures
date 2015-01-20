require './link.rb'

class SentinalLink < Link
	def initialize(side)
		raise 'must be first or last' unless (side == :first || side == :last)
		self.side = side
	end

	def prev=(link)
		if side == :last
			return super(link)
		elsif link.nil?
		else
			raise 'cannot set prev of first sentinal'
		end
	end

	def next=(link)
		if side == :first
			return super(link)
		elsif link.nil?
		else
			raise 'cannot set next of last sentinal'
		end
	end

	def value
		raise 'sentinals do not have values'
	end

	def value=(link)
		raise 'sentinals do not have values'
	end

	def remove
		raise 'you cannot remove a sentinal'
	end

	protected

	attr_accessor :side
end