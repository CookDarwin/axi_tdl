
class AxiStream

    def slice_to_logic(range)
        @_slice_id_ ||= 0
        smin = range.min
        smax = range.max
        if range.to_a.first.eql? smin
            cc  = :increase
        else
            cc  = :decrease
        end
        slice_logic = nil
        RedefOpertor.with_normal_operators do
            slice_logic = belong_to_module.Def().logic(name:"#{name}_slice_#{@_slice_id_}",dsize:@dsize*(smax+1-smin))
            slice_logic.clock   = @clock
            slice_logic.reset   = @reset
            belong_to_module.AxiStream_draw << slice_to_logic_draw(cc,slice_logic,range.to_a)
        end
        @_slice_id_ += 1
        return slice_logic
    end

    private

    def slice_to_logic_draw(cc,logic_s,slice_a)
        @_generate_block_index_ ||= []
        if cc == :decrease
            mstr = slice_a.map do |e|
                sub_slice_to_logic_draw(logic_s,e,@dsize,e)
            end.join("")
        else
            smax = slice_a.max
            mstr = slice_a.map do |e|
                sub_slice_to_logic_draw(logic_s,e,@dsize,smax-e)
            end.join("")
        end

        index = 0

        while(true)
            index = rand(1024)
            unless @_generate_block_index_.include? index
                break
            end
        end
        @_generate_block_index_ << index
"
generate
begin:#{signal}_SLICE_TO_LOGIC_#{index}
always@(negedge #{align_signal(@clock,q_mark=false)})begin
// always_comb begin
    #{mstr}
end
end
endgenerate
"
    end

    def sub_slice_to_logic_draw(logic_s,index,pindex,lindex)
        # quan = logic_s.[@dsize+lindex*pindex-1,lindex*pindex]
        # puts @dsize,lindex,pindex
        quan = logic_s.[](@dsize+lindex*pindex-1,lindex*pindex)
"
    if(#{vld_rdy} && #{axis_tcnt} == #{index})begin
        #{quan} = #{axis_tdata};
    end
"
    end

end
