# applies to everything that gets rolled up from marketing
from :marketing do |expenses|
  # amount gets matched by the red cross
  expenses = expenses / 2
end

# applies to everything that gets rolled into finance
to :finance do |expenses|
  # finance owes the help desk a favor
  expenses = expenses + (expenses * 0.02)
end

# applies when rolling from help_desk into information_technology
from :help_desk, to: :information_technology do |expenses|
  # finance is covering 2% of the help_desk's expenses
  expenses = expenses - (expenses * 0.02)
end