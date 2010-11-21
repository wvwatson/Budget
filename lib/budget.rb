# We need a better way to track budgets within organizations
# As expenditures roll their way up through organizations they need to be tracked
# At each phase of the roll up there needs to be a spot for calculations to be made
# We need to allow for percentage based budgets
# This in the end should be a budget framework, not a budget application.  
# This is meant to be shared with others as an example
# export to excel
# Budgeting involves a dialog between a submitter and a reviewer/approver
# One goal in budgeting is avoiding asymmetric information between the one submitting a budget
# and the one reviewing the budget for approval
# Need to implement concept of direct and indirect.  direct money goes towards the product that is produced by the org.  indirect
#   does not.  ex of indirect is administrative employee wages and buildings.
#   Maybe use tagging for accounts to implement direct/indirect/other

class SourceOfFunds
	attr_accessor :startdate
	attr_accessor :enddate
	attr_accessor :name
	attr_accessor :percentage
	#maybe do a grant mixin
end
#alias :SourceOfFunds :Grant

class BudgetObject
	attr_accessor :name
	attr_accessor :Description
end
# class Dollars
# end
class Expenditure
  attr_accessor :BudgetObject
  attr_accessor :dollars
  def initialize
    @BudgetObject = BudgetObject.new
  end
end
#extend number to allow for year mean budget year.  Allow budgets per year and rolling forward per year 
class Year
	#roll forward
end
#Name of bucket where money is collected
class Account
  attr_accessor :name
  #kind of thing the money is spent on e.g. chairs.  Maybe should be a list
	attr_accessor :Expenditures 
	#rollup account
	attr_accessor :Account 
	attr_accessor :dollars
	attr_accessor :tag
	
	def initialize
    @dollars = 0
    @expenditures=[]
    @tag=[]
  end
  #should have option to count all sub accounts too
  def add(expenditure)
    @expenditures.push(expenditure)
  end
  
  #accumulate all of the dollars from all of the expenditure
  def dollars
    @expenditures.each do |currentexpenses|
       @dollars += currentexpenses.dollars
    end
    @dollars
  end
  #override the expenditures and set dollars manually
  def dollars=(total)
    @dollars=total
  end
end

class Organization
	attr_accessor :DefaultOrganizationParent
	attr_accessor :Name
	attr_accessor :LevelName
	attr_accessor :Sub
	attr_accessor :Account
	attr_accessor :budget
	attr_accessor :sourceoffunds
	attr_accessor :fundingdisttribution 
	
	def initialize
    @sub = []
    @sourceoffunds = []
    @Account = Account.new
    @budget = 0
 end	

	def addsub(sub)
	  @sub.push(sub)
  end

	def addsof(sof)
	  @sourceoffunds.push(sof)
  end

  #create hash of each source of funding paired with the amount
  #of money extracted from the fund
  def fundingdistribution
     @fundingdistribution = {}
     @sourceoffunds.each do |sof|
       @fundingdistribution[sof.name] = budget * (sof.percentage.to_f / 100)
     end
     @fundingdistribution 
   end
  # rolls up everything to this org using the strategy of this org and the orgs below it.  
	# returns money
	def rollup
	  @sub.each do |sub|
	    sub.rollup
       @budget += sub.budget
    end
    @budget += @Account.dollars 
	end
	# runs calculations to see if the org is balanced.  Need  a smart way to return why not balanced
	def balance
	end
end
#A complete list of rules for determining a budget
#Can be all inclusive, per year, per org
#Should be one budget proposal.  The proposal should be able to be saved and compared to other proposals
#Proposal is probably part of a long drawn out process
class Budget
  # allow/notify reviewer that budget is ready for review
  def submit
  end
  # review a specific budget
  def review
  end
  def compare
  end
end
#collection of schedules that make a funding distribution stragety.  e.g. default general revenu distribution
class Strategy
  #decriptive name here helps to know the manner you are assigning percentages e.g. 
  attr_accessor :Name
end
#schedule is a percentage tied to a source of funds for an org
class Schedule
  attr_accessor :Strategy
  attr_accessor :Percentage
  attr_accessor :SourceOfFunds
end
# should also be able to freely compose adhoc orgs LevelName +  _ + Name 
#  e.g. division_1  +  division_2
# and have it use their rollups
class OrgRollupStrategy
	attr_accessor :OrganizationGraph  #what orgs roll up into other orgs
	attr_accessor :OrgExclusionList  #what orgs to excluded from a rollup
end
class BudgetObjectRollupStrategy # master list or optional tie to Org or a Source of funds
	attr_accessor :BudgetObjectExclusion #exclude budget objects out of the rollup
end
class SourceOfFundRollupStrategy # master list or optional tie to Org
	attr_accessor :SourceOfFundRedirect # redirect anything coming from a source of funds to another source
end
#alias :OrgRollupStrategy :RollupStrategy :EarMark :Appropriation
#  Rollups that aren't persistantly located in the target accounts
class DerivedDollars
end
class User
end
class Submitter < User
end
class Reviewer < User
end
#alias :Approver :Reviewer