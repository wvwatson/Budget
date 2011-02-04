# import from a 'schedule' directory
# name of file can be significant. e.g. 'normal_hours.rb', 'sick_days,rb' etc


# hours per day are the default

family_web_site 1

# also can explicitly use hours type
day_job 8.hours

# rent $750
# car_note $350

# do something every monday
every :monday do
  meeting 1, :at => 9:30
end

# one time project
on 8/3/2011 do
  medical_checkup 4
end

# or it can look like this
medical_checkup 4, :date => 8/3/2011

# change a day's hours to another change time
on 8/3/2011 do
  replace :all, sick_day
end

# range
from 3/1/2011, 5/1/2011 do
  every :month do
    side_project_meeting 1, {:every => :monday, :at => 10:30}
  end
end
