require 'dnz/attributes'

module DNZ
  class Result
    include DNZ::Attributes
    
    def initialize(doc)
      @attributes = {}

      doc.children.each do |child|
        @attributes[child.name.downcase] = child.text.to_s
      end
    end
  end
end