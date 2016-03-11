########################################################

NAME := ftl_installer

# VERSION file provides one place to update the software version.
VERSION := $(shell cat VERSION)

__init__.py: ftl_installer/__init__.py.in
	sed "s/%VERSION%/$(VERSION)/" $< > ftl_installer/__init__.py

setup.py: setup.py.in
	sed "s/%VERSION%/$(VERSION)/" $< > setup.py

venv: clean __init__.py setup.py
	@echo "#############################################"
	@echo "# Creating a virtualenv"
	@echo "#############################################"
	virtualenv venv
	. venv/bin/activate && pip install -r requirements.txt
	. venv/bin/activate && python setup.py develop

clean:
	@find . -type f -regex ".*\.py[co]$$" -delete
	@find . -type f \( -name "*~" -or -name "#*" \) -delete
	@rm -fR venv
	@rm -fR setup.py ftl_installer/__init__.py
