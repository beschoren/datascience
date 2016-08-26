module Gnuplot
	DEFAULT_FORMAT = 'set terminal svg'
	DEFAULT_OUTPUT = 'set output "plot.svg"'
	DEFAULTS = [DEFAULT_FORMAT, DEFAULT_OUTPUT]
  
  class Plot
  	def initialize(commands = DEFAULTS)
  		@commands = commands
  	end

  	def add(commands)
  		@commands += [*commands]
  	end

  	def run()
  		IO.popen("gnuplot","w") {|io| io.puts @commands}
  	end

  	def plot(x, y, options={:options => "linespoints" })
  		matrix = [x, y].transpose
			add('plot "-" with ' + options[:options])
			matrix.each { |pair| add("#{pair[0]} #{pair[1]}")}
			add("e")
			run
  	end
  end
end

