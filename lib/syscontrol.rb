require 'sys/proctable'

module SysControl
	include Sys

	def self.kill( name )
		 ProcTable.ps do |p|
        if p.comm == name
          begin
            Process.kill(2,p.pid)
          rescue SystemCallError => e
            raise e
          else
            puts "Killed #{p.comm} with signal 2"
					end
					return
        end
		 end
		 puts "No prosess fount with name  '#{name}'"
	end


end