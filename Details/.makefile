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


KEYVAL	= $(MaKeyVal) $(PhKeyVal) $(SaKeyVal) $(VtKeyVal) $(AllCastKeyVal)
JSON	= $(MaJson) $(PhJson) $(SaJson) $(VtJson) $(AllCastJson)
YAML	= $(MaYaml) $(PhYaml) $(SaYaml) $(VtYaml) $(AllCastYaml)


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


MaCastKeyVal	= $(SITE)/Details/ma-cast.txt
MaCastJson	= $(SITE)/Rendered/JSON/MetArt/cast.json
MaCastYaml	= $(SITE)/Rendered/YAML/MetArt/cast.yaml

PhCastKeyVal	= $(SITE)/Details/ph-cast.txt
PhCastJson	= $(SITE)/Rendered/JSON/Pornhub/cast.json
PhCastYaml	= $(SITE)/Rendered/YAML/Pornhub/cast.yaml

AllCastKeyVal   = $(MaCastKeyVal) $(PhCastKeyVal)
AllCastJson     = $(MaCastJson) $(PhCastJson)
AllCastYaml     = #(MaCastYaml) $(PhCastYaml)

.PHONY: cast
cast: $(AllCastJson) $(AllCastYaml)

$(MaCastJson): $(MaCastKeyVal) .makefile
	@echo "Rendering .../JSON/MetArt/cast.json"
	@nnma kv convert --cast --format=json $< > $@

$(PhCastYaml): $(PhCastKeyVal) .makefile
	@echo "Rendering .../JSON/Pornhub/cast.json"
	@nnma kv convert --cast --format=json $< > $@
