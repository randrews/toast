class SimpleResponder < Toast::Responder
  def say_wait msg
    say msg
    wait
  end
  
  def respond first
    second = say_wait "first is #{first}"
    third = say_wait "second is #{second}"
    "third is #{third}"
  end
end
