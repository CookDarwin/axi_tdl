require "yaml"
class SdlImplParam

    def initialize(hash)
        parse_yaml(hash['yaml'])
        parse_var(hash['var'])
    end

    def parse_yaml(yaml_hash)
        yaml_hash.each do |k,v|
            instance_variable_set("@#{k}",YAML::load(File.open(v)))
            define_singleton_method(k) do
                instance_variable_get("@#{k}")
            end
        end
    end

    def parse_var(var_hash)
        var_hash.each do |k,v|
            define_singleton_method(k) do
                v
            end
        end
    end

end
