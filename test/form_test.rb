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
      assert !form.errors[:source].nil?
    end

    it 'validates source when it is an empty string' do
      form = Form.new(source: '', prefix: 'pre')

      assert !form.validate
      assert !form.errors[:source].nil?
    end

    it 'validates source when it is whitespace' do
      form = Form.new(source: '  ', prefix: 'pre')

      assert !form.validate
      assert !form.errors[:source].nil?
    end

    it 'validates prefix when it does not exist' do
      form = Form.new(source: 'foo')

      assert !form.validate
      assert !form.errors[:prefix].nil?
    end

    it 'validates prefix when it is an empty string' do
      form = Form.new(source: 'foo', prefix: '')

      assert !form.validate
      assert !form.errors[:prefix].nil?
    end

    it 'validates prefix when it is whitespace' do
      form = Form.new(source: 'foo', prefix: '  ')

      assert !form.validate
      assert !form.errors[:prefix].nil?
    end
  end
end
