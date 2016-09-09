class XmlDocument
  # TODO: your code goes here!
  
    attr_reader :indent, :ilength
    
    def initialize(indent = false)
        @indent = indent
        @ilength = 0
    end
    
    def newline
        @indent?"\n":""
    end
    
    def indent
        @ilength += 1 if @indent
    end
    
    def unindent
        @ilength -= 1 if @indent
    end
    
    def attr_strings(attrs)
        attrs.map {|k,v|
            "#{k.to_s}=\"#{v}\""
        }.join(" ")
    end
    
    def tag_body(method, attrs)
        "#{tabspace}<#{method} #{attr_strings(attrs)}/>#{newline}"
    end
    
    def tabspace
        "  " * @ilength
    end
    
    def method_missing(method_name, *args, &blk)
        if block_given?
            xml = ""
            if args[0].is_a?Hash
                xml << "#{tabspace}<#{method_name} #{attr_strings(args[0])}>#{newline}"
            else
                xml << "#{tabspace}<#{method_name}>#{newline}"
            end
            indent
            xml << blk.call
            unindent
            xml << "#{tabspace}</#{method_name}>#{newline}"
            xml
        else
            return "#{tabspace}<#{method_name}/>#{newline}"if args.empty?
            if args[0].is_a?Hash
                tag_body(method_name,args[0])
            end
        end
        
        
    end
end
