
class TicTacToe

    attr_accessor :board

    WIN_COMBINATIONS = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],

        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],

        [0, 4, 8],
        [2, 4, 6]
    ]

    def initialize
        self.board = Array.new(9, " ")
    end

    def display_board
        puts " #{self.board[0]} | #{self.board[1]} | #{self.board[2]} "
        puts "-----------"
        puts " #{self.board[3]} | #{self.board[4]} | #{self.board[5]} "
        puts "-----------"
        puts " #{self.board[6]} | #{self.board[7]} | #{self.board[8]} "
    end

    def input_to_index(user_input)
        user_input.to_i - 1
    end

    def move(index, token = "X")
        self.board[index] = token
    end

    def position_taken?(index)
        position = self.board[index]
        position == "X" || position == "O" ? true : false
    end

    def valid_move?(index)
        index.between?(0, 8) && !position_taken?(index) ? true : false
    end

    def turn_count
        turns = self.board.select do |token|
            token == "X" || token == "O"
        end
        turns.length
    end

    def current_player
        self.turn_count % 2 == 0 ? "X" : "O"
    end

    def turn
        print "Enter a position (1-9): "
        index = self.input_to_index(gets.chomp)
        if valid_move?(index)
            self.move(index, current_player)
            self.display_board
        else
            self.turn
        end
    end

    def won?
        result = false
        WIN_COMBINATIONS.each do |combination|
            if combination.all? {|i| self.board[i] == "X"}
                result = combination
            elsif combination.all? {|i| self.board[i] == "O"}
                result = combination
            end
        end
        result
    end

    def full?
        self.board.all? {|i| i == "X" || i == "O"} ? true : false
    end

    def draw?
        self.full? && !self.won? ? true : false
    end

    def over?
        self.won? || self.draw? ? true : false
    end

    def winner
        combo = self.won?
        
        if !combo
            nil
        elsif self.board[combo[0]] == "X"
            "X"
        elsif self.board[combo[0]] == "O"
            "O"
        end
    end

    def play
        until self.over?
            self.turn
        end

        if self.won?
            puts "Congratulations #{self.winner}!"
        elsif self.draw?
            puts "Cat's Game!"
        end
    end
end

