require 'sass/css'

module PrixFixe
  class Namespacer < Sass::CSS

    attr_accessor :prefix

    def build_tree
      root = Sass::SCSS::CssParser.new(@template, @options[:filename]).parse
      parse_selectors    root
      prefix_classes     root
      dump_selectors     root
      root
    end

    def prefix_classes(root)
      root.each do |child|
        # We only want instances of Sass::Tree::RuleNode
        next unless child.respond_to?(:parsed_rules)
        child.parsed_rules.members.each do |rule|
          process_selectors(rule.members)
        end
      end
    end

    def process_selectors(collection)
      collection.each do |sequence|
        case sequence
        when Sass::Selector::Class
          sequence.name[0] = "#{@prefix}-#{sequence.name.first}"
        when Sass::Selector::Attribute
          if sequence.name.first == 'class'
            sequence.value.first.gsub!(/\A('|")(\w)/, "\\1#{@prefix}-\\2")
          end
        else
          if sequence.respond_to?(:members)
            process_selectors(sequence.members)
          end
        end
      end
    end
  end
end
