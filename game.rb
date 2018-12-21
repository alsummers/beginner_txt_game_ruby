class Main
    # start class
    # for regex analyze rubular
    def initialize()
        @current_rm = nil #starting room
        @inventory = []
        @rooms = {}
    end

    def fill_rooms
        start_room = {description: "The Main Hall",
        exits: [["E", 2, /^([\w]+ )e$|^([\w]+ )east$|e$|^east$/i]], #command direction and room where it takes you
        actions:[["wave", nil]], items: ["barrel"]}

        second_room = {description: "The second room", exits:[["W", 1, /^([\w]+ )w$|^([\w]+ )west$|w$|^west$/i]], actions:[["wave", nil], ["hit", "barrel"]], items: []}

        @rooms = {}
        @rooms[1] = start_room
        @rooms[2] = second_room
        return start_room
    end

    def display_room
        item_string = @current_rm[:items].length > 0 ? "Items: " + @current_rm[:items].join(", ") : ""
        puts
        puts @current_rm[:description] + "\n" + item_string + "Exits: " + @current_rm[:exits].map{|x| x[0]}. #<----block code
        join(", ")
    end

    def parse_input(input)
        result = parse_exits(input)
       return result unless result.nil?

       return "Unrecognized command"
    end

    def get_item(item)
        items = @current_rm[:items]
        if items.contains?(item)
            @inventory.push(item)
            items.delete(item)
            return "You pickup #{item}."
        end
        return nil
    end

    def parse_actions(input)
        return display_room if input =~ /^look$/i

        if input =~ /^get ([\w])+/i
            result = get_item($1)
            return result unless result.nil?
        end
        return nil
    end

    def parse_exits(input)
        exits = @current_rm[:exits]
        exit = exits.select{|x| input =~ x[2] }
        if exit.length > 1
         return "cant understand direction"
        end
        if exit.length == 1
         @current_rm = @rooms[exit[0][1]]
         return display_room
        end
        return ""
    end

    def start()
        while(run)do
        end
        puts "Thanks for playing."
    end

    def run()
        if @current_rm == nil
            @current_rm = fill_rooms
            puts display_room
        end
        print "\n>"
        input = gets.chomp()
        response = parse_input input
        puts response

        return false if input =~ /^exit.*/i

        return true
    end
end

txt_game = Main.new

txt_game.start