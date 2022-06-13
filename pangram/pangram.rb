require "byebug"
module Pangram
  module_function

  def pangram?(text)
    text.downcase.scan(/[a-z]/).uniq.length == 26
  end
end