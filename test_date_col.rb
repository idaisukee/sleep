require './DateCol'
data = './date_col_test.csv'

File.open(data) do |file|
  file.each do |line|
    target = line.chomp.split(',')[0]
    p a = DateCol.new(file.lineno, target).to_s
    p a.valid?
  end
end
