class HashtagsController < ApplicationController
  def show
    # бэнг методы кидают исключения -- эксепшоны
    hashtag = Hashtag.with_questions.find_by!(text: params[:text])
    @questions = hashtag.questions
  end
end
