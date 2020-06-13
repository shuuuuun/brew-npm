require "json"
require "erb"
require "tempfile"
require "shellwords"

module Brew::Npm::CLI
  module_function

  COMMANDS = {
    "install"   => ("Install a brew npm, accepts an optional version argument\n" +
                    "            (e.g. brew npm install <name> [version])"),
    "upgrade"   => "Upgrade to the latest version of a brew npm",
    "uninstall" => "Uninstall a brew npm",
    "info"      => "Show information for an installed npm",
    "formula"   => "Print out the generated formula for a npm",
    "version"   => "Show version of brew-npm",
    "help"      => "This message"
  }

  HOMEBREW_NODE_FLAG = "--homebrew-node"
  SYSTEM_NODE_FLAG   = "--system-node"
  NODE_FLAGS = [HOMEBREW_NODE_FLAG, SYSTEM_NODE_FLAG]

  class Arguments
    attr_reader :node_flag

    def initialize(args)
      @node_flag          = args.select {|a| NODE_FLAGS.include?(a) }.last
      @args               = args.reject {|a| NODE_FLAGS.include?(a) }
      @args_without_flags = @args.reject {|a| a.start_with?("-") }
    end

    def command
      @args_without_flags[0]
    end

    def npm
      @args_without_flags[1]
    end

    def supplied_version
      @args_without_flags[2]
    end

    def to_args
      @args.reject {|a| a == npm || a == supplied_version }
    end
  end

  def help_msg
    (["Please specify a npm name (e.g. brew npm command <name>)"] +
      COMMANDS.map {|name, desc| "  #{name} - #{desc}"}).join("\n")
  end

  def fetch_version(name, version = nil)
    npm_info = parse_json `npm info --json "#{name}"`
    abort "Could not find a valid npm '#{name}'" if npm_info.nil?
    version ||= npm_info["version"]
    version
  end

  def parse_json(str)
    JSON.parse(str)
  rescue JSON::ParserError => err
    STDERR.puts err
    nil
  end

  def process_args(args)
    arguments = Arguments.new(args)
    command   = arguments.command
    abort help_msg unless command
    abort "unknown command: #{command}\n#{help_msg}" unless COMMANDS.keys.include?(command)

    if command == 'help'
      STDERR.puts help_msg
      exit 0
    end

    if command == 'version'
      STDERR.puts Brew::Npm::VERSION
      exit 0
    end

    arguments
  end

  def homebrew_prefix
    ENV["HOMEBREW_PREFIX"] || `brew --prefix`.chomp
  end

  def expand_formula(name, version, use_homebrew_node=false)
    klass           = "Npm" + name.capitalize.gsub(/[-_.\s]([a-zA-Z0-9])/) { $1.upcase }.gsub('+', 'x')
    user_npmrc      = "#{ENV['HOME']}/.npmrc"
    template_file   = File.expand_path("../formula.rb.erb", __FILE__)
    template        = ERB.new(File.read(template_file))
    template.result(binding) # TODO: avoid binding. specify variables.
  end

  def with_temp_formula(name, version, use_homebrew_node)
    filename = File.join Dir.tmpdir, "npm-#{name}.rb"

    open(filename, "w") do |f|
      f.puts expand_formula(name, version, use_homebrew_node)
    end

    yield filename
  ensure
    File.unlink filename
  end

  def homebrew_node?(node_flag)
    File.exist?("#{homebrew_prefix}/opt/node") &&
      node_flag.nil? || node_flag == HOMEBREW_NODE_FLAG
  end

  def run(args = ARGV)
    arguments = process_args(args)
    name      = arguments.npm
    version   = fetch_version(name, arguments.supplied_version)
    # check node/npm is installed
    # pp arguments, name, version
    # return
    with_temp_formula(name, version, homebrew_node?(arguments.node_flag)) do |filename|
      case arguments.command
      when "formula"
        $stdout.puts File.read(filename)
      else
        system "brew #{arguments.to_args.shelljoin} #{filename}"
        exit $?.exitstatus unless $?.success?
      end
    end
  end
end
