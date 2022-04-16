bin := html2gmi
input_dir := input/
output_dir := output/
location := temp.txt
dest := temp2.txt
output_files := temp3.txt

setup:
	go install
	go build
	@if [ ! -d $(input_dir) ]; then \
		mkdir $(input_dir); \
	fi
	@if [ ! -d $(output_dir) ]; then \
		mkdir $(output_dir); \
	fi

all: setup del_temp
	touch $(location)
	find -type f -name '*.htm' >> $(location)
	find -type f -name '*.html' >> $(location)
	find -type f -name '*.xhtml' >> $(location)
	
	sed 's/.\/input/.\/output/g' $(location) | sed 's/\// /g' | awk '{$$NF="";print}' | sed 's/ /\//g' > $(dest) 
	#sed 's/.\/input/.\/output/g' $(location) | sed 's/.xhtml/.gmi/g;s/.html/.gmi/g;s/.htm/.gmi/g'  > $(output_files) 
	@# from html files get output directory
	xargs mkdir -p <$(dest)
	@#create output directories
	./script.sh

del_temp:
	@if [ -e $(location) ]; then \
		rm $(location); \
	fi
	@if [ -e $(dest) ]; then \
		rm $(dest); \
	fi
	@if [ -e $(output_files) ]; then \
		rm $(output_files); \
	fi

clean: del_temp
	rm -rf $(bin) $(output_dir)

purge: clean del_temp
	rm -rf $(input_dir)
