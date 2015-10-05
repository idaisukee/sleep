# -*- coding: utf-8 -*-
=begin
if ARGV[0] == nil
  file = File.open('/home/daisuke/src/sleep/machigatta.csv')
else
  file = File.open(ARGV[0])
end
=end
data = ARGV[0] || '/home/daisuke/src/sleep/machigatta.csv'
file = File.open(data)
$wrong_lines = Array.new
$errors = Hash.new
def err (line_num, error_type = nil)
  $wrong_lines << line_num.to_i
  $errors.store(line_num, error_type)
end

file.each do |line|
  # print file.lineno
  cols = line.split(',')
  size = cols.size

  # comma 個數

  unless size == 11
    err(file.lineno, 'com')
  end

  # 日附

  full_date = cols[0]
  date_elems = full_date.split('/')
  unless date_elems.size == 3
    # 日附 size
    err(file.lineno, 'fds')
  end
  year = date_elems[0]
  month = date_elems[1]
  day = date_elems[2]
  unless year.match(/[0-9]{4}/)
    # 年
    err(file.lineno, 'yr')
  end
  unless month.match(/[0-9]{1,2}/)
    # 月
    err(file.lineno, 'mon')
  end
  unless day.match(/[0-9]{1,2}/)
    # 日
    err(file.lineno, 'day')
  end
    
  # 起きてゐた時間
  awake_time_col = cols[1]
  awake_times = awake_time_col.split(' ')
  awake_times.each do |awake_time|
    minutes = awake_time.split('-')
    unless minutes.size == 2
      err(file.lineno, 'ats')
    end
    minutes.each do |minute|
      unless minute.size == 4
        err(file.lineno, 'ams')
      end
      
      unless minute.match(/[0-9]{4}/)
        err(file.lineno, 'amn')
      end
    end

    meal_time_and_types = cols[2].split(' ')
    meal_time_and_types.each do |meal_time_and_type|
      unless meal_time_and_type.match(/[0-9]{4}[sk]/)
        err(file.lineno)
      end
    end
  end

  emo_scores = cols[3..-1]

  emo_scores.each do |emo_score|
    unless emo_score.to_f.abs < 3
      err(file.lineno, 'abs')
    end
    unless (emo_score.match(/-*[0-9](\.[0-9])*/) or
            emo_score == 'x')
      err(file.lineno, 'es')
    end
  end
  if $wrong_lines.include? file.lineno
    print $errors[file.lineno], ' ', file.lineno, ' ', line.chomp, "\n"
  end
end


