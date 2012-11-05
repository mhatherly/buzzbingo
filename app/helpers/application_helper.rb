module ApplicationHelper
  def phrase_class(phrase)
    if phrase.upcase == "FREE" then
       id = "FREE"
    elsif phrase.length > 40 then
      id = "long"
    elsif phrase.length > 20 then
       id = "med"
    else
       id = "short"
    end
    return raw('<td class="' + id + '">')
  end
  
  def wrap(content)
       sanitize(raw(content.split.map{ |s| wrap_long_string(s) }.join(' ')))
  end
    
  private

  def wrap_long_string(text, max_width = 19)
    zero_width_space = "&#8203;"
    regex = /.{1,#{max_width}}/
    (text.length < max_width ) ? text :
                                text.scan(regex).join(zero_width_space)
    
  end
end
