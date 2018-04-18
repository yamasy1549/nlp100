analogy_file_name = '../../data/analogy.txt'

File.open(analogy_file_name) do |file|
  section_name = "family"
  file.read.scan(/: #{section_name}\n(?<contents>(.|\n)+?):/) do |contents|
    puts contents[0]
  end
end
