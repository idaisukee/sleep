# -*- coding: utf-8 -*-
require 'date'

data = ARGV[0] || '/home/daisuke/src/sleep/machigatta.csv'
file = File.open(data)
$wrong_lines = Array.new
$errors = Hash.new
def err (line_num, error_type = nil)
  $wrong_lines << line_num.to_i
  
  $errors[line_num] ||= Array.new
  $errors[line_num] <<  error_type
  
end


class String
  @@err_code_to_msg = {
    'com' => 'コンマの数',
    'yr' => '年',
    'mon' => '月',
    'day' => '日',
    'hr' => '時',
    'min' => '分',
    'ams' => '起きていた時間の時刻桁数',
    'amn' => '起きていた時間の時刻',
    'mtt' => '食事時刻',
    'abs' => '気分得点の絶対値',
    'es' => '気分得点',
  }

  def to_msg
    @@err_code_to_msg[self] or self
  end

  def cut_sgn
    if self[0] == '-'
      self[1..-1]
    else
      self
    end
  end

  def before_dot
    self.split('.')[0]
  end
  
  def after_dot
    self.split('.')[1]
  end
end

print 'com'.to_msg
file.each do |line|
  # print file.lineno
  
  cols = line.chomp.split(',')
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
    
  begin
    Date.new(year.to_i, month.to_i, day.to_i)
  rescue => e
    err(file.lineno, 'date')
  end

  # 起きてゐた時間
  awake_time_col = cols[1]
  awake_times = awake_time_col.split(' ')
  awake_times.each do |awake_time|
    minutes = awake_time.split('-')
    minutes.each do |minute|
      hr = minute[0..1].to_i
      min = minute[2..3].to_i
      begin
        Time.new(year.to_i, month.to_i, day.to_i, hr, min)
      rescue => e
        err(file.lineno, 'time')
      end

      unless hr.between?(0, 24)
        err(file.lineno, 'hr')
      end
      unless min.between?(0,60)
        err(file.lineno, 'min')
      end
    end
    
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
      unless meal_time_and_type.match(/[0-9]{4}[sk]/) or meal_time_and_type == 'x'
        err(file.lineno, 'mtt')
      end
    end
  end

  emo_scores = cols[3..-1]

  emo_scores.each do |emo_score|
    digits = emo_score.split('')
    unless emo_score.cut_sgn.before_dot.match(/[0-9]{1,}/)
      err(file.lineno, 'bef')
    end
    if emo_score.cut_sgn.size > 1
      unless emo_score.cut_sgn.after_dot.match(/[0-9]{1,}/)
        err(file.lineno, 'aft')
      end
    end

    unless emo_score.to_f.abs < 100
      err(file.lineno, 'abs')
    end
    unless (emo_score.match(/-{0,1}[0-9]\.[0-9])*/)) or
            emo_score == 'x')
      err(file.lineno, 'es')
    end
  end

  if $wrong_lines.include? file.lineno
    print $errors[file.lineno].uniq.map{|x| x.to_msg}.join(','), ' ', file.lineno, ' ', line.chomp, "\n"


  end
end
