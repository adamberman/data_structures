class HashMap

	attr_reader :count

	def initialize
		self.store = Array.new(12) { [] }
		self.count = 0
	end

	def include?(key)
		bucket = self.bucket_for(key)
		bucket.include?(key)
	end

	def get(key)
		if self.include?(key)
			bucket = self.bucket_for(key)
			bucket.each do |item|
				return item[1] if key == item[0]
			end
		end
		
		nil
	end

	def insert(key, value)
	end

	def remove(key)
	end

	protected

	def bucket_for(key)
	end

	def resize
	end

	# would be more advanced, but for the purposes of this, 
	# I'll stringify, then get each numbers ASCII key, then 
	# concat those keys together
	def hash(key)
		ascii_keys = [] 
		key.to_s.each_byte { |el| ascii_keys << el }
		ascii_keys.map { |el| el.to_s }.join('')
	end

	attr_writer :count
	attr_accessor :store
end