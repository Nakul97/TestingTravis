require 'json'

#Mark review Started on github
github.review.start
#In our ignored_results block we return 'false' for the files that have been modified or added, ignoring rest of the files.
xcode_summary.ignored_results { |result| 
	!(isResultInFilesArray(git.added_files, result) || isResultInFilesArray(git.modified_files, result))
}

#Will check if a file is present in any give narray of files.
def isResultInFilesArray(filesArray, result)
	if !result.location 
		return false
	end
	filesArray.each{ |file| 
		if File.basename(file) == result.location.file_name
			return true
		end
	}
	return false
end

#Finally, we parse through all the warnings. 
#Make sure that xcode-json-formatter is being used while executing xcodebuild in travis.yml, otherwise the below line will return an error -- "Summary File not found"
xcode_summary.report 'build/reports/errors.json'
