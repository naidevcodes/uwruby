def commas(num)

  num_wth_commas =
    num.to_s.reverse.split(//).each_slice(3).map {|n| n.join("").reverse}.reverse.join(",")
end

puts commas(-123456)
puts commas(7261716238172681723)
puts commas(9826391617236123)

# Having difficulties dealing with negative numbers