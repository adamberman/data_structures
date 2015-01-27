class BinaryMinHeap
	def initialize
		self.store = []
		self.prc = Proc.new { |el1, el2| el1 <=> el2 }
	end

	def count
		self.store.length
	end

	def extract
		val = self.store[0]

		if self.count > 1
			self.store[0] = self.store.pop
			self.class.heapify_down(self.store, 0, self.prc)
		else
			self.store.pop
		end

		val
	end

	def peek
		self.store[0]
	end

	def push(val)
		self.store << val
		self.class.heapify_up(self.store, self.count - 1, self.prc)
	end

	def self.child_indices(length, parent_index)
		[2 * parent_index + 1, 2 * parent_index + 2].select do |idx|
			idx < length
		end
	end

	def self.parent_index(child_index)
		(child_index - 1) / 2
	end

	def self.heapify_down(array, parent_idx, length = array.length, &prc)
		l_child_idx, r_child_idx = child_indices(length, parent_idx)

		parent_val = array[parent_idx]

		children = []
		children << array[l_child_idx] if l_child_idx
		children << array[r_child_idx] if r_child_idx

		return array if children.all? { |child| prc.call(parent_val, child) <= 0 }

		swap_idx = nil
		if children.length == 1
			swap_idx = l_child_idx
		else
			swap_idx = prc.call(children[0], children[1]) == -1 ? l_child_idx : r_child_idx
		end

		array[parent_idx], array[swap_idx] = array[swap_idx], parent_val
		heapify_down(array, swap_idx, length, &prc)
	end

	def self.heapify_up(array, child_idx, length = array.length, &prc)

		return array if child_idx == 0

		parent_idx = parent_index(child_idx)
		child_val, parent_val = array[child_idx], array[parent_idx]
		if prc.call(child_val, parent_val) >= 0
			return array
		else
			array[child_idx], array[parent_idx] = parent_val, child_val
			heapify_up(array, parent_idx, length, &prc)
		end
	end

	protected

	attr_accessor :prc, :store
end