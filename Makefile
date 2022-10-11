DART := dart

.PHONY: get-dependencies
get-dependencies:
	$(DART) pub get

.PHONY: test
test:
	$(DART) format --set-exit-if-changed .
	$(DART) analyze --fatal-infos --fatal-warnings .
	$(DART) test --coverage=coverage
	$(DART) run coverage:format_coverage --lcov --in=coverage --out=coverage/lcov.info --packages=.dart_tool/package_config.json --report-on=lib
	genhtml coverage/lcov.info -o coverage/html
	open coverage/html/index.html

.PHONY: dartdoc
dartdoc:
	rm -rf doc/api
	dartdoc
	open doc/api/index.html