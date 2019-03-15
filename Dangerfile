xcode_summary.report 'errors.json'

#warn if the Podfile was changed
warn "#{github.html_link("Podfile”)} was edited, external dependencies might have been added." if git.modified_files.include? “Podfile”

swiftlint.config_file = '.swiftlint.yml'
swiftlint.binary_path = './Pods/SwiftLint/swiftlint'
swiftlint.lint_files inline_mode: true
