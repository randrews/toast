module Toast
  Message = Struct.new(:text, :from)

  class Message
    def to_s ; @text ; end
  end
end

class String
  def escape
    gsub("\\","\\\\").gsub("\n","\\n")
  end

  def unescape
    gsub("\\n","\n").gsub("\\\\","\\")
  end
end

class Symbol
  def to_proc
    Proc.new {|_| _.send self}
  end
end

def delete_emacs_temp dir="."
  Dir.glob(dir+"/*").each do |file|
    if File.directory? file
      delete_emacs_temp file
    end
    if file=~/~$/
      puts "deleting #{file}"
      File.delete file
    end
  end
end
