require 'test_helper'

require 'prix_fixe/form'

module PrixFixe
  describe Form do
    it 'sets attributes passed to initialize' do
      form = Form.new(source: 'css', prefix: 'pre')

      assert form.validate
      assert !form.errors?
      assert_equal form.source, 'css'
      assert_equal form.prefix, 'pre'
    end

    it 'validates css' do
      form = Form.new(prefix: 'foo')

      assert !form.validate
      assert_match /provide CSS/, form.errors[:source]
    end

    it 'validates source when it is an empty string' do
      form = Form.new(source: '', prefix: 'pre')

      assert !form.validate
      assert_match /provide CSS/, form.errors[:source]
    end

    it 'validates source when it is whitespace' do
      form = Form.new(source: '  ', prefix: 'pre')

      assert !form.validate
      assert_match /provide CSS/, form.errors[:source]
    end

    it 'validates prefix when it does not exist' do
      form = Form.new(source: 'foo')

      assert !form.validate
      assert_match /provide a prefix/, form.errors[:prefix]
    end

    it 'validates prefix when it is an empty string' do
      form = Form.new(source: 'foo', prefix: '')

      assert !form.validate
      assert_match /provide a prefix/, form.errors[:prefix]
    end

    it 'validates prefix when it is whitespace' do
      form = Form.new(source: 'foo', prefix: '  ')

      assert !form.validate
      assert_match /provide a prefix/, form.errors[:prefix]
    end

    it 'only allows valid prefixes' do
      form = Form.new(source: 'foo', prefix: 'n.')

      assert !form.validate
      assert_match /letters and numbers/, form.errors[:prefix]
    end
  end
end
