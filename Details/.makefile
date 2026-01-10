YEAR	= 2026
SITE   = $(HOME)/Developer/AJPippin/Other/Site

# Note: Since the destination is six different directories, there is no clean way
#       to make a generic `%.txt: %.yaml` rule.  So don't bother trying.  :)

MaKeyVal	= $(SITE)/Details/ma-keyval.txt
MaJson		= $(SITE)/Rendered/JSON/MetArt/$(YEAR).json
MaYaml		= $(SITE)/Rendered/YAML/MetArt/$(YEAR).yaml

SaKeyVal	= $(SITE)/Details/sa-keyval.txt
SaJson		= $(SITE)/Rendered/JSON/SexArt/$(YEAR).json
SaYaml		= $(SITE)/Rendered/YAML/SexArt/$(YEAR).yaml

VtKeyVal	= $(SITE)/Details/vt-keyval.txt
VtJson		= $(SITE)/Rendered/JSON/VivThomas/$(YEAR).json
VtYaml		= $(SITE)/Rendered/YAML/VivThomas/$(YEAR).yaml


KEYVAL	= $(MaKeyVal) $(SaKeyVal) $(VtKeyVal)
JSON	= $(MaJson) $(SaJson) $(VtJson) 
YAML	= $(MaYaml) $(SaYaml) $(VtYaml) 


default: json
json:	 $(JSON)
yaml:    $(YAML)

.PHONY: all
all: $(JSON) $(YAML)


# YAML files.

$(MaYaml): $(MaKeyVal) .makefile
	@echo "ma-keyval.txt --> MetArt/$(YEAR).yaml"
	@nnma kv --format=yaml $< > $@

$(SaYaml): $(SaKeyVal) .makefile
	@echo "sa-keyval.txt --> SexArt/$(YEAR).yaml"
	@nnma kv --format=yaml $< > $@

$(VtYaml): $(VtKeyVal) .makefile
	@echo "vt-keyval.txt --> VivThomas/$(YEAR).yaml"
	@nnma kv --format=yaml $< > $@


# JSON files.

$(MaJson): $(MaKeyVal) .makefile
	@echo "ma-keyval.txt --> MetArt/$(YEAR).json"
	@nnma kv --format=json $< > $@

$(SaJson): $(SaKeyVal) .makefile
	@echo "sa-keyval.txt --> SexArt/$(YEAR).json"
	@nnma kv --format=json $< > $@

$(VtJson): $(VtKeyVal) .makefile
	@echo "vt-keyval.txt --> VivThomas/$(YEAR).json"
	@nnma kv --format=json $< > $@


.PHONY: clean
clean:
	@echo "Removing all $(YEAR).yaml and $(YEAR).json files."
	@rm -f $(YAML) $(JSON)

