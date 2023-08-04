require 'bobross/version'
require 'faker'
require 'models/canvas_object'
require 'models/canvas_account'
require 'models/canvas_assignment_grade'
require 'models/canvas_assignment_group'
require 'models/canvas_assignment_submission'
require 'models/canvas_assignment'
require 'models/canvas_course'
require 'models/canvas_enrollment'
require 'models/canvas_group_in_account'
require 'models/canvas_group_in_course'
require 'models/canvas_section'
require 'models/canvas_term'
require 'models/canvas_user'
require 'active_support/time'
require 'csv'
require 'net/http'
require 'uri'

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
     HAPPY LITTLE TREES
   }
end
