require 'test_helper'

require 'prix_fixe/namespacer'

module PrixFixe

  describe Namespacer do

    def ns(prefix, css)
      namespacer = Namespacer.new(css)
      namespacer.prefix = prefix
      namespacer.render(:scss)
    end

    def standardize_whitespace(string)
      string.gsub(/\s+/, ' ').strip
    end

    def assert_equal_css(expected, actual, message="")
      expected = standardize_whitespace(expected)
      actual = standardize_whitespace(actual)
      assert_equal(expected, actual, message)
    end

    it 'standardizes whitespace' do
      assert_equal "a b", standardize_whitespace("a \n b")
      assert_equal "a", standardize_whitespace("a ")
    end

    it 'adds a prefix to a simple class selector' do
      css = '.huge {}'
      expected = '.p-huge {}'

      assert_equal_css expected, ns('p', css)
    end

    it 'adds a prefix to class attribute matchers' do
      css = '[class*="button"] {}'
      expected = '[class*="p-button"] {}'

      assert_equal_css expected, ns('p', css)
    end

  end
end
