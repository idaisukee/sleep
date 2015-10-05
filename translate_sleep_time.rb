source = "sleep_example_2.csv"

true_awake_ranges = Array.new

File.open(source) do |file|
  file.each_line do |line|
    full_date = line.split(",")[0]
    month = full_date.split("/")[0]
    date = full_date.split("/")[1]
    true_full_date = Date.new(2013, month, date)
    time_cell = line.split(",")[1].strip
    # => "0900-1000 1300-2000"
    awake_ranges = time_cell.split(" ")
    # => ["0900-1000", "1300-2000"]
    true_awake_ranges = awake_ranges.map do |awake_range|
      Range.new(awake_range.split("-")[0], awake_range.split("-")[1])
    end
    
    
    one_day = Range(day_origin, day_end)

  end
end

p true_awake_ranges
