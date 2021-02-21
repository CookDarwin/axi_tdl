# require_relative '../prj_lib.rb'
require "yaml"
require_relative 'sdl_impl_module.rb'
require_relative 'sdl_impl_param.rb'

class TdlTest

    def self.test0

        hash = YAML::load(File.open('resource.yml'))
        hash.delete('params')
        hash.delete('implement')
        # puts hash['Mac_1G()']
        hash.each do |k,v|
            SdlImplModule.new(k,v)
        end

        # puts SdlImplModule.modules_hash('Mac_1G()')
        puts SdlImplModule.modules_hash('Mac_1G()').dependent
    end

    def self.test1

        hash = YAML::load(File.open('resource.yml'))
        hash.delete('params')
        hash.delete('implement')
        # puts hash['Mac_1G()']
        hash.each do |k,v|
            SdlImplModule.new(k,v)
        end

        # puts SdlImplModule.modules_hash('Mac_1G()')
        sure_array = SdlImplModule.modules_hash('ModuleTempSensorTpu').dependent(sure:true)

        use_array = SdlImplModule.modules_hash('ModuleTempSensorTpu').dependent(sure:false,pool: sure_array.flatten )

        dep_array = SdlImplModule.inspect_dependent_verb(0,use_array)

        File.open("tmp_log.yml",'w') do |f|
            f.puts dep_array
        end
    end

    def self.test2
        hash = YAML::load(File.open('resource.yml'))
        pm = SdlImplParam.new(hash['params'])

        # hash.delete('params')
        # hash.delete('implement')
        # puts hash['Mac_1G()']
        hash.each do |k,v|
            SdlImplModule.new(k,v)  if(k != 'params') && (k != 'implement')
        end

        SdlTopImplement.new("tmp_impl",__dir__,hash['implement']['modules'],hash['implement']['tb'],pm,'./pins.yml')
    end

    def self.test3
        SdlTopImplement.build("custom_200T_1221","./resource.yml")
    end
end


Test.test3
