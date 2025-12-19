
class AxiStreamBFMParse

    attr_reader   :hash

    def initialize(yaml_file)
        @hash = YAML::load(File.open(yaml_file))
    end

end
