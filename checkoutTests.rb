require 'test/unit'

class TestCheckout < Test::Unit::TestCase
	def test_scan_one_a_total_is_50
		Checkout.new(self)
			.scan('A')
			.total()
		assert_equal(50, @total)
	end

	def test_scan_one_b_total_is_30
		Checkout.new(self)
			.scan('B')
			.total()
		assert_equal(30, @total)
	end

	def test_scan_one_c_total_is_60
		Checkout.new(self)
			.scan('C')
			.total()
		assert_equal(60, @total)
	end

	def test_scan_one_d_total_is_99
		Checkout.new(self)
			.scan('D')
			.total()
		assert_equal(99, @total)
	end

	def test_scan_two_a_total_is_100
		Checkout.new(self)
			.scan('A')
			.scan('A')
			.total()
		assert_equal(100, @total)
	end

	def test_scan_one_a_one_b_one_c_one_d_total_is_239
		Checkout.new(self)
			.scan('A')
			.scan('B')
			.scan('C')
			.scan('D')
			.total()
		assert_equal(239, @total)
	end

	def test_scan_three_a_special_offer_total_is_130
		Checkout.new(self)
			.scan('A')
			.scan('A')
			.scan('A')
			.total()
		assert_equal(130, @total)
	end

	def test_scan_two_b_special_offer_total_is_45
		Checkout.new(self)
			.scan('B')
			.scan('B')
			.total()
		assert_equal(45, @total)
	end

	def test_scan_six_a_special_offer_total_is_260
		Checkout.new(self)
			.scan('A')
			.scan('A')
			.scan('A')
			.scan('A')
			.scan('A')
			.scan('A')
			.total()
		assert_equal(260, @total)
	end

	def test_scan_four_b_special_offer_total_is_90
		Checkout.new(self)
			.scan('B')
			.scan('B')
			.scan('B')
			.scan('B')
			.total()
		assert_equal(90, @total)
	end

	def show_total(total)
		@total = total
	end
end

class Checkout
	def initialize(display)
		# constructor
		@display = display
		@a_count = 0
		@b_count = 0
	end

	def scan(q)
		# need to make sure total is initialised.. otherwise things go bang
		ensure_set_i
		if (q == 'A')
			@i += 50
			@a_count+=1
		end
		if (q == 'B')
			@i += 30
			@b_count+=1
		end
		if (q == 'C')
			@i += 60
		end
		if (q == 'D')
			@i += 99
		end
		return self
	end

	def ensure_set_i
		# is it set?
		if (@i.nil?)
			@i = 0
		end
	end

	def total
		if (@a_count == 3)
			@i -= (@a_count == 3) ? 20 : 0
		else
			# need to make sure we deal with multiple A SOs
			@i -= (@a_count % 3 == 0) ? @a_count / 3 * 20 : 0
		end
		# b specials
		@i -= (@b_count == 2 || @b_count % 2 == 0) ? @b_count /2 * 15 : 0
		@display.show_total(@i)
	end
end