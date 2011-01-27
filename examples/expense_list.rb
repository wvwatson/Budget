
# monthly bills are the default

telephone 50
cell_phone 75
rent 750
car_note 350

# do something every 6 months

every 6.months do
  car_insurance 600
end

# pay one time bill
on '8/3/2011' do
  birthday 250
end

#range
from '3/1/2011', '11/1/2011' do
  every :month do
    lawn_care 250
  end
end

# use probabilities (you don't always pay car maintenance every year)
car_maintenance do
  cost 500
  chance 25
end

# specialized calculations that span income and expenses
on '4/15/2011' do
  taxes 5000 do
    # whatever code you want in here
    # needs to make sense within context of an expense
    if total.to_f > 10000
      cost 0
    end
  end
end