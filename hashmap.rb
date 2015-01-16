class HashMap
	def initialize
		@store = []
		@numBuckets = 12
	end

	def resize
		@numBuckets *= 2
		@numBuckets.times { @store << [] }
		# add elements back to buckets
	end

	# would be more advanced, but for the purposes of this, 
	# I'll stringify, then get each numbers ASCII key, then 
	# concat those keys together
	def hash(key)
		ascii_keys = [] 
		key.to_s.each_byte { |el| ascii_keys << el }
		ascii_keys.map { |el| el.to_s }.join('')
	end
end