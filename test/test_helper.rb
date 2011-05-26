$:.unshift File.dirname(__FILE__)
$:.unshift File.join(File.dirname(__FILE__), "..", "src")
$:.unshift File.join(File.dirname(__FILE__), "..", "src", "models")
$:.unshift File.join(File.dirname(__FILE__), "..", "src", "views")
$:.unshift File.join(File.dirname(__FILE__), "..", "src", "controllers")

require 'test/unit'