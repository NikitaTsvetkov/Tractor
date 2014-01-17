require './parser.rb'
 
class Interpreter
  def initialize
    @evaluator = StringExecutor.new
  end
  def print
    @evaluator.parse("##(print_str,#(equals,1,2,(##(add,2,3)),(##(print_str,hehehey))))") ###(print_str, ##(add, 3 , ##(sub, 2, 1)))
    @evaluator.parse "##(define,mul3,(#(mul,A,#(mul,B,C))))"
    @evaluator.parse "##(segment_string,mul3,A,B,C)"
    @evaluator.parse "##(print_str,#(call,mul3,2,3,4))"
    @evaluator.parse "##(print_str,#(call,mul3,300,300,10))"
    
  end
  
  def console
    str = ""
    while str != "bye"
      p @evaluator.parse str if str != ""
      str = gets.chomp
    end
  end
  
  def from_file filepath
    megaline = ""
    File.open(filepath, "r") do |infile|
      while (line = infile.gets)
        megaline += line
      end
    end
    megaline.gsub! /\r\n/, ""
    megaline.gsub! /\n/, ""
    megaline.gsub! /\t/, ""
    instructions = megaline.split /\'/
    instructions.each {|str| p @evaluator.parse(str) }
  end
  
end


#there will be init
if  ARGV.empty?
  Interpreter.new().print
else 
  Interpreter.new().from_file(ARGV[0]) 
end