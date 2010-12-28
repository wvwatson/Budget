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
# use of the budget system could be mandatory by directive of a grantor.  The grantee could also be put
# on mandatory budgeting with this system if they are poor performers.  successful budgeting patterns could be shared in the system
# between successfull and unsuccessful grantees.

# Assess risk by multiplying probability of occurence by impact
class Risk
end

class EstimatedIncome
	attr_accessor :probability
	attr_accessor :SourceOfFunds
end

class Action
  attr_accessor :description
end

class Goal
  attr_accessor :description
  attr_accessor :actions
  def initialize
    @Actions = []
  end
  def addactions(newactiondesc)
    @Actions = [] unless @Actions
    @newaction = Action.new
    @newaction.description = newactiondesc
    @Actions.push(@newaction)   
  end
  
  def show_actions
    @Actions
  end
end

class WorkPlan
 attr_accessor :goals
  def initialize
    @Goals = []
  end
 def addgoals(newgoaldesc)
   @Goals = [] unless @Goals
   @newgoal = Goal.new
   @newgoal.description = newgoaldesc
   @Goals.push(@newgoal)
 end
 
 def show_workplan
   @Goals
 end
end

# Performance Measurement.  Somehow make it so the specification of 
# action plans is a human readable langauge that rides on top of the budgeting piece
class Objective
end

# budgeting.  Maybe make source of funds a module that these extend
# Somehow make a budget a human readable configuration of budgeting and accounting pieces.
# Should describe a story of logrolling.  A 'why' of the allocation between roll up organizations and
#  peer organizations.  The story presentation should be so useful that not using this system/process
#  is a statement unto itself.

class Unrestricted
end
class Restricted
end
class GrantOrContract
end
class TradeOrBusiness
end
class Asset
end
class PledgeOrCash
end
class Matching
end

class SourceOfFunds
	attr_accessor :startdate
	attr_accessor :enddate
	attr_accessor :name
	#rip this out and put it on relationship with organization somehow
	attr_accessor :percentage
	attr_accessor :dollars
	#maybe do a grant mixin
	attr_accessor :likelyhood
	attr_accessor :tags
	
	def initialize
    @tags = []
  end
  
	def addtags(newtag)
    @tags.push(newtag)
  end
end
#alias :SourceOfFunds :Grant

#Accounting.  Maybe make Journal(entry) a module and credit and debit extend it?  Or 
# use inheritance?
class Credit
end
class Debit
end
class Journal
end
class FiscalYear
end
#Accounting.  Maybe make account a module and these extend it.
class Asset
end
class Liability
end
class Equity
end
class Revenue
end
class Expense
end
class IncomeStatement
end
class CashFlowStatement
end
class BalanceStatement
end

class BudgetObject
	attr_accessor :name
	attr_accessor :Description
end
# class Dollars
# end
class Expenditure
  attr_accessor :BudgetObject
  attr_accessor :dollars
  attr_accessor :tags
  
  def initialize
    @BudgetObject = BudgetObject.new
    @tags = []
  end
  
  # def tags=(newtag)
  #    @tags.push(newtag)   
  #  end
  def addtags(newtag)
    @tags.push(newtag)
  end
  
end
#extend number to allow for year mean budget year.  Allow budgets per year and rolling forward per year 
class Year
	#roll forward
end

#use this to list account hierarchry
class ChartOfAccounts
end
#Name of bucket where money is collected
class Account
  attr_accessor :name
  #kind of thing the money is spent on e.g. chairs.  Maybe should be a list
	attr_accessor :Expenditures 
	#rollup account
	attr_accessor :Account 
	attr_accessor :dollars
	attr_accessor :tags
	
	def initialize
    @dollars = 0
    @expenditures=[]
    @tags=[]
  end
  
  def addtags(newtag)
    @tags.push(newtag)
  end
  
  def tags=(newtag)
    @tags.push(newtag)
  end
  
  #should have option to count all sub accounts too
  def add(expenditure)
    @expenditures.push(expenditure)
  end
  
  #accumulate all of the dollars from all of the expenditure and
  #overwrite whatever is in the dollars variable
  def dollars
    @dollars=0
    @expenditures.each do |currentexpenses|
       @dollars += currentexpenses.dollars
    end
    @dollars
  end
  #override the expenditures and set dollars manually
  #accept a hash that creates a new expenditure with cash
  def dollars=(total, exp = {})
    newexp = Expenditure.new
    if exp["name"]
      newexp.BudgetObject.name = exp["name"]
    else
      newexp.BudgetObject.name = "cash"
    end
    newexp.dollars = total
    add(newexp)
  end
end

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
class User
end
class Submitter < User
end
class Reviewer < User
end
#alias :Approver :Reviewer