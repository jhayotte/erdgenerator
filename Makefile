.PHONY: build
build:
	docker build -t jhayotte/erdgenerator .

.PHONY: run
run:
	# this makefile runs erdgenerator with a specific database and export its model in a pdf.
	./script.sh mydockername mydatabasename mylogin mypassword
