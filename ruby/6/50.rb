require './util'

filename = '../../data/nlp.txt'

File.open(filename) do |lines|
  lines.each do |line|
    sentences = line.scan(/[A-Z].+?[.;:?!](?=(?:\s[A-Z])|\n)/)
    if sentences.present?
      sentences.each do |sentence|
        puts sentence.rstrip
      end
    else
      line.scan(/^(.+?)\n$/) do |chars|
        puts chars
      end
    end
  end
end
