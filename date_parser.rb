require 'active_support/all'
#----------------------------------------------------------------
class Date
  def if_strftime(f)
    self.strftime(f)
  end
end

#----------------------------------------------------------------
class NilClass
  def if_strftime(f)
    nil
  end
end


class DateParser
  # из вида 12/06 в объект

  #----------------------------------------------------------------
  def self.normalize_date(text)
    text = "" unless text
    text = text.split('/')
    # puts text
    if text.empty?
      nil
    elsif text.count == 1
      Date.civil(self.parse_century(text[0].to_i))
    else
      Date.civil(self.parse_century(text[1].to_i), text[0].to_i)
    end
  end


  #----------------------------------------------------------------
  def self.normalize_range(range)
    start_end = range.strip.split('-')
    if start_end[0] && !start_end[1] # begin_date -
      start_date = self.normalize_date(start_end[0])
      end_date = nil
    elsif !start_end[0] && start_end[1] # - end_date
      start_date = nil
      end_date = self.normalize_date(start_end[1])
    else # begin_date - end_date
      start_date = self.normalize_date(start_end[0])
      end_date = self.normalize_date(start_end[1])
    end
    f = "%d.%m.%Y"
    [start_date.if_strftime(f), end_date.if_strftime(f)]
  end

  #----------------------------------------------------------------
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