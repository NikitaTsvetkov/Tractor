require './parser.rb'
 
class Interpreter
  def initialize
    @evaluator = StringExecutor.new
  end
  def print
    @evaluator.parse("##(equals,1,2,(##(add,2,3)),(##(print_str,hehehey)))") ###(print_str, ##(add, 3 , ##(sub, 2, 1)))
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
    instructions.each {|str| @evaluator.parse(str) }
  end
  
end
Interpreter.new().print
#there will be init
#if  ARGV.empty?
#  Interpreter.new().console
#else 
  Interpreter.new().from_file("program.tr")
  Interpreter.new().console 
#end