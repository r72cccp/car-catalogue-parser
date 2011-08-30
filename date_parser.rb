require 'active_support/all'
class DateParser
  # из вида 12/06 в объект
  def self.normalize_date(text)
    text = text.split('/')
    # puts text
    if text.count == 1
      Date.civil(self.parse_century(text[0].to_i))
    else
      Date.civil(self.parse_century(text[1].to_i), text[0].to_i)
    end
  end
  
  def self.normalize_range(range)
    start_end = range.split('-')
    if start_end.count == 1 # указано только начало
     start_date = self.normalize_date('62')
     end_date = nil
    else # начало и конец
      start_date = self.normalize_date(start_end[0])
      end_date = self.normalize_date(start_end[1])
    end
    [start_date, end_date]
  end
    
  
  def self.parse_century(ending)
    if ending > 20
      "19#{ending}".to_i
    elsif ending < 10
      "200#{ending}".to_i
    else
      "20#{ending}".to_i
    end
  end
end

# puts DateParser::normalize_range('  65-74')