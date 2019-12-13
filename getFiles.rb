def requireRubyFiles(folder)
  # Requires all ruby files in a folder within the relative directory

  fileArray = Dir.glob("#{folder}/*.rb")
  fileArray = fileArray.sort

  fileArray.each do |n|
    require_relative "#{n}"
  end
end

def requireManyRubyFiles(folderArray)
  # Calls a getFiles for all folder names within the array

  folderArray.each do |n|
    requireRubyFiles(n)
  end
end

def getFileLines(filePath, isEachLineArray = false, splitter = ",")
  # Returns an array with each index being a line on the file found at the filePath. Optionally returns an array of arrays where each line gets split up by the splitter

  temp = []
  File.open(filePath, "r") do |f|
    f.each_line do |line|
      if isEachLineArray
        temp.push(line.delete("\n").split(splitter))
      else
        temp.push(line.delete("\n"))
      end
    end
  end

  return temp
end

def getFiles(folder, extension = "txt")

  fileArray = Dir.glob("#{folder}/*.#{extension}")
  return fileArray.sort
end

def writeLines(filePath, toWriteArray = [])
  # Writes or overwrites a file where each index in the toWriteArray is a line on the file

  File.open(filePath, "w+") do |f|
    toWriteArray.each do |line|
      f.puts(line)
    end
  end
end
