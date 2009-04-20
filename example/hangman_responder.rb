class HangmanResponder < Toast::Responder
  attr_accessor :word
  attr_accessor :solved_word
  attr_accessor :alphabet
  attr_accessor :body_parts

  def say_wait msg ; say msg ; wait ; end

  def respond msg
    say 'Welcome to hangman!'
    @alphabet='abcdefghijklmnopqrstuvwxyz'
    @body_parts=6
    @word=find_word
    @solved_word='_'*word.length

    say status_msg

    while(@solved_word!=@word && @body_parts>0)
      letter=get_letter

      @alphabet[@alphabet.index(letter)]='_'

      if @word.index(letter)
        @word.split('').each_with_index do |l, i|
          @solved_word[i]=letter if(l==letter)
        end
      else
        @body_parts-= 1
        say "Oops, the word doesn't contain the letter #{letter}"
      end

      say status_msg
    end

    if(@body_parts>0)
      "Congratulations, you win! Send any message to play again."
    else
      "Sorry, you were hung. The word was #{@word}. Send any message to play again."
    end
  end

  def get_letter
    letter=say_wait "Choose a letter"
    letter_good=false

    loop do
      letter=letter.downcase
      
      unless letter=~/^[a-z]$/
        letter=say_wait "That's not a letter, choose again"
        next
      end
      unless @alphabet.index letter
        letter=say_wait "You've already used that letter, choose again"
        next
      end

      return letter
    end
  end

  def find_word
    max=(`wc -l /usr/share/dict/words`).split[0].to_i
    line=rand(max)

    word=nil
    file=File.new('/usr/share/dict/words')

    line.times do
      word=file.gets
    end

    word.chomp
  end

  def status_msg
    "#{@solved_word.split('').join(' ')}\n#{body_part_msg} remaining\n#{@alphabet.split('').join(' ')}"
  end

  def body_part_msg
    @body_parts==1 ? "#{@body_parts} body part" : "#{@body_parts} body parts"
  end
end
