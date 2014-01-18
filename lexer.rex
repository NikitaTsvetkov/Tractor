class Lexical
macro
  SHARP		\# 
  LEFT_P	\(
  RIGHT_P	\)
  COMMA		\,
  STRING    [\w\d\s\:]+ 
  BLANK     [\s\t\n]+
  	
 
rule
  {STRING}     { [:STRING, text.to_s ]}  
  {SHARP}	   { [:SHARP, text.to_s ]}
  {COMMA}	   { [:COMMA, text.to_s ] }
  {LEFT_P}	   { [:LEFT_P, text.to_s] }
  {RIGHT_P}	   { [:RIGHT_P, text.to_s] }
  
  {BLANK}      # no action
  
inner
  def scan_str(code)
    scan_setup(code)
    tokens = []
    while token = next_token      
      if token[0] == :LEFT_P and tokens[-1][0] != :SHARP
        passive_string = ""
        i = 1
        while i != 0
          token = next_token
          i += 1 if token[0] == :LEFT_P
          i -= 1 if token[0] == :RIGHT_P
          passive_string += token[1].to_s 
        end
        tokens << [:PASSIVE, passive_string[0..-2]]
        
      else   
        tokens << token
      end
    end
    tokens
  end
end