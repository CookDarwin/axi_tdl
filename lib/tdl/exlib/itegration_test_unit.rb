
class ItegrationTestUnit 
    "
    test unit in Itgt
    "
    attr_accessor :path,:block,:itgt,:name
    def initialize(name: 'tmp',path: '',block: Proc.new , itgt: nil )
        @path = path 
        @block = block 
        @itgt = itgt
        @name = name
    end
end