YEAR	= 2025

default: ../YAML/Galleries/MetArt/$(YEAR).yaml ../YAML/Galleries/SexArt/$(YEAR).yaml ../YAML/Galleries/VivThomas/$(YEAR).yaml ../YAML/Movies/MetArt/$(YEAR).yaml ../YAML/Movies/SexArt/$(YEAR).yaml ../YAML/Movies/VivThomas/$(YEAR).yaml

../YAML/Galleries/MetArt/$(YEAR).yaml: gal-ma.txt .makefile
	@echo "Rendering $< --> $@"
	@nnma kv $< > $@

../YAML/Galleries/SexArt/$(YEAR).yaml: gal-sa.txt .makefile
	@echo "Rendering $< --> $@"
	@nnma kv $< > $@

../YAML/Galleries/VivThomas/$(YEAR).yaml: gal-vt.txt .makefile
	@echo "Rendering $< --> $@"
	@nnma kv $< > $@

../YAML/Movies/MetArt/$(YEAR).yaml: mov-ma.txt .makefile
	@echo "Rendering $< --> $@"
	@nnma kv $< > $@

../YAML/Movies/SexArt/$(YEAR).yaml: mov-sa.txt .makefile
	@echo "Rendering $< --> $@"
	@nnma kv $< > $@

../YAML/Movies/VivThomas/$(YEAR).yaml: mov-vt.txt .makefile
	@echo "Rendering $< --> $@"
	@nnma kv $< > $@

.PHONY: clean
clean:
	@echo "Removing all $(YEAR).yaml files."
	@rm -f ../YAML/*/*/$(YEAR).yaml

.PHONY: all
all:
	@echo "Rendering all..."
	@../render-all-to-yaml.sh

