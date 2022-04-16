bin := html2gmi
input_dir := input/
output_dir := output/
location := temp.txt
dest := temp2.txt

setup:
	go install
	go build
	@if [ ! -d $(input_dir) ]; then \
		mkdir $(input_dir); \
	fi
	@if [ ! -d $(output_dir) ]; then \
		mkdir $(output_dir); \
	fi

all: setup clear
	touch $(location)
	find -type f -name '*.htm' >> $(location)
	find -type f -name '*.html' >> $(location)
	find -type f -name '*.xhtml' >> $(location)
	
	sed 's/.\/input/.\/output/g' $(location) | sed 's/\// /g' | awk '{$$NF="";print}' | sed 's/ /\//g' > $(dest) 
	@# from html files get output directory
	xargs mkdir -p <$(dest)
	@#create output directories
	./script.sh

clear:
	@if [ -e $(location) ]; then \
		rm $(location); \
	fi
	@if [ -e $(dest) ]; then \
		rm $(dest); \
	fi
	@if [ -d $(output_dir) ]; then \
		rm -rf $(output_dir); \
	fi

clean: clear
	rm -rf $(bin) 

purge: clean
	rm -rf $(input_dir)
