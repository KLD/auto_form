
test-coverage: 
	flutter test --coverage
	genhtml coverage/lcov.info -o coverage/html
	open coverage/html/index.html


deploy-package:
	flutter pub publish
