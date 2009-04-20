class WaitResponder < Toast::Responder
  def respond msg
    say "1: #{msg}"
    "2: #{wait}"
  end
end
