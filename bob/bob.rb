module Bob
  module_function

  def hey(remark)
    case remark.gsub(/[^\w\?]/, "")
    when /^(?=.*[A-Z])[^a-z]+\?$/ then "Calm down, I know what I'm doing!"
    when /^(?=.*[A-Z])[^a-z]+$/   then "Whoa, chill out!"
    when /\?$/                    then "Sure."
    when /^$/                     then "Fine. Be that way!"
    else                               "Whatever."
    end
  end
end