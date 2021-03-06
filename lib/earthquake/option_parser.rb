# encoding: UTF-8
require 'slop'

module Earthquake
  class OptionParser
    def initialize(argv)
      @argv = argv
      @slop = setup_slop
    end

    def parse
      @slop.parse!(@argv)
      options = @slop.to_hash
      options.delete(:help)
      options[:dir] = @argv.shift unless @argv.empty?
      options
    end

    private

    def setup_slop
      Slop.new(:strict => true, :help => true).tap do |s|
        s.banner 'Usage: earthquake [options] [directory]'
        s.on :d, :debug, 'Enable debug mode'
        s.on :n, :'no-logo', 'No Logo'
        s.on :c, :command, 'Invoke a command and exit', :argument => true
        s.on :'--no-stream', 'No stream mode'
      end
    end
  end
end
