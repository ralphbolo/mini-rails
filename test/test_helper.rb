$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require "minitest/autorun"
require "rack/mock"

require_relative "test_blog/config/environment"
