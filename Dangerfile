xcode_summary.report 'xcodebuild.json'

#warn if the Podfile was changed
warn "#{github.html_link("Podfile”)} was edited, external dependencies might have been added." if git.modified_files.include? “Podfile”

github.dismiss_out_of_range_messages

swiftlint.config_file = '.swiftlint.yml'
swiftlint.binary_path = './Pods/SwiftLint/swiftlint'
swiftlint.lint_files inline_mode: true
