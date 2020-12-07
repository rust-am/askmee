module QuestionsHelper

  def inclination(num, words)
    # return words[3] if num == 0
    div10 = num % 10
    div100 = num % 100
    return words[2] if [11, 12, 13, 14].include?(div100)
    return words[0] if div10 == 1
    return words[1] if [2, 3, 4].include?(div10)
    return words[2]
  end
end
