require './DateCol'
data = './year_test.csv'

begin
  b = Year.new(1998)
  p b
  p b.to_s
  p b.valid?
rescue
end
  c = Year.new("1997")
p c
  p c.to_s
  p c.valid?




File.open(data) do |file|
  file.each do |line|
    target = line.chomp.split(',')[0]
    a = Year.new(target)
    p a.to_s
    p a.valid?
  end
end
