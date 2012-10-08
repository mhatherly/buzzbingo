namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_buzzwords
  end # populate
end

def make_buzzwords
    99.times do |n|
      phrase = Faker::Company.catch_phrase
      oldbuzz=Buzzword.find_by_phrase(phrase)
      Buzzword.create!(
            phrase: phrase) if oldbuzz.nil?
    end
end


