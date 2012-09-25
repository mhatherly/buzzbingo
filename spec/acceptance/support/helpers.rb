module HelperMethods
  # Put helper methods you need to be available in all acceptance specs here.
  def look_like_all_pages 
    pending('looks like all pages')
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance
