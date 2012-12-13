require 'nokogiri'
module XMLParser
  
  class Reader
  public  
    # initialization
    def initialize(xml_path)
      @variantSubArr = Array.new
      @variantSubArrTemp = Array.new
      @variantTemp = Array.new
      
        read(xml_path)
    end
    
    # opens and reads the xml file
      def read(xml_path)          
        @file = Nokogiri::XML(File.open(xml_path)){ |cfg| cfg.noblanks }  
      end
      
      # Method to get the xpath
      def getVariants(xpathObj)
        
        @variantArr = Array.new
        @variantArr1 = Array.new
        
        @file.xpath(xpathObj).each do |node|                    
            @variantArr = recursive_child(node)           
          return @variantArr
        end
      end 
      
      def recursive_child(node)          
          
          @nodeChildrenCount = node.children.count          
          
          if @nodeChildrenCount > 0
            @nodeChildren = node.children
            
            
            (0..@nodeChildrenCount-1).each { |i|
              @nodeChildrenValues = Hash.new
              puts("node.children[i].children count #{node.children[i].count}")
              
                name = node.children[i].name
                value = node.children[i].text
                puts("name is #{name}") 
                puts("value is #{value}") 
                @nodeChildrenValues[name] = value
                @variantTemp.push(@nodeChildrenValues)
              
              @nodeSubChildCount = node.children[i].children.count 
              puts("nodessssssssssssssss childreeeeeeeeeeeeeeeeeeennnnnnnnnn  #{node.children[i].children}")
              if node.children[i].children != nil && @nodeSubChildCount > 0 && !node.children[i].children.empty?
                @variantSubArr = recursive_subChild(node.children[i])
                
                puts("@variantSubArr is #{@variantSubArr}")                
                @variantTemp.push(@variantSubArr)
              end
              
                @variantTemp << @variantSubTemp 
            }
          else
            @nodeValues = {} 
          end
          
          if !node.next_sibling.nil?
            puts("node.next_sibling is #{node.next_sibling}")
            recursive_child(node.next_sibling)
          end
            
            return @variantTemp
      end
      
      def recursive_subChild(childNode)
        puts("childnode is #{childNode}")
           @variantSubArrayTemp = Array.new  
                                    
              (0..@nodeSubChildCount-1).each { |j|
                @nodeSubChildValues = Hash.new
                  if childNode.children[j].name != "text" && childNode.children[j].name != nil && !childNode.children[j].name.empty? && !childNode.children[j].children.empty? 
                    
                    name1 = childNode.children[j].name
                    value1 = childNode.children[j].text 
                            
                    @nodeSubChildValues[name1] = value1 
                    
                    if !@nodeSubChildValues.empty? && !@nodeSubChildValues.blank?                 
                      @variantSubArrayTemp.push(@nodeSubChildValues)                       
                    end                    
                    
                    @subNodeCount = childNode.children[j].children.count
                    if @subNodeCount > 0
                      (0..@subNodeCount-1).each { |k|
                        recursive_child(childNode.children[j].children[k])   
                      }                               
                    end                                
                  end 
                  
                  
                    
                  
              }         
       return @variantSubArrayTemp
     end
  end
end