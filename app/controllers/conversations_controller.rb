class ConversationsController < ApplicationController
  def index
    @conversations = Conversation.all
  end

  def new
    @conversation = Conversation.new # Create a new Conversation instance
  end

  def create
    # This method is responsible for processing the form submission.

    path = params[:path]

    if path.blank?
      redirect_to new_conversation_path,
                  alert: 'Please provide either a directory of text files or a path to a stop words file.'
      return
    end

    # Iterate through text files in the directory and create them
    Dir.glob("#{path}/*.txt").each do |file_path|
      content = File.read(file_path)
      Conversation.create(content:)
    end

    # create tokens for each conversation
    Conversation.all.each do |conversation|
      conversation.update(token: conversation.tokens)
    end
    redirect_to conversations_path, notice: 'Conversations created successfully.'
  end

  def search
    query = params[:query]
    top_n = params[:top_n].to_i
    @results = if query.blank?
                 []
               else
                 Conversation.search(query, top_n:)
               end
  end
end
