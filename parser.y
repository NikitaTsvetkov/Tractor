class StringExecutor
rule
  expression : STRING { return val[0] }
  | neutral_combination { return val[0] }
  | passive_combination { return val[0] }
  | active_combination	{ return val[0] }			
  ;
  
  args : expression { return ([] << val[0]).flatten }
  | expression COMMA args { return (([] << val[0]).flatten + ([] << val[2]).flatten).flatten  } 
  ;

  neutral_combination : SHARP SHARP LEFT_P args RIGHT_P { 
    if @@debug
      print "\#\#(#{val[3][0]}" 
      val[3][1..-1].each { |item|  print("," + item.to_s) }
      print ") \n"
    end
  	res = self.send(val[3][0].to_sym, *(val[3][1..-1]))
  	return res.to_s
  }  
  ;
  
  active_combination : SHARP LEFT_P args RIGHT_P { 
    if @@debug
      print "\#(#{val[2][0]}" 
      val[2][1..-1].each { |item|  print("," + item.to_s) }
      print ") \n"
    end
  	res = self.send(val[2][0].to_sym, *(val[2][1..-1]))
  	internal_parser = StringExecutor.new
    return internal_parser.parse(res.to_s)
  } 
  ;
  
  passive_combination : PASSIVE { return val[0] } 
  ;
  
  
  
  
end
 
---- header
  require_relative 'lexer'
  require_relative 'functions'
---- inner
  include Functions
  @@forms = Hash.new()
  @@debug = true 
  @@marker = "'" 
  def initialize    
    @lexical = Lexical.new
    
    p @@forms if @@debug
  end
  def parse(input)
    @lol = @lexical.scan_str(input) 
    do_parse
  end

  def next_token
    @lol.shift
  end
  
  def forms_array
    @@forms
  end
  
  def debug
    @@debug
  end
  
  def marker
    @@marker
  end
  
  def debug(x)
    @@debug = x
  end
  
  def marker=(x)
    @@marker = x
  end