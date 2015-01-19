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

	def set(key, value)
		self.resize if self.count >= self.store.length

		if self.include?(key)
			self.remove(key)
		else
			self.count += 1
		end
		bucket = self.bucket_for(key)
		bucket.push([key, value])
	end

	def remove(key)
		bucket = self.bucket_for(key)
		bucket.each do |item|
			if item[0] == key
				bucket.delete(item)
				break
			end
		end
	end

	protected

	attr_writer :count
	attr_accessor :store

	def bucket_for(key, array = self.store)
		array[self.hash(key) % array.length]
	end

	def resize
		length = self.store.length * 2
		new_array = Array.new(length) { [] }
		self.store.each do |bucket|
			bucket.each do |item|
				bucket_for(item[0], new_array) << item
			end
		end

		self.store = new_array
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