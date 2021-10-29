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
    "DCCCC" => "CM",
    "CCCC"  => "CD",
    "LXXXX" => "XC",
    "XXXX"  => "XL",
    "VIIII" => "IX",
    "IIII"  => "IV",
  }

  def to_roman
    result = ""
    ROMAN_MAP.keys.reduce(self) do |number, roman_base|
      quotient, remainder = number.divmod(roman_base)
      result += ROMAN_MAP[roman_base] * quotient if quotient.positive?
      remainder
    end

    SHORTER_MAP.reduce(result) do |result, (longer_form, shorter_form)|
      result.gsub(longer_form, shorter_form)
    end
  end
end