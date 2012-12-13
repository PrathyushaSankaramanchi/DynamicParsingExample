class SampleBean

  attr_accessor :variantVal, :variantVal1
  
  def initialize
    self.variantVal = []
    self.variantVal1 = []    
      
  end  
  
  def to_s()
    return variantVal.to_s() + variantVal1.to_s() 
  end
  
end