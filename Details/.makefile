YEAR	= 2026

# Note: Since the destination is six different directories, there is no clean way
#       to make a generic `%.txt: %.yaml` rule.  So don't bother trying.  :)

MaGalKeyVal	= ma-gal-keyval.txt
MaGalJson	= ../JSON/MetArt/Galleries/$(YEAR).json
MaGalYaml	= ../YAML/MetArt/Galleries/$(YEAR).yaml
MaMovKeyVal	= ma-gal-keyval.txt
MaMovJson	= ../JSON/MetArt/Movies/$(YEAR).json
MaMovYaml	= ../YAML/MetArt/Movies/$(YEAR).yaml

SaGalKeyVal	= sa-gal-keyval.txt
SaGalJson	= ../JSON/SexArt/Galleries/$(YEAR).json
SaGalYaml	= ../YAML/SexArt/Galleries/$(YEAR).yaml
SaMovKeyVal	= sa-gal-keyval.txt
SaMovJson	= ../JSON/SexArt/Movies/$(YEAR).json
SaMovYaml	= ../YAML/SexArt/Movies/$(YEAR).yaml

VtGalKeyVal	= vt-gal-keyval.txt
VtGalJson	= ../JSON/VivThomas/Galleries/$(YEAR).json
VtGalYaml	= ../YAML/VivThomas/Galleries/$(YEAR).yaml
VtMovKeyVal	= vt-gal-keyval.txt
VtMovJson	= ../JSON/VivThomas/Movies/$(YEAR).json
VtMovYaml	= ../YAML/VivThomas/Movies/$(YEAR).yaml

KEYVAL	= $(MaGalKeyVal) $(MaMovKeyVal) $(SaGalKeyVal) $(SaMovKeyVal) $(VtGalKeyVal) $(VtMovKeyVal)
JSON	= $(MaGalJson) $(MaMovJson) $(SaGalJson) $(SaMovJson) $(VtGalJson) $(VtMovJson)
YAML	= $(MaGalYaml) $(MaMovYaml) $(SaGalYaml) $(SaMovYaml) $(VtGalYaml) $(VtMovYaml)


default:	$(JSON) $(YAML)
json:	$(JSON)
yaml:	$(YAML)


# Individual YAML files.

$(MaGalYaml): $(MaGalKeyVal) .makefile
	@echo "Rendering $< --> $@"
	@nnma kv --yaml $< > $@

$(MaMovYaml): $(MaMovKeyVal) .makefile
	@echo "Rendering $< --> $@"
	@nnma kv --yaml $< > $@

$(SaGalYaml): $(SaGalKeyVal) .makefile
	@echo "Rendering $< --> $@"
	@nnma kv --yaml $< > $@

$(SaMovYaml): $(SaMovKeyVal) .makefile
	@echo "Rendering $< --> $@"
	@nnma kv --yaml $< > $@

$(VtGalYaml): $(VtGalKeyVal) .makefile
	@echo "Rendering $< --> $@"
	@nnma kv --yaml $< > $@

$(VtMovYaml): $(VtMovKeyVal) .makefile
	@echo "Rendering $< --> $@"
	@nnma kv --yaml $< > $@


# Individual JSON files.

$(MaGalJson): $(MaGalKeyVal) .makefile
	@echo "Rendering $< --> $@"
	@nnma kv --yaml $< > $@

$(MaMovJson): $(MaMovKeyVal) .makefile
	@echo "Rendering $< --> $@"
	@nnma kv --yaml $< > $@

$(SaGalJson): $(SaGalKeyVal) .makefile
	@echo "Rendering $< --> $@"
	@nnma kv --yaml $< > $@

$(SaMovJson): $(SaMovKeyVal) .makefile
	@echo "Rendering $< --> $@"
	@nnma kv --yaml $< > $@

$(VtGalJson): $(VtGalKeyVal) .makefile
	@echo "Rendering $< --> $@"
	@nnma kv --yaml $< > $@

$(VtMovJson): $(VtMovKeyVal) .makefile
	@echo "Rendering $< --> $@"
	@nnma kv --yaml $< > $@


.PHONY: clean
clean:
	@echo "Removing all $(YEAR).yaml and $(YEAR).json files."
	@rm -f $(YAML) $(JSON)

.PHONY: all
all:
	@echo "Rendering all..."
	@../render-all.sh

