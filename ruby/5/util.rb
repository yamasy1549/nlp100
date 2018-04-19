require 'pry'
require 'active_record'

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

  def initialize(morphs: [], dst: -1, srcs: [])
    @morphs = morphs
    @dst = dst
    @srcs = srcs
  end

  # どこかの文節に係っているか
  def depends?
    self.dst != -1
  end

  # surfaceをまとめて文字列で返す
  def surfaces(symbol: false)
    surfaces = symbol ? self.morphs : self.morphs.reject { |morph| morph.pos == '記号' }
    surfaces.map { |morph| morph.surface }.join
  end

  # 特定の品詞を含むか
  def has_pos?(pos)
    self.morphs.map(&:pos).include?(pos)
  end

  # 最左にある特定の品詞
  def first_morph(pos)
    self.morphs.find { |morph| morph.pos == pos }
  end

  def path_to_root(sentence)
    self.depends? ? [self] + sentence[self.dst].path_to_root(sentence) : [self]
  end

  # サ変接続名詞 + を（助詞）
  def sahen_wo
    self.morphs.each.with_index do |morph, i|
      next_morph = self.morphs[i+1]
      if next_morph.present? && next_morph.pos == '助詞' && next_morph.surface == 'を' \
         && morph.pos == '名詞' && morph.pos1 == 'サ変接続'
        return morph.surface + 'を'
      else
        return ''
      end
    end
  end

  def has_sahen_wo?
    self.sahen_wo.present?
  end
end

def dependencies(filename: '../../data/neko.txt.cabocha')
  sentence_list = []

  File.open(filename) do |lines|
    sentence = []
    chunk = Chunk.new

    lines.each do |line|
      # 文節のはじめ
      line.scan(/\*\s\d+\s(?<dst>-?\d+)D/) do |(dst)|
        sentence << chunk if chunk.morphs.present?
        chunk = Chunk.new(dst: dst.to_i)
      end

      # 形態素
      line.scan(/(?<surface>.+?)\t(?<pos>.+?),(?<pos1>.+?)(?:,.+?){4},(?<base>.+?)(?:,|$)/) do |surface, pos, pos1, base|
        chunk.morphs << Morph.new(surface, base, pos, pos1)
      end

      # 文のおわり
      if line == "EOS\n" && chunk.morphs.present?
        sentence << chunk
        sentence.each.with_index do |chunk, i|
          sentence[chunk.dst].srcs << i if chunk.depends?
        end
        sentence_list << sentence
        sentence = []
        chunk = Chunk.new
      end
    end
  end

  sentence_list
end
