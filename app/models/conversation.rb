class Conversation < ApplicationRecord
  validates :content, presence: true
  @@stopwords = Stopword.pluck(:word).to_set
  @@searcher = Searcher.new(Conversation.pluck(:token))
  @@lem = Lemmatizer.new

  def tokens
    unigrams = content.downcase.gsub(/[^a-z\s]/, '').split(' ')
    # remove stopwords
    unigrams = unigrams.reject { |token| @@stopwords.include?(token) }
    # lemmatization
    unigrams = unigrams.map { |token| @@lem.lemma(token) }
    bigrams = unigrams.each_cons(2).map { |a, b| "#{a} #{b}" }
    trigrams = unigrams.each_cons(3).map { |a, b, c| "#{a} #{b} #{c}" }
    unigrams + bigrams + trigrams
  end

  def self.search(query, top_n: 3)
    query_processed = Conversation.new(content: query).tokens
    indices = @@searcher.search(query_processed, top_n:)
    # select the conversations at the indices according to their position in the database
    Conversation.where(id: indices.map { |i| Conversation.all[i].id })
  end
end
