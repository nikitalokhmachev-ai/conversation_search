class StopwordsController < ApplicationController
  def index
    @stopwords = Stopword.all
  end

  def new
    @stopword = Stopword.new # Create a new stopword instance
  end

  def create
    # This method is responsible for processing the form submission.
    path = params[:path]

    if path.blank?
      redirect_to new_stopword_path,
                  alert: 'Please provide either a directory of text files or a path to a stop words file.'
      return
    end

    content = File.read(path)
    stopwords = content.split("\n").to_set
    stopwords.each do |word|
      Stopword.create(word:)
    end

    redirect_to stopwords_path, notice: 'stopwords createed successfully.'
  end
end
