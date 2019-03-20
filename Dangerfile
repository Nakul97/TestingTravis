require 'json'

puts("here")

def getStartIndexforFile(file, diff)
  pattern = "+++ b/" + file + "\n"
  puts(diff.index(pattern))
  file_start = diff.index(pattern)

  # Files containing spaces sometimes have a trailing tab
  pattern2 = "+++ b/" + file + "\t\n"
  if file_start.nil?
    file_start = diff.index(pattern2)
  end

  return file_start + 1
end

def checkDataModelIdentifier(file, diff)
  values = {"hasPassed" => false, "lineNumber" => nil, "shouldBe" => nil} 
  file_start = getStartIndexforFile file, diff
  extension = 'xcdatamodel/'
  fileLine = file.scan(/[0-9]*\.#{extension}/)

  if fileLine.count == 0 
    values["hasPassed"] = true
    return values
  end

  fileIdentiferArray = fileLine[0].scan(/[0-9]/)
  fileIdentifer = 0

  if fileIdentiferArray.count != 0
    fileIdentifer = fileIdentiferArray[0]
  end

  values["shouldBe"] = fileIdentifer

  changesLine = diff[file_start] 
  changedLinesString = changesLine.scan(/\+[0-9]*,[0-9]*\s/)[0].scan(/[0-9]+/)
  currentLine = changedLinesString[0].to_i - 1

  diff.drop(file_start).each do |line|
    currentLine += 1
    key = 'userDefinedModelVersionIdentifier'
    identiferLine = line.scan(/#{key}="[0-9]*"/)

    if identiferLine.count != 0
      identifier = identiferLine[0].scan(/[0-9]+/)

      if identifier == fileIdentifer
        values["hasPassed"] = true
        break
      else
        values["lineNumber"] = currentLine
      end
      break
    end 
  end

  return values
end

puts(git.modified_files)
puts(git.added_files)
#puts(github.pr_diff.lines)
#puts(find_position_in_diff github.pr_diff.lines, 
puts(github.pr_diff.lines)

changedFiles = git.added_files + git.modified_files - git.deleted_files

changedFiles.each { |file|
  if file.index(".xcdatamodel")
    values = checkDataModelIdentifier(file, github.pr_diff.lines)
    if !values["hasPassed"]
      puts("\n***********")
      puts("error in #{file}")
      puts("*******\n should be :#{values["shouldBe"]} at line #{values["lineNumber"]}")
    end
  end
}

# changedFiles.each { |file|
#   if File.extname(file) == ".m" || File.extname(file) == ".h"
#     file_start = getStartIndexforFile

#   end
# }

def findLineOfDiffInFile(file, diff)
  # pattern = /\+{3} b{1}\/#{file}\s*\n{1}/
  file_start = getStartIndexforFile file, diff
  count = 0
  lastIndex = 0

  diff.drop(file_start).each do |line| 
      if line.index("+++ b/")
        break
      end
      if line.index("@@") == 0
        lastIndex = count 
      end 
      count += 1
  end

  changesLine = diff[lastIndex + file_start]
  changedLinesString = changesLine.scan(/\+[0-9]*,[0-9]*\s/)[0].scan(/[0-9]+/)
  lineNumber = changedLinesString[0].to_i + changedLinesString[1].to_i - 1

  return lineNumber
end

puts(findLineOfDiffInFile 'TestingTravis.xcodeproj/project.pbxproj', github.pr_diff.lines)
# message = Violation.new("Podfile was edited, external dependencies might have been added", false, '.travis.yml', 13)

# puts(message)
# def find_position_in_diff(diff_lines, message, kind)
#         range_header_regexp = /@@ -([0-9]+)(,([0-9]+))? \+(?<start>[0-9]+)(,(?<end>[0-9]+))? @@.*/
#         file_header_regexp = %r{^diff --git a/.*}

#         pattern = "+++ b/" + message.file + "\n"
#         file_start = diff_lines.index(pattern)

#         # Files containing spaces sometimes have a trailing tab
#         if file_start.nil?
#           pattern = "+++ b/" + message.file + "\t\n"
#           file_start = diff_lines.index(pattern)
#         end

#         return nil if file_start.nil?
#         position = -1
#         file_line = nil

#         diff_lines.drop(file_start).each do |line|
#           # If the line has `No newline` annotation, position need increment
#           if line.eql?("\\ No newline at end of file\n")
#             position += 1
#             next
#           end
#           # If we found the start of another file diff, we went too far
#           break if line.match file_header_regexp

#           match = line.match range_header_regexp

#           # file_line is set once we find the hunk the line is in
#           # we need to count how many lines in new file we have
#           # so we do it one by one ignoring the deleted lines
#           if !file_line.nil? && !line.start_with?("-")
#             if file_line == message.line
#               file_line = nil if !line.start_with?("+")
#               break
#             end
#             file_line += 1
#           end

#           # We need to count how many diff lines are between us and
#           # the line we're looking for
#           position += 1
#           next unless match

#           range_start = match[:start].to_i
#           if match[:end]
#             range_end = match[:end].to_i + range_start
#           else
#             range_end = range_start
#           end

#           # We are past the line position, just abort
#           break if message.line.to_i < range_start
#           next unless message.line.to_i >= range_start && message.line.to_i < range_end

#           file_line = range_start
#         end
#         position unless file_line.nil?
# end




# position = find_position_in_diff github.pr_diff.lines, message, :warning

# puts(position)



