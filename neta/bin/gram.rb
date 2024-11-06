#!/usr/bin/ruby

require 'set'
require 'json'

db = File.open('db.jsonl').readlines.map { |line| JSON.parse line }
images = []
ngrams = {}

db.each_with_index do |item, idx|
  url = item['url']
  description = item['description']

  images << url

  description.chomp.downcase.split(' ').each do |phrase|
    (0...phrase.size).each do |i|
      gram = []
      (0...4).each do |j|
        break if i + j >= phrase.size
        gram << phrase[i + j]
        ngram = gram.join ''
        ngrams[ngram] = Set.new if ngrams[ngram].nil?
        ngrams[ngram] << idx
      end
    end
  end
end

# set -> list
ngrams = ngrams.map { |k, a| [k, a.to_a] }.to_h

data = { images: images, ngrams: ngrams }
puts 'var data='
puts JSON.pretty_generate data
puts ';'
