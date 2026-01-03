YEAR	= 2026

# Note: Since the destination is six different directories, there is no clean way
#       to make a generic `%.txt: %.yaml` rule.  So don't bother trying.  :)

MaKeyVal	= ma-keyval.txt
MaJson		= ../JSON/MetArt/$(YEAR).json
MaYaml		= ../YAML/MetArt/$(YEAR).yaml

SaKeyVal	= sa-keyval.txt
SaJson		= ../JSON/SexArt/$(YEAR).json
SaYaml		= ../YAML/SexArt/$(YEAR).yaml

VtKeyVal	= vt-keyval.txt
VtJson		= ../JSON/VivThomas/$(YEAR).json
VtYaml		= ../YAML/VivThomas/$(YEAR).yaml


KEYVAL	= $(MaKeyVal) $(SaKeyVal) $(VtKeyVal)
JSON	= $(MaJson) $(SaJson) $(VtJson) 
YAML	= $(MaYaml) $(SaYaml) $(VtYaml) 


default:	$(JSON) $(YAML)
json:	$(JSON)
yaml:	$(YAML)


# YAML files.

$(MaYaml): $(MaKeyVal) .makefile
	@echo "Rendering $@"
	@nnma kv --yaml $< > $@

$(SaYaml): $(SaKeyVal) .makefile
	@echo "Rendering $@"
	@nnma kv --yaml $< > $@

$(VtYaml): $(VtKeyVal) .makefile
	@echo "Rendering $@"
	@nnma kv --yaml $< > $@


# JSON files.

$(MaJson): $(MaKeyVal) .makefile
	@echo "Rendering $@"
	@nnma kv --yaml $< > $@

$(SaJson): $(SaKeyVal) .makefile
	@echo "Rendering $@"
	@nnma kv --yaml $< > $@

$(VtJson): $(VtKeyVal) .makefile
	@echo "Rendering $@"
	@nnma kv --yaml $< > $@


.PHONY: clean
clean:
	@echo "Removing all $(YEAR).yaml and $(YEAR).json files."
	@rm -f $(YAML) $(JSON)

.PHONY: all
all:
	@echo "Rendering all..."
	@../render-all.sh

