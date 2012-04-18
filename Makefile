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

deploy:
	rsync -avz --exclude .git ./ pumpkin:/var/www/jart/long-s.org/
