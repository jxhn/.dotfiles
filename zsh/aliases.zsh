alias reload!='. ~/.zshrc'
alias gentags="find . -type f -iregex .*\.js$ -not -path \"./node_modules/*\" -exec jsctags {} -f \; | sed '/^$/d' | sort > tags"
