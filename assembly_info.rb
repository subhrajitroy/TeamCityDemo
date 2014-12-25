
class AssemblyInfo

	 def initialize version,path
	 	@path = path
	 	@version = version
	 end


def create()
		content = %Q[
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

[assembly: AssemblyTitle("StringTest")]
[assembly: AssemblyDescription("")]
[assembly: AssemblyConfiguration("")]
[assembly: AssemblyCompany("TW")]
[assembly: AssemblyProduct("StringTest")]
[assembly: AssemblyCopyright("Copyright © TW.com 2014")]
[assembly: AssemblyTrademark("")]
[assembly: AssemblyCulture("")]

[assembly: ComVisible(false)]

[assembly: AssemblyVersion("#{@version}")]
[assembly: AssemblyFileVersion("#{@version}")]
	]

		File.open(@path,"w+"){|file| file.write(content)}

		puts "Created file @ #{@path}" 
end

end