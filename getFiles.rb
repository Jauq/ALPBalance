def getFiles(folder) #requires all ruby files in a folder within the relative directory
	a = Dir.glob("#{folder}/*.rb")
	#print a
	#puts ""

	a.each do |z|
		require_relative "#{z}"
	end
end

def getManyFiles(folderArray) #calls a getFiles for all folder names within the array
	folderArray.each do |x|
		getFiles(x)
	end
end