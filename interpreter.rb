require './parser.rb'
 
class Interpreter
  def print
    @evaluator = StringExecutor.new
    @evaluator.parse("##(print_str,#(equals,1,2,(##(add,2,3)),(##(print_str,hehehey))))") ###(print_str, ##(add, 3 , ##(sub, 2, 1)))
    @evaluator.parse "##(define,mul3,(#(mul,A,#(mul,B,C))))"
    @evaluator.parse "##(segment_string,mul3,A,B,C)"
    p @evaluator.forms_array
    @evaluator.parse "##(print_str,#(call,mul3,2,3,4))"
  end
end


#there will be init

Interpreter.new().print 