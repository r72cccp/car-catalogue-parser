require 'nokogiri'
class String
  def delete_live_breakes
    self.gsub(/\r/,"").gsub(/\n/,"")
  end
  
  def delete_nbsp
    nbsp = Nokogiri::HTML("&nbsp;").text
    self.gsub(nbsp, "")
  end
end