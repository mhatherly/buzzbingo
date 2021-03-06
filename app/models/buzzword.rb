class Buzzword < ActiveRecord::Base
  attr_accessible :phrase
  validates :phrase, presence: true, 
                     uniqueness: true, 
                     length: { maximum: 66 }, 
                     exclusion: { in: %w(FREE free Free) } 
  def self.random_puzzle_set(opts = {})
      if opts[:free_space].nil? 
        free_space = true 
      else
         ckclass = opts[:free_space].class.to_s
         if  ckclass != "TrueClass" and  ckclass != "FalseClass" 
           raise TypeError,  "free_space parameter must be boolean" 
         end
         
         free_space = opts[:free_space] 
      end
      p = []
      a = self.find_random(24)
      unless a.nil? 
          a.each do |b|
           p.push(b.phrase)
         end
  
         if free_space then 
            p.insert(12,"FREE") 
         end   
         return p
      else
         return nil
      end
  end   
  def self.find_random(num = 1)
      # from ruby-coloured glasses. Modified 
      # skip out if we don't have any or not enough
      return nil if (max = self.count) < num

      # don't request more than we have
      num = [max,num].min

      # build up a set of random offsets to go find
      find_ids = [] # this is here for scoping

      # get rid of the trivial cases
      if 1 == num # we only want one - pick one at random
        find_ids = [rand(max)]
      else
        # just randomise the set of possible ids
        find_ids = (0..max-1).to_a.sort_by { rand } 
        # then grab out the number that we need
        find_ids = find_ids.slice(0..num-1) if num != max
      end

      # we've got a random set of ids - now go pull out the records
      find_ids.map {|the_id| first(:offset => the_id) }
    end
       
end
