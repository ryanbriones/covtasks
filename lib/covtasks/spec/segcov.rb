require 'rake/tasklib'

module CovTasks
  module Spec
    class SegCov < Rake::TaskLib
      attr_accessor :spec_opts
      attr_accessor :rcov_opts
      attr_accessor :ruby_cmd
      attr_accessor :verbose

      def initialize(name=:segcov)
        @name = name
        @spec_files = []
        @spec_opts = []
        @rcov_opts = []
        @rcov_include_files = []
        @verbose = true

        yield self if block_given?
      end

      def define
        spec_script = `which spec`.chomp
        if spec_script.nil? || spec_script == ""
          spec_script = 'script/spec'
        end

        task @name do
          collect_files_to_run
          load_spec_opts_file
          load_rcov_opts_file
          add_segcov_rcov_opts
          
          unless @spec_files.empty?
            rm_rf('coverage') if File.exists?(File.join(Dir.pwd, 'coverage'))
            
            cmd_parts = [ruby_cmd || RUBY]
            cmd_parts << "-S rcov"
            cmd_parts += rcov_opts
            cmd_parts << spec_script
            cmd_parts << "--"
            cmd_parts += @spec_files
            cmd_parts += @spec_opts
            
            cmd = cmd_parts.join(' ')
            puts cmd if verbose
            unless system(cmd)
              raise("Command #{cmd} failed")
            end
          end
        end
      end

      def self.define!(name=:segcov, &block)
        self.new(name, &block).define
      end

      def self.run!
        self.define!.invoke
      end

      def collect_files_to_run
        @rcov_include_files = ENV['FILES'].split(/,/).select { |file|
          unless File.exists?(spec_for_file(file))
            STDERR.puts "Missing spec file: #{spec_for_file(file)}"
            next false
          end
          
          true
        }

        @spec_files = @rcov_include_files.map { |file| spec_for_file(file) }
      end
      
      def spec_for_file(file)
        "spec/#{file.sub(/^app\//, '').sub(/\.rb$/, '_spec.rb')}"
      end

      def load_spec_opts_file
        if(File.exists?(File.join(Dir.pwd, 'spec/spec.opts')))
          File.readlines(File.join(Dir.pwd, 'spec/spec.opts')).each do |line|
            self.spec_opts << line.chomp
          end
        end
      end

      def load_rcov_opts_file
        if(File.exists?(File.join(Dir.pwd, 'spec/rcov.opts')))
          File.readlines(File.join(Dir.pwd, 'spec/rcov.opts')).each do |line|
            self.rcov_opts << line.chomp
          end
        end
      end

      def add_segcov_rcov_opts
        @rcov_opts << "--exclude 'app/*,lib/*,db/*,spec/*,vendor/*,config/*'"
        @rcov_opts << "--include-file '#{@rcov_include_files.join(',')}'"
      end
    end
  end
end
