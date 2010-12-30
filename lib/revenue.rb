# revenue aka sales aka shipments
# orders dont become revenue/sales until they are shipped
# profit aka earnings aka income
# revenue is not income
# profile is not cash
# Income is money that comes into the business entity.  Non profits have multiple kinds of revenue streams, 
# some of which have rules (appropriations) associated with them.  This gives non-profits and government 
# organizations unique budgeting challenges. 



#Accounting.  Maybe make Journal(entry) a module and credit and debit extend it?  Or 
# use inheritance?
class Credit
end
class Debit
end
#Accounting.  Maybe make account a module and these extend it.

# something you have
# 'accounts receivable' tag?
# 'Inventory' tag? raw material, work in process, finished goods
#   finished goods becomes accounts receivable becomes cash
#   prepaid expenses are assets because those bills don't have to be paid in the future
# current asset cycle
#   cash -> inventory
#   Inventory -> accounts receivable
#   Accounts receivable -> cash 
# other assets -- like intangible assets -- patents
# fixed assets -- affected by depreciation
# net fixed assets is the sum of the purchase price minus the depreciation charges already taken
class Asset
end

# what something is worth
class Equity
end


class Revenue
end

class EstimatedIncome
	attr_accessor :probability
	attr_accessor :SourceOfFunds
end


# budgeting.  Maybe make source of funds a module that these extend
# Somehow make a budget a human readable configuration of budgeting and accounting pieces.
# Should describe a story of logrolling.  A 'why' of the allocation between roll up organizations and
#  peer organizations.  The story presentation should be so useful that not using this system/process
#  is a statement unto itself.
# Assess risk by multiplying probability of occurence by impact
class Risk
end
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

# make something 'source of funds' capable.  organizations can be 'given' money from a source of funds.  

#  source of funds
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