twain = <<Mark_Twain
O Lord, our father,
Our young patriots, idols of our hearts,
Go forth to battle - be Thou near them!
With them, in spirit, we also go forth
From the sweet peace of our beloved firesides To smite the foe.

O Lord, our God,
Help us to tear their soldiers
To bloody shreds with our shells;
Help us to cover their smiling fields
With the pale forms of their patriot dead; Help us to drown the thunder of
the guns With the shrieks of their wounded,
Writhing in pain.

Help us to lay waste their humble homes
With a hurricane of fire;
Help us to wring the hearts of their
Unoffending widows with unavailing grief; Help us to turn them out roofless
With their little children to wander unfriended The wastes of their
desolated land
In rags and hunger and thirst,
Sports of the sun flames of summer
And the icy winds of winter,
Burdened in spirit, worn with travail,
Imploring Thee for the refuge of the grave and denied it

For our sakes who adore Thee, Lord,
Blast their hopes,
Blight their lives,
Protract their bitter pilgrimage,
Make heavy their steps,
Water their way with their tears,
Stain the white snow with the blood
Of their wounded feet!

We ask it in the spirit of love
Of Him who is the source of love,
And Who is the ever-faithful
Refuge and Friend of all that are sore beset And seek His aid with humble
and contrite hearts.

Amen
Mark_Twain

def find_ltr_freq(str)
	lttrs = ('a'..'z').to_a
	count = {}

  lttrs_arr = str.downcase.split(//).select {|a| 
  	a if lttrs.include? a
  }

	 lttrs_arr.each do |x|
		unless count.include?(x)
			count[x] = 0
		end

			count[x] += 1
  end

  total = count.values.reduce(0) {|sum, i| sum += i}
  count.each {|k, v| count[k] = (100 * v.to_f / total).round(2)}
  final_arr = count.sort_by {|k, v| v}.reverse
  
end

print find_ltr_freq(twain)
