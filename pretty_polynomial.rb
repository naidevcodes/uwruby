class Polynomials

  def initialize coefficient
    @coefficient = coefficient
    @ugly_polynom = String.new
  end

  def ugly_output 
    exponent = @coefficient.length - 1

    @coefficient.each do |i|
      unless i == 0
        @ugly_polynom += "#{i}x^#{exponent}+"
        exponent -= 1
      end
    end
    @ugly_polynom
  end

  def make_pretty
    ugly_output
    @ugly_polynom.gsub(/\+(?=-)|\b1(?=x)|\+$|\^1\b|x\^0\b|x(?=\^1)/, "")
  end

end

polynom = Polynomials.new [1, -3, -4, 1, 0, 6]

print polynom.make_pretty
