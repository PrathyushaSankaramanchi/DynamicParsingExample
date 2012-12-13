require_relative '../helpers/xml_parser'
include XMLParser

class SampleController < ApplicationController
  
  def sample  
    productsParser = Reader.new("/drive2/AptanaWorkspace/NokogiriXMLParsing/doc/products.xml")
    @variantVal = productsParser.getVariants("//variant")
  end
end