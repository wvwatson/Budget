
This code is a brain dump of my ideas how on to make a financial DSL.  Use it at your own risk
--

Example of events dsl for hourly planning.

``` ruby
# hours per day are the default

family_web_site 1

# also can explicitly use hours type
day_job 8.hours

# do something every monday
every :monday do
  meeting 1, :at => "9:30"
end

# one time project
on "8/3/2011" do
  medical_checkup 4
end

# or it can look like this
medical_checkup 4, :date => "8/3/2011"

# change a day's hours to another change time
on "8/3/2011" do
  replace :all, :sick_day
end

# range
from "3/1/2011", "5/1/2011" do
  every :month do
    side_project_meeting 1, {:every => :monday, :at => "10:30"}
  end
end

```

Example of an Expense DSL composed with the events DSL (for creating yearly projections)

``` ruby
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
```

Example of an organization dsl (for setting up organizational hierarchies)

``` ruby
# top down
# designate hierarchy
executives do
  :finance do
    :budgeting
    :payroll
  end
  :information_technology
  :marketing
  :sales
end

# reopen hierarchy
information_technology do
  :help_desk
  :operations
  :software_development
end  

# single assignment/reopen

marketing :graphic_design

#bottom up
field_sales :reports_to, :sales
district_1 :reports_to, :field_sales

```

Example of a rollup dsl.  During a rollup: 
1) a sub-org accounts for its money 
2) A 'parent' org accounts for the money of all of its sub-orgs 
3) The parent org accounts for its own money

``` ruby
# applies to everything that gets rolled up from marketing
from :marketing do |expenses|
  # amount gets matched by the red cross
  # debugger
  expenses = expenses / 2
end

# applies to everything that gets rolled into finance
to :finance do |expenses|
  # finance is subsidizing other orgs
  expenses = expenses + (expenses * 0.02)
end

# applies when rolling from help_desk into information_technology
from :help_desk, to: :information_technology do |expenses|
  # someone is covering 2% of the help_desk's expenses
  expenses = expenses - (expenses * 0.02)
end
```

Things usually start as an idea.  
As we nurse that idea we give it resources.  
At some point we want to know just how big that idea can become.
It's at that point when we start the balancing act of keeping the idea from consuming all of our resources, or everything else from consuming the resources of the idea.  That's where budgets come in.

Your idea -> feasibility numbers -> projection -> budget

