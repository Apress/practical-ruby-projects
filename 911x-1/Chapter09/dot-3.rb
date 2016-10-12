require 'rubygems'
require 'rparsec'

module Dot
  extend Parsers

  class AST < Struct; end
  AST.new("Integer", :value)
  AST.new("Call", :target, :name)

  Dot = string(".")
  Word = word
  Integer = integer.map{|x| AST::Integer.new(x) }
  CallChain = sequence(Dot, Word).many
  Expr = sequence(Integer, CallChain)
  Parser = Expr << eof
end

puts Dot::Parser.parse("4.inc.recip").inspect