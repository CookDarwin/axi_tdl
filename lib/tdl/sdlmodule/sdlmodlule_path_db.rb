require 'sqlite3'
module AxiTdl

    module SdlmodulePathDB 
        DB_PATH = File.join(__dir__, "../auto_script/tmp/sdlmodule_path_map.db" )
        TARGET = SQLite3::Database.new DB_PATH

        def self.ceate_sdlmoule_path_table

            tabel = nil
            TARGET.execute("SELECT count(*) FROM sqlite_master WHERE type='table' AND name='sdlmoule_mtime_path';") do |row|
                tabel_exist = row 
                break
            end

            # Create a table
            unless table 
                rows = TARGET.execute <<-SQL
                    create table sdlmoule_mtime_path (
                        name varchar(128),
                        path varchar(1024),
                        grade varchar(5),
                        blog varchar(50)
                    );
                SQL
            end

            
        end


    end

end