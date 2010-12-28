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
# Fund Balance should be zero.  Calculates from the funding distribution and subtracts that from the rollup total
# Possibly make this into a fragmented dsl
# Should implement the new information retrieved from books on PART methodology
# Have a separation from budgeting lingo and PART (performance) lingo
# Maybe separate into three pieces, account, budgeting, and performance
# Social Budgeting:  Allowing more people to submit a 'pull' request to the budget
#  could limit low levels to submit stuff that would force a decrease in an expense elsewhere
#  Managers could merge their request in to the expense where it really belongs
# Separate various types of funds, accounts, and behavior into modules so that they can be included into 
# base source of funds/accounts or combined
# on command we want to be able to see how much much we have available from the different sources of funds given estimations
# we want a language for accounting, source of funds, and expenses.  These can be populated with sane defaults
# there may need to be a set of income, cash, and balance statements for each restricted fund
# Need the capability to do incremental, zero based, and activity based budgeting
# allow for proposals (preferrably 3)
#  Derive from those proposals the highest priorities
#  Apply money to the highest priorities first then display which exepenses would be cut
#  Show which activies/tasks would be cut
#  Link activities/tasks to expenses
#    Have a way to show type A versus type B activities
#      Maybe type A can be called activity ... sharpening the saw work.  Type As should be assigned to type Bs in some way
#        type A can have a value assigned to them that would turn into an 'opportunity cost' if the activity fails.
#      type B can be called task?  things you do to stay afloat
#  Have a year associated with rules for rolling up income and expenses
# Send a block to tags for rollup customization? 
# indirect expense do 
#    debit indirect unless indirect.empty?
#    debit unrestricted
# end
# abstract tagging code
# abstract hierarchy code
# figure out a way to decouple organization from accounting code.  Need some other way to compose these
# abstract roll up code

require 'objectives'
require 'accounting'


class Organization
	attr_accessor :DefaultOrganizationParent
	attr_accessor :Name
	attr_accessor :LevelName
	attr_accessor :Sub
	attr_accessor :Account
	attr_accessor :accounts
	attr_accessor :budget
	attr_accessor :sourceoffunds
	attr_accessor :fundingdisttribution 
	
	def initialize
    @sub = []
    @sourceoffunds = []
    @Account = Account.new
    @accounts = []
    @budget = 0
 end	

	def addsub(sub)
	  @sub.push(sub)
  end

	def addsof(sof)
	  @sourceoffunds.push(sof)
  end

  def addaccount(account)
    @accounts.push(account)
  end
  
  def addsoftag(sofname, tag)
    @sourceoffunds.each do |sof|
      if sof.name==sofname
         sof.addtags(tag)
      else 
         false
      end 
    end
  end
  
  def findsoftag(sofname, tag)
    #debugger
    @sourceoffunds.each do |sof|
      if sof.name==sofname
        sof.tags.each do |softag|
          return true if softag == tag
        end
      else 
         false
      end 
    end
    false
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
	def rollup(*tags)
	  @budget = 0
	  #roll up sub organization's accounts
	  @sub.each do |sub|
	    sub.rollup
       @budget += sub.budget
    end
    
    #roll up this org's accounts
    @accounts.each do |account|
       @budget += account.dollars
    end
    
    @budget += @Account.dollars
	end
	# runs calculations to see if the org is balanced.  Need  a smart way to return why not balanced
	def balance(*tags)
	  # debugger
	  income_estimation(tags) - rollup
	end
	
	#Estimation of all sources of funds and other revenue for the year
	def income_estimation(*tags)
	  #debugger
	  softotal = 0
    @sourceoffunds.each do |sof|
      if  (tags.flatten.count == 0)
          softotal += sof.dollars.to_i * (sof.likelyhood.to_f / 100)
      else
        tags.flatten.each do |tag|
          if (tags.count > 0 && self.findsoftag(sof.name, tag))        
            softotal += sof.dollars.to_i * (sof.likelyhood.to_f / 100)
            break # if the tag is included, count in the sum (once)
          end
        end
      end
    end
    softotal
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
