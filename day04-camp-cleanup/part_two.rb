class AssignmentOverlapFinder
  def initialize(assignment_list_path)
    @assignment_list_path = assignment_list_path
    @overlap_indexes = []
    @partial_overlap_indexes = []
  end

  def count_overlapping_pairs
    get_assignments
    find_overlaps
    announce_overlap_total
  end

  def count_partial_overlaps
    get_assignments
    find_partial_overlaps
    announce_partial_overlap_total
  end

  def get_assignments
    @assignments = []
    File.foreach(@assignment_list_path) { |line|
      pair = line.chomp.split(",")
      ranges = pair.map { |assignment|
        first, last = assignment.split("-")
        first.to_i..last.to_i
      }
      @assignments << ranges
    }
  end

  def find_overlaps
    @assignments.each_with_index { |pair, idx|
      if pair[0].cover?(pair[1]) || pair[1].cover?(pair[0])
        @overlap_indexes << idx
      end
    }
  end

  def find_partial_overlaps
    @assignments.each_with_index { |pair, idx|
      if overlaps?(*pair) || overlaps?(pair.last, pair.first)
        @partial_overlap_indexes << idx
      end
    }
  end

  def announce_overlap_total
    puts "There were #{@overlap_indexes.size} pairs wasting effort."
  end

  def announce_partial_overlap_total
    puts "There were #{@partial_overlap_indexes.size} pairs only wasting some effort."
  end

  def overlaps?(main, other)
    main.cover?(other.first) || other.cover?(main.first)
  end
end

overlap_finder = AssignmentOverlapFinder.new(ARGV[0])
overlap_finder.count_overlapping_pairs
overlap_finder.count_partial_overlaps
