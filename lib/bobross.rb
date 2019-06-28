require "bobross/version"
require "forgery"
require "models/account"
require "models/assignment_grade"
require "models/assignment_group"
require "models/assignment_submission"
require "models/assignment"
require "models/course"
require "models/group_in_account"
require "models/group_in_course"
require "models/section"
require "models/user"
require "active_support/time"

module Bobross
  class Error < StandardError; end

puts %q{
            &&& &&  & &&
      && &\/&\|& ()|/ @, &&
      &\/(/&/&||/& /_/)_&/_&
   &() &\/&|()|/&\/ '%" & ()
  &_\_&&_\ |& |&&/&__%_/_& &&
&&   && & &| &| /& & % ()& /&&
 ()&_---()&\&\|&&-&&--%---()~
     &&     \|||
             |||
             |||
             |||
       , -=-~  .-^- _
     HAPPY LITTLE TREES}
end
