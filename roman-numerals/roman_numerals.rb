# Based on https://sandimetz.com/blog/2016/6/9/make-everything-the-same

class Integer
  ROMAN_MAP = {
    1000 => "M",
     500 => "D",
     100 => "C",
      50 => "L",
      10 => "X",
       5 => "V",
       1 => "I",
  }

  SHORTER_MAP = {
    "DCCCC" => "CM", # 900
    "CCCC"  => "CD", # 400
    "LXXXX" => "XC", # 90
    "XXXX"  => "XL", # 40
    "VIIII" => "IX", # 9
    "IIII"  => "IV", # 4
  }

  def to_roman
    result = ""

    ROMAN_MAP.reduce(self) do |number, (roman_base, roman_letter)|
      quotient, remainder = number.divmod(roman_base)
      result += roman_letter * quotient
      remainder
    end

    SHORTER_MAP.reduce(result) do |result, (longer_form, shorter_form)|
      result.gsub(longer_form, shorter_form)
    end
  end
end