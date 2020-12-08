module QuestionsHelper

  def inclination(num, word1, word2, word3)
    div10 = num % 10
    div100 = num % 100
    return word3 if [11, 12, 13, 14].include?(div100)
    return word1 if div10 == 1
    return word2 if [2, 3, 4].include?(div10)
    return word3
  end
end
