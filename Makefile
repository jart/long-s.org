all:
	coffeelint *.coffee
	coffee -bo . *.coffee
	uglifyjs -o longs.min.js longs.js
	uglifyjs -o vintage.min.js vintage.js
	nodeunit test.js

clean:
	rm -f *.js

deps:
	npm install -g coffee-script coffeelint uglify-js nodeunit

deploy: all
	rsync -avz --exclude .git ./ pumpkin:/var/www/jart/long-s.org/

upgrade-static:
	mkdir -p lib
	rm -rf lib/bootstrap
	wget http://twitter.github.com/bootstrap/assets/bootstrap.zip
	unzip bootstrap.zip
	rm bootstrap.zip
	mv bootstrap lib
