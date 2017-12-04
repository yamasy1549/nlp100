require './util'

morphologies.each do |sentence|
  sentence.each do |word|
    puts word.values.join(' ')
  end
  puts
end
