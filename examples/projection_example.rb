# regular people want to use the word 'bill' as synonym for expense
# maybe have a file named expenses/income so that it doesn't have to be set.

expenses do

  # monthly bills are the default

  telephone $50
  cell_phone $75
  rent $750
  car_note $350

  # do something every 6 months

  every 6.months do
	car_insurance $600
  end

  # pay one time bill
  on 8/3/2011 do
	birthday $250
  end
  # or it can look like this
  birthday $250, date => 8/3/2011
  
  #range
  from 3/1/2011, 11/1/2011 do
    every :month do
	  lawn_care $250
	end
  end
  # use probabilities (you don't always pay car maintenance every year)
  car_maintenance do
	cost $500
	chance 25%
  end
  # or it can look like this
  car_maintenance $500, chance => 25%
  
  
  # specialized calculations
  on 4/15/2011 do
	taxes $5000 do
	  # whatever code you want in here
	  if cash_on_hand < 10000
		file_extension
		date = date.3.months.from_now
	  end
	end
  end
  
end