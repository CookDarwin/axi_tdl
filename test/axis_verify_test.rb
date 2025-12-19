require 'axi_tdl'
require 'minitest/autorun'

class TestAxisVerify < MiniTest::Unit::TestCase
  def setup
    @length = 100
    @itr = AxiTdl::AxisVerify::Iteration.new(length: @length, data: (0...100).to_a , vld_perc: 50,user:[0], keep:[1] , rand_seed: 0 ,dsize: 8, usize: 1)
    # @itr.to_a.each do |e|
    #     p e  
    # end
    # @itr.stream_context.each do |e|
    #     puts e
    # end
  end

  def test_length
    length = @itr.stream_context.size 
    # @itr.to_a.each do |e|
    #     p e
    # end
    assert_in_delta @length/(0.50), @length*2, 100
  end

  def test_valid 
    vld_collect = @itr.to_a.map do |e| 
        e[1] 
    end 

    assert_equal vld_collect.uniq.sort, [0,1].sort

  end

  def test_last 
    last_collect = @itr.to_a.map do |e| 
        e[4] 
    end 

    assert_equal last_collect.last, 1
    last_collect.pop
    assert_equal last_collect.uniq, [0]

  end

  def test_data 
    data_collect = @itr.to_a.map do |e| 
        e.last 
    end 

    base_data = (0...100).to_a

    assert_equal base_data.uniq.size, (base_data+data_collect).uniq.size
  end

end

