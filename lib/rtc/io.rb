
require 'open3'
require 'timeout'

module RichTextConsole
  class ExternalProcess
    attr_reader :in, :out, :err
    def initialize(cmd)
      @in, @out, @err = Open3.popen3(cmd)
    end
    def write(t)
      @in.write(t)
    end
    def read(from=:out)
      from = case from
             when :out
               @out
             when :err
               @err
             else
               raise ArgumentError, "from must be :out or :err"
             end
      s = ""
      loop do
        Timeout.timeout(0.1) { s << from.getc } rescue break
      end
      return s
    end
    def attach(from=:out)
      raise ArgumentError, "no block given" unless block_given?
      from = case from
             when :out
               @out
             when :err
               @err
             else
               raise ArgumentError, "from must be :out or :err"
             end
      Thread.start do
        begin
          s = ""
          loop do
            begin
              Timeout.timeout(0.1) { s << from.getc }
            rescue Timeout::Error
              yield s unless s.empty?
              s = ""
            rescue Exception
              yield s unless s.empty?
              yield :stop
              self.close
              break
            end
          end
        rescue Exception
          p $!
        end
      end
    end
    def close
      @in.close
      @out.close
      @err.close
    end
  end
end
