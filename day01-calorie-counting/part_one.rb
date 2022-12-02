class ElvenCalorieCounter
  def initialize(file_input_path)
    @file_input_path = file_input_path
    @heaviest_index = 0
    @heaviest_total = 0
    @current_index = 0
    @current_total = 0
    @elves = []
  end

  def inventory_elves
    File.foreach(@file_input_path) { |line|
      calories = line.chomp.to_i

      if new_elf?(calories)
        @elves << @current_total

        if @current_total > @heaviest_total
          @heaviest_total = @current_total
          @heaviest_index = @current_index
        end

        @current_total = 0
        @current_index += 1
      else
        @current_total += calories
      end
    }
  end

  def announce_hoarder
    puts "Elf ##{@heaviest_index + 1} has food with a total of #{@heaviest_total} calories. Ask them for snacks if you get hungry!"
  end

  private

  def new_elf?(calories)
    calories.zero?
  end
end

elf_tally = ElvenCalorieCounter.new(ARGV[0])
elf_tally.inventory_elves
elf_tally.announce_hoarder
