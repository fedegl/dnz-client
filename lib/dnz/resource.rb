module DNZ
  class Resource < BlankSlate
    class << self
      def parse(xml)
        self.new(Nokogiri.XML(xml))
      end
    end

    attr_reader :doc

    def initialize(doc)
      @doc = doc
    end

    def to_s
      doc.to_xml
    end

    def method_missing(symbol, *args, &block)
      if args.empty?
        doc.xpath('//%s' % symbol.to_s.dasherize).first.content
      else
        super
      end
    end
  end
end