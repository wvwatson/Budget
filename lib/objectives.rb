# Objectives are high level goals set per year (or financial cycle)

# An action (aka activity or task) is one step of many that accomplishes a goal
# actions are tied to expenses and should help explain why those expenses exist
class Action
  attr_accessor :description
end

# Performance Measurement.  Somehow make it so the specification of 
# action plans is a human readable langauge that rides on top of the budgeting piece
class Objective
end

# A goal, also known as an objective, is a high level directive.  It is usually
# established by executive level personnel
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

# A workplan is a way to accomplish an objective
class WorkPlan
 attr_accessor :goals
  def initialize
    @Goals = []
  end
  
 # Adds a goal to the collection of goals which make up the workplan
 def addgoals(newgoaldesc)
   @Goals = [] unless @Goals
   @newgoal = Goal.new
   @newgoal.description = newgoaldesc
   @Goals.push(@newgoal)
 end
 
 # The workplan is a collection of all of the goals for the year or financial cycle
 def show_workplan
   @Goals
 end
end