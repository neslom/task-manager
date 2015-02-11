ENV['TASK_MANAGER_ENV'] ||= 'test'

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'

class ModelTest < Minitest::Test
  def teardown
    TaskManager.delete_all
  end
end
