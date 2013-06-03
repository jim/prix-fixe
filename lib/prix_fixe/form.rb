module PrixFixe
  class Form
    attr_accessor :source, :prefix, :errors

    def initialize(options={})
      @source = options[:source]
      @prefix = options[:prefix]
      @errors = {}
    end

    def validate
      add_error(:source, 'You must provide CSS to process') if blank?(@source)
      add_error(:prefix, 'You must provide a prefix') if blank?(@prefix)
      !errors?
    end

    def errors?
      !@errors.empty?
    end

    def add_error(key, message)
      @errors[key] = message
    end

    private

    def blank?(obj)
      obj.nil? || /\A\s*\z/ =~ obj.to_s
    end
  end
end
