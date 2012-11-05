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
end
