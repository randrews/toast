module Toast
  class ConsoleChannel < Channel
    def initialize responder_class
      super responder_class
      @hear_commands=true
      @exit_now=false
    end
    
    def send msg, to
      puts ""
      puts msg unless msg.nil?
    end

    def next_line
      line = Readline::readline('> ')
      return nil unless line
      Readline::HISTORY.push(line)
      line
    end

    def self.run responder_class
      channel=ConsoleChannel.new responder_class
      channel.run
    end

    def run
      send "Type .exit or ctrl-D to leave",""
      loop do
        msg=next_line
        break unless msg
        handle_line msg
        break if @exit_now
      end
      send nil,nil
    end

    def handle_line line
      if (line[0,1]=='.' && @hear_commands) ||
          line=~/\.commands\s+on/

        result=special_cmd line
        return if @exit_now
        send result,'' if result

      else
        handle Toast::Message.new(line,'console@localhost')
      end
    end

    def special_cmd cmd
      if cmd=='.exit'
        @exit_now=true
        return nil

      elsif cmd=~/^\.srand\s+([0-9]+)/
        srand $1.to_i
        return "Random seed is #{$1}"

      elsif cmd=~/^\.commands\s+(on|off)/
        @hear_commands=($1=='on')
        return "Commands are #{$1}"

      elsif cmd=~/^.script\s+(\S+)/
        old_dir=@current_dir

        file=$1
        unless file=~/^\// # if it's a relative path, then tack @current_dir on
          file=File.expand_path(@current_dir+"/"+file)
        end

        @current_dir=File.dirname(file)
        
        File.new(file).each do |line|
          handle_line line.strip unless line.blank? || line=~/^\s*#/
          break if @exit_now
        end

        @current_dir=old_dir
        return nil

      elsif cmd=~/^.send\s+(.*)/
        args=$1.strip.split(/\s+/)
        fn=args.shift.to_sym
        begin
          response=responder_for('console@localhost').send(fn, *args)
        rescue
          response=$!.to_s
        end
        return response
      end

      return "Bad command #{cmd}"
    end

  end
end
