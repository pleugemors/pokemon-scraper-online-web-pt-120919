class Pokemon

    attr_accessor :id, :name, :type, :db
    def initialize(id: nil, name: nil, type: nil, db: nil)
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def self.save(name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon (name, type) VALUES
                (?, ?)
        SQL
        db.execute(sql, name, type)
    end

    def self.find(id, db)
        sql = <<-SQL
            SELECT * FROM pokemon 
            WHERE id = ?
            LIMIT 1
        SQL

        new_pokemon = Pokemon.new
        db.execute(sql, id).each do |row|
            new_pokemon = Pokemon.new_from_db(row)
        end
        new_pokemon
    end

    def self.new_from_db(row)
        new_pokemon = Pokemon.new(name: row[1], type: row[2], id: row[0])
        new_pokemon        
    end
end
