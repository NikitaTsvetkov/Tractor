def get_char
  state = `stty -g`
  `stty raw -echo -icanon isig`

  STDIN.getc.chr
ensure
  `stty #{state}`
end

def read_str
  string = ""
  while (new_char = get_char) != "'"
    string += new_char
    if new_char.ord == 13
      puts 
    else
      print new_char 
    end
  end
  string
end

puts read_str