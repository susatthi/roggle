.PHONY: get-dependences
get-dependences:
	dart pub get

.PHONY: test
test:
	dart format --set-exit-if-changed .
	dart analyze --fatal-infos --fatal-warnings lib
	dart test --coverage=coverage
	dart run coverage:format_coverage --lcov --in=coverage --out=coverage/lcov.info --packages=.dart_tool/package_config.json --report-on=lib
	genhtml coverage/lcov.info -o coverage/html
	open coverage/html/index.html

.PHONY: doc
doc:
	rm -rf doc/api
	dartdoc
	open doc/api/index.html
