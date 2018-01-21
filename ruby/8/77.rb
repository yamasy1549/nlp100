require './util'

accuracy_list = []
precision_list = []
recall_list = []

filename = '../../output/76.txt'
File.open(filename) do |lines|
  lines.each do |line|
    label, prob_label, _ = line.chomp.split("\t")
    # 予測の正答率
    accuracy_list << (label == prob_label)
    # 正例に関する適合率
    precision_list << (label == '+1') if prob_label == '+1'
    # 正例に関する再現率
    recall_list << (prob_label == '+1') if label == '+1'
  end
end

accuracy = accuracy_list.count(true) / accuracy_list.count.to_f
precision = precision_list.count(true) / precision_list.count.to_f
recall = recall_list.count(true) / recall_list.count.to_f
f1 = (2 * recall * precision) / (recall + precision)

puts "accuracy\t#{accuracy}"
puts "precision\t#{precision}"
puts "recall\t#{recall}"
puts "f1\t#{f1}"
