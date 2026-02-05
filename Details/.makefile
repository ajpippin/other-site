YEAR	= 2026
SITE   = $(HOME)/Developer/AJPippin/Other/Site

# Note: Since the destination is six different directories, there is no clean way
#       to make a generic `%.txt: %.yaml` rule.  So don't bother trying.  :)

MaKeyVal	= $(SITE)/Details/ma-keyval.txt
MaJson		= $(SITE)/Rendered/JSON/MetArt/$(YEAR).json
MaYaml		= $(SITE)/Rendered/YAML/MetArt/$(YEAR).yaml

PhKeyVal	= $(SITE)/Details/ph-keyval.txt
PhJson		= $(SITE)/Rendered/JSON/Pornhub/$(YEAR).json
PhYaml		= $(SITE)/Rendered/YAML/Pornhub/$(YEAR).yaml

SaKeyVal	= $(SITE)/Details/sa-keyval.txt
SaJson		= $(SITE)/Rendered/JSON/SexArt/$(YEAR).json
SaYaml		= $(SITE)/Rendered/YAML/SexArt/$(YEAR).yaml

VtKeyVal	= $(SITE)/Details/vt-keyval.txt
VtJson		= $(SITE)/Rendered/JSON/VivThomas/$(YEAR).json
VtYaml		= $(SITE)/Rendered/YAML/VivThomas/$(YEAR).yaml


KEYVAL	= $(MaKeyVal) $(PhKeyVal) $(SaKeyVal) $(VtKeyVal)
JSON	= $(MaJson) $(PhJson) $(SaJson) $(VtJson) 
YAML	= $(MaYaml) $(PhYaml) $(SaYaml) $(VtYaml) 


default: json push
json:	 $(JSON)
yaml:    $(YAML)

.PHONY: all
all: $(JSON) $(YAML)


# YAML files.

$(MaYaml): $(MaKeyVal) .makefile
	@echo "ma-keyval.txt --> MetArt/$(YEAR).yaml"
	@nnma kv --format=yaml $< > $@

$(PhYaml): $(PhKeyVal) .makefile
	@echo "ph-keyval.txt --> Pornhub/$(YEAR).yaml"
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

$(PhJson): $(PhKeyVal) .makefile
	@echo "ph-keyval.txt --> Pornhub/$(YEAR).json"
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

.PHONY: push
push:
	@echo ""
	@echo "Copying MA files."
	@ma push

.PHONY: ping
ping:
	@echo "Waking up goofy."
	@ssh goofy ls /Volumes/Big6/Web/Public


##

KEYVAL	= $(SITE)/KeyValue
RENDER	= $(SITE)/Rendered/JSON


redo: $(RENDER)/MetArt/2025.json $(RENDER)/SexArt/2025.json $(RENDER)/VivThomas/2025.json


$(RENDER)/MetArt/2025.json: $(KEYVAL)/MetArt/Galleries/2025.txt $(KEYVAL)/MetArt/Movies/2025.txt
	cat $(KEYVAL)/MetArt/Galleries/2025.txt $(KEYVAL)/MetArt/Movies/2025.txt | nnma kv --format=json > $(RENDER)/MetArt/2025.json
$(RENDER)/SexArt/2025.json: $(KEYVAL)/SexArt/Galleries/2025.txt $(KEYVAL)/SexArt/Movies/2025.txt
	cat $(KEYVAL)/SexArt/Galleries/2025.txt $(KEYVAL)/SexArt/Movies/2025.txt | nnma kv --format=json > $(RENDER)/SexArt/2025.json
$(RENDER)/VivThomas/2025.json: $(KEYVAL)/VivThomas/Galleries/2025.txt $(KEYVAL)/VivThomas/Movies/2025.txt
	cat $(KEYVAL)/VivThomas/Galleries/2025.txt $(KEYVAL)/VivThomas/Movies/2025.txt | nnma kv --format=json > $(RENDER)/VivThomas/2025.json

