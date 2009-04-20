module Toast
  module ConsoleUtils
    def self.get_bot_class_for_name bot_name=nil

      # If it's nil, show a menu for .
      if bot_name.nil?
        file=show_menu_for_directory '.'
        load file
        return class_for_file_name(file)
      end

      # If it's a file, then we just use it
      if File.file? bot_name
        load bot_name
        return class_for_file_name(bot_name)
      end

      # if it's not a .rb file, but is present, it's a directory
      if File.directory? bot_name
        file=show_menu_for_directory(bot_name)
        load file
        return class_for_file_name(file)
      end

      raise "Can't find #{bot_name}"
    end

    def self.show_menu_for_directory path
      n=0
      Dir.glob("#{path}/*.rb").each do |file|
        n+=1
        name=File.basename(file,'.rb')
        puts "- #{name}"
        Readline::HISTORY.push(name)
      end

      if n==0
        path="current directory" if path=='.'
        raise "No .rb files found in #{path}"
      end

      bot_name=Readline::readline('Which bot: ')
      n.times {Readline::HISTORY.shift}

      return "#{path}/#{bot_name}.rb"
    end

    def self.class_for_file_name file
      File.basename(file,'.rb').classify.constantize
    end
  end
end
