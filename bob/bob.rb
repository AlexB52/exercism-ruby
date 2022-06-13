require "byebug"

module Bob
  module_function

  def hey(remark)
    case (remark.split("\n").last || "").strip
    when /^$/                        then "Fine. Be that way!"
    when /^(?=.*[A-Z])[^a-z]+\?$/    then "Calm down, I know what I'm doing!"
    when /^(?=.*[A-Z])[^a-z]+[^\?]$/ then "Whoa, chill out!"
    when /\?$/                       then "Sure."
    else                                  "Whatever."
    end
  end
end