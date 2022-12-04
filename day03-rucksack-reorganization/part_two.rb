class InventoryAuditor
  UPPERCASE_OFFSET = 96
  LOWERCASE_OFFSET = 38

  def initialize(inventory_list_path)
    @inventory_list_path = inventory_list_path
    @rucksacks = []
    @mistakes = []
    @mistake_priority_totals = 0
    @badge_priority_totals = 0
    @badges = []
  end

  def audit_mistakes
    get_rucksack_inventories
    find_mistakes
    calculate_mistake_priority_totals
    announce_mistake_priority_totals
  end

  def audit_badges
    get_rucksack_inventories
    find_group_badges
    calculate_badge_priority_totals
    announce_badge_priority_totals
  end

  private

  def get_rucksack_inventories
    @rucksacks = []
    File.foreach(@inventory_list_path) { |rucksack|
      @rucksacks << rucksack
    }
  end

  def find_mistakes
    @rucksacks.each { |rucksack|
      _, compartment1, compartment2 = rucksack.partition(/.{#{rucksack.length/2}}/)
      @mistakes << (compartment1.chars & compartment2.chars).join
    }
  end

  def find_group_badges
    @rucksacks.each_slice(3) { |group|
      @badges << (group[0].chars & group[1].chars & group[2].chars).join.chomp
    }
  end

  def calculate_mistake_priority_totals
    @mistakes.each { |mistake|
      @mistake_priority_totals += calculate_priority(mistake)
    }
  end

  def calculate_badge_priority_totals
    @badges.each { |badge|
      @badge_priority_totals += calculate_priority(badge)
    }
  end

  def calculate_priority(mistake)
    char_code = mistake.ord
    (char_code - UPPERCASE_OFFSET).negative? ? char_code - LOWERCASE_OFFSET : char_code - UPPERCASE_OFFSET
  end

  def announce_mistake_priority_totals
    puts "The packer intern messed up with a total priority of #{@mistake_priority_totals}."
  end

  def announce_badge_priority_totals
    puts "The absent-minded badge authenticator forgot to place stickers on badges with a total priority by group of #{@badge_priority_totals}"
  end
end

auditor = InventoryAuditor.new(ARGV[0])
auditor.audit_mistakes # personal challenge of keeping the functionality from part_one while doing part_two
auditor.audit_badges
