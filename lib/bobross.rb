require "bobross/version"
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
include FactoryBot::Syntax::Methods

module Bobross
  class Error < StandardError; end
end
