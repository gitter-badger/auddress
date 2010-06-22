module Webrat
  module Matchers
  
    class HasContent #:nodoc:
      def initialize(content)
        @content = content
      end
      
      def matches?(stringlike)
        @document = Webrat::XML.document(stringlike)
        @element = @document.inner_text
      
        case @content
        when String
          @element.include?(@content)
        when Regexp
          @element.match(@content)
        end
      end
      
      # ==== Returns
      # String:: The failure message.
      def failure_message
        "expected the following element's content to #{content_message}:\n#{@element}"
      end

      # ==== Returns
      # String:: The failure message to be displayed in negative matches.
      def negative_failure_message
        "expected the following element's content to not #{content_message}:\n#{@element}"
      end
    
      def content_message
        case @content
        when String
          "include \"#{@content}\""
        when Regexp
          "match #{@content.inspect}"
        end
      end
    end
    
    # Matches the contents of an HTML document with
    # whatever string is supplied
    #
    # ---
    # @api public
    def contain(content)
      HasContent.new(content)
    end
    
  end
end