require 'pry'

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

  def depends?
    self.dst != -1
  end

  def surfaces
    surfaces = self.morphs.map do |morph|
      morph.surface unless morph.pos == "記号"
    end
    surfaces.join
  end

  def poss
    self.morphs.map(&:pos)
  end

  def path_to_root(sentence)
    if self.dst == -1
      [self]
    else
      [self] + sentence[self.dst].path_to_root(sentence)
    end
  end
end

def dependencies(filename="../../python/5/neko.txt.cabocha")
  sentence_list = []

  File.open(filename, "r") do |lines|
    sentence = []
    chunk = Chunk.new

    lines.each.with_index do |line, i|
      if line == "EOS\n"
        sentence << chunk unless chunk.morphs.empty?
        sentence.each.with_index do |chunk, i|
          unless chunk.dst == -1
            sentence[chunk.dst].srcs << i
          end
        end

        sentence_list << sentence unless sentence.empty?
        sentence = []
        chunk = Chunk.new
      end

      line.scan(/\*\s\d+\s(?<dst>-?\d+)D/) do |dst|
        sentence << chunk unless chunk.morphs.empty?
        chunk = Chunk.new
        chunk.dst = dst[0].to_i
      end

      line.scan(/(?<surface>.+?)\t(?<pos>.+?),(?<pos1>.+?)(?:,.+?){4},(?<base>.+?)(?:,|$)/) do |surface, pos, pos1, base|
        chunk.morphs << Morph.new(surface, base, pos, pos1)
      end
    end

    sentence << chunk unless chunk.morphs.empty?
  end

  sentence_list
end
