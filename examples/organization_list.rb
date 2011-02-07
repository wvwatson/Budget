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