class InventoryAuditor
  UPPERCASE_OFFSET = 96
  LOWERCASE_OFFSET = 38

  def initialize(inventory_list_path)
    @inventory_list_path = inventory_list_path
    @mistakes = []
    @priority_totals = 0
  end

  def find_mistakes
    File.foreach(@inventory_list_path) { |rucksack|
      _, compartment1, compartment2 = rucksack.partition(/.{#{rucksack.length/2}}/)
      mistake = (compartment1.chars & compartment2.chars).join
      priority = calculate_priority(mistake)
      @mistakes << [mistake, priority]
      @priority_totals += priority
    }
  end

  def calculate_priority(mistake)
    char_code = mistake.ord
    (char_code - UPPERCASE_OFFSET).negative? ? char_code - LOWERCASE_OFFSET : char_code - UPPERCASE_OFFSET
  end

  def announce_priority_totals
    puts "The packer intern messed up with a total priority of #{@priority_totals}."
  end
end

auditor = InventoryAuditor.new(ARGV[0])
auditor.find_mistakes
auditor.announce_priority_totals
