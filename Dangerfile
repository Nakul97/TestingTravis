xcode_summary.report 'xcodebuild.json'

#warn if the Podfile was changed
warn "#{github.html_link("Podfile”)} was edited, external dependencies might have been added." if git.modified_files.include? “Podfile”

#warn for length
warn "Big PR, consider splitting into smaller" if git.lines_of_code > 500

swiftlint.config_file = '.swiftlint.yml'
swiftlint.binary_path = './Pods/SwiftLint/swiftlint'
swiftlint.lint_files inline_mode: true

warn "iPA Size after this PR is merged will be -- #{File.size?("xcodebuild.json")}"