require 'pry'
require 'active_record'

class Array
  def ngram(n)
    self.each_cons(n).select { |gram| gram.size == n }
  end
end

class Morph
  attr_accessor :surface, :base, :pos, :pos1

  def initialize(surface, base, pos, pos1)
    @surface = surface
    @base = base
    @pos = pos
    @pos1 = pos1
  end
end

class Chunk
  attr_accessor :morphs, :dst, :srcs

  def initialize(morphs=[], dst=-1, srcs=[])
    @morphs = morphs
    @dst = dst
    @srcs = srcs
  end

  # どこかの文節に係っているか
  def depends?
    self.dst != -1
  end

  def surfaces
    self.morphs.map { |morph| morph.surface unless morph.pos == "記号" }.join
  end

  def poss
    self.morphs.map(&:pos)
  end

  def path_to_root(sentence)
    self.depends? ? [self] + sentence[self.dst].path_to_root(sentence) : [self]
  end

  def sahen_wo
    self.morphs.each.with_index do |morph, i|
      next_morph = self.morphs[i+1]
      if next_morph.present? && morph.pos == "名詞" && morph.pos1 == "サ変接続" && next_morph.pos == "助詞" && next_morph.surface == "を"
        return morph.surface + next_morph.surface
      else
        return ''
      end
    end
  end

  def has_sahen_wo?
    self.sahen_wo.present?
  end
end

def dependencies(filename="../../python/5/neko.txt.cabocha")
  sentence_list = []

  File.open(filename, "r") do |lines|
    sentence = []
    chunk = Chunk.new

    lines.each.with_index do |line, i|
      if line == "EOS\n"
        sentence << chunk if chunk.morphs.present?
        sentence.each.with_index do |chunk, i|
          sentence[chunk.dst].srcs << i if chunk.depends?
        end

        sentence_list << sentence if sentence.present?
        sentence = []
        chunk = Chunk.new
      end

      line.scan(/\*\s\d+\s(?<dst>-?\d+)D/) do |dst|
        sentence << chunk if chunk.morphs.present?
        chunk = Chunk.new
        chunk.dst = dst[0].to_i
      end

      line.scan(/(?<surface>.+?)\t(?<pos>.+?),(?<pos1>.+?)(?:,.+?){4},(?<base>.+?)(?:,|$)/) do |surface, pos, pos1, base|
        chunk.morphs << Morph.new(surface, base, pos, pos1)
      end
    end

    sentence << chunk if chunk.morphs.present?
  end

  sentence_list
end
