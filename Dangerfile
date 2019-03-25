##Dangerfile - beforeScript 
#This will run as soon as the VM in CI boots up -- a few minutes after the pr is created.

#To to add your own warnings, errors you can call "warn" for a warning, "failure" for error
#Checkout danger references for more - https://danger.systems/reference.html

## Helper Functions

#Get Start Index of a file(first line)
def getStartIndexforFile(file, diff)
  pattern = "+++ b/" + file + "\n"
  file_start = diff.index(pattern)

  # Files containing spaces sometimes have a trailing tab
  pattern2 = "+++ b/" + file + "\t\n"
  if file_start.nil?
    file_start = diff.index(pattern2)
  end

  return file_start + 1
end

def findLineOfDiffInFile(file, diff)
  pattern = "+++ b/" + file + "\n"
  file_start = diff.index(pattern) + 1

  # Files containing spaces sometimes have a trailing tab
  pattern2 = "+++ b/" + file + "\t\n"
  if file_start.nil?
    file_start = diff.index(pattern2) + 1
  end

  count = 0
  lastIndex = 0
  
  #We need to match the unified format in the diff of the file, and extract the last visible line on github
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

##Code

#Start Github review
github.review.start

#See if model Identifier is same as the file naming suggests
def checkDataModelIdentifier(file, diff)
    #The function extracts xcdatamodel/ file, checks for the 'userDefinedModelVersionIdentifier' key and matches the identifier.
    values = {"hasPassed" => false, "lineNumber" => nil, "shouldBe" => nil} 
    file_start = getStartIndexforFile file, diff
    extension = 'xcdatamodel/'
    fileLine = file.scan(/[0-9]*\.#{extension}/)
  
    if fileLine.count == 0 
      values["hasPassed"] = true
      return values
    end
  
    fileIdentiferArray = fileLine[0].scan(/[0-9]+/)
    fileIdentifer = 0
  
    if fileIdentiferArray.count != 0
      fileIdentifer = fileIdentiferArray[0]
    end
  
    values["shouldBe"] = fileIdentifer
  
    changesLine = diff[file_start] 
    changedLinesString = changesLine.scan(/\+[0-9]*,[0-9]*\s/)[0].scan(/[0-9]+/)
    currentLine = changedLinesString[0].to_i - 1
    
    #Iterate throgh the diff, starting from file_start to find the key 'userDefinedModelVersionIdentifier'
    diff.drop(file_start).each do |line|
      currentLine += 1
      key = 'userDefinedModelVersionIdentifier'
      identiferLine = line.scan(/#{key}="[0-9]*"/)
  
      if identiferLine.count != 0
        identifier = identiferLine[0].scan(/[0-9]+/)[0]
  
        if identifier == fileIdentifer
          values["hasPassed"] = true
          break
        else
          values["lineNumber"] = currentLine - 1
        end
        break
      end 
    end
  
    return values
  end

#Get changed files
changedFiles = git.added_files + git.modified_files - git.deleted_files

#Check if the file is dataModel file, if so check if the version is consistent with identifier
#If not, raise an error in the comments
changedFiles.each { |file|
  if file.index(".xcdatamodel")
    lineNumber = findLineOfDiffInFile file, github.pr_diff.lines
    warn("xcdatamodel was edited/added, make sure the version number is consistent", sticky: false, file: file, line: lineNumber)
    # values = checkDataModelIdentifier(file, github.pr_diff.lines)
    # if !values["hasPassed"]
    #   failure("The Core Data Model identifier is not consistent with the file name, should be #{values["shouldBe"]}", file: file, line: values["lineNumber"])
    # end
  end
}

# Warn when there is a big PR
if git.lines_of_code > 1500
    warn("This PR is huge! Maybe try splitting this into separate tasks next time 🙂")
end

# To encourage writing a description about the PR
if github.pr_body.length < 5
    warn("You should provide a summary in the description so that the reviewer has more context 🤔") 
end

# Thank the author for their work
message "Thank you so much for your work here @#{github.pr_author} 🎉"

#warn if the Podfile was changed
if git.modified_files.include? “Podfile” 
	lineNumber = findLineOfDiffInFile 'Podfile', github.pr_diff.lines
	warn("Podfile was edited, external dependencies might have been added", sticky: false, file: 'Podfile', line: lineNumber)
end

#Run swiftlint, please check the .swiftlint.yml file to see the enabled rules.
swiftlint.lint_files inline_mode: true
github.review.fail('There were lint warnings in your code.') if swiftlint.warnings.count > 0
