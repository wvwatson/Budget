# regular people want to use the word 'bill' as synonym for expense
# maybe have a file named expenses/income so that it doesn't have to be set.


expenses do

  # monthly context (monthly is default period)
  every month do
    rent $750
    car_note $350
  end

  every 6.months do
    car_insurance $600
  end

  # one time charge
  on 8/3/2011 do
    birthday $250
  end
  # or
  birthday $250, date => 8/3/2011
  
  # fudge expenses 
  car_maintenance do
    cost $500
	chance 25%
  end
  # or
  car_maintenance $500, chance => 25%
  
  
  # specialized calculations
  on 4/15/2011 do
    taxes $5000 do
		# whatever ruby code you want in here, with access to context
		if cash_on_hand < 10000
			file_extension
			date = date.3.months.from
		end
	end
  end
  
end

