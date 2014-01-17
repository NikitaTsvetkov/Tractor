module Functions
  def get_char
    state = `stty -g`
    `stty raw -echo -icanon isig`
  
    STDIN.getc.chr
  ensure
    `stty #{state}`
  end
  
  def get_marker_symbol i
    (i + 127).chr
  end
  
  def print_str str
    print str
    nil
  end
  
  def read_str
    gets.chomp
  end
  
  def nil_value 
    nil
  end
  
  def add x , y
    x.to_i + y.to_i
  end
  
  def mul x , y
    x.to_i * y.to_i
  end
  
  def sub x , y
    x.to_i - y.to_i
  end
  
  def div x , y
    x.to_i / y.to_i
  end
  
  def concat first, second
    first.to_s + second.to_s
  end
  #comparison
  def greater first, second, branch_1, branch_2
    if first.to_i > second.to_i
       parse(branch_1)
    else 
       parse(branch_2)
    end
  end
  
  def equals first, second, branch_1, branch_2
    if first.to_i == second.to_i 
       parse(branch_1)
    else 
       parse(branch_2)
    end
  end
  
  def less first, second, branch_1, branch_2
    if first.to_i < second.to_i 
       parse(branch_1)
    else 
       parse(branch_2)
    end
  end
  
  #----------
  
  def define name, string
    self.forms_array[name.to_sym] = string
  end
  
  def segment_string name, *args
    i = 1
    args.each do |string|
      self.forms_array[name.to_sym].gsub!(Regexp.new(string) , get_marker_symbol(i))
      i += 1
    end
  end
  
  def call name , *args
    temp_string = String.new(self.forms_array[name.to_sym])
    i = 1
    args.each do |arg|
      temp_string.gsub!(Regexp.new(get_marker_symbol(i)), arg)
      i += 1
    end
    temp_string.each_char.inject("")  do |accum, char|
      if char.ord <= 127
        accum = accum + char
      else
        accum = accum + "##(nil)"
      end  
      accum
    end
  end 
  
  def trace_on
    debug = true
  end
  
  def trace_off
    debug = false
  end
end