class Main
    # start class
    def initialize()
        @current_rm = nil #starting room
        @inventory = []
        @rooms = {}
    end

    def fill_rooms
        start_room = {description: "The Main Hall",
        exits: [["E", 2]], #command direction and room where it takes you
        actions:[["wave", nil]], items: ["barrel"]}

        second_room = {description: "The second room", exits:[["W", 1]], actions:[["wave", nil], ["hit", "barrel"]], items: []}

        @rooms = {}
        @rooms[1] = start_room
        @rooms[2] = second_room
        return start_room
    end

    def display_room
        puts
        puts @current_rm[:description]
        puts "Exits: " + @current_rm[:exits].map{|x| x[0]}. #<----block code
        join(", ")
        print ">"
    end

    def start()
        while(run)do
        end
    end

    def run()
        if @current_rm == nil
            @current_rm = fill_rooms
            display_room
        end
        print "\n>"
        input = gets.chomp()
        return false if input == 'exit'

        return true
    end
end

txt_game = Main.new

txt_game.start