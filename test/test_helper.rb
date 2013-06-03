$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'minitest'
require 'minitest/spec'
require 'minitest/autorun'
require 'rack/test'
require 'nokogiri'

def assert_textarea_value(html, selector, value)
  doc = Nokogiri::HTML(html)
  assert_equal value, doc.at(selector).inner_text
end

def assert_input_value(html, selector, value)
  doc = Nokogiri::HTML(html)
  assert_equal value, doc.at(selector)['value']
end
