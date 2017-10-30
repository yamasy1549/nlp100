str = "Now I need a drink, alcoholic of course, after the heavy lectures involving quantum mechanics."

puts str.split(/\W+/).map(&:count)
