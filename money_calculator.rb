class MoneyCalculator

  def initialize(ones, fives, tens, twenties, fifties, hundreds, five_hundreds, thousands)
    @one = 1 * ones.to_i
    @five = 5 * fives.to_i
    @ten = 10 * tens.to_i
    @twenty = 20 * twenties.to_i
    @fifty = 50 * fifties.to_i
    @hundred = 100 * hundreds.to_i
    @five_hundred = 500 * five_hundreds.to_i
    @thousand = 1000 * thousands.to_i

    @total = @one.to_i + @five.to_i + @ten.to_i + @twenty.to_i + @fifty.to_i + @hundred.to_i + @five_hundred.to_i + 		@thousand.to_i

    @denomination = Hash.new
    @denomination["thousands"] = 0
    @denomination["five_hundreds"] = 0
    @denomination["hundreds"] = 0
    @denomination["fifties"] = 0
    @denomination["twenties"] = 0	
    @denomination["tens"] = 0
    @denomination["fives"] = 0
    @denomination["ones"] = 0
	
  end

  def total
    @sum = @one.to_i + @five.to_i + @ten.to_i + @twenty.to_i + @fifty.to_i + @hundred.to_i + @five_hundred.to_i + @thousand.to_i   
    return @sum
  end

  def change(bill)
    @change = @sum - bill.to_i

    change = @change
    c_thousand = change/1000
    c_five_hundred = (change%1000)/500
    c_hundred = ((change%1000)%500)/100
    c_fifty = (((change%1000)%500)%100)/50
    c_twenty = ((((change%1000)%500)%100)%50)/20
    c_ten = (((((change%1000)%500)%100)%50)%20)/10
    c_five = ((((((change%1000)%500)%100)%50)%20)%10)/5
    c_one = ((((((change%1000)%500)%100)%50)%20)%10)%5
    return {:ones => c_one, :fives => c_five, :tens => c_ten, :twenties => c_twenty, :fifties => c_fifty, :hundreds => c_hundred, :five_hundreds => c_five_hundred, :thousands => c_thousand}
  end
end
