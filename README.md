# soccer_league_ranking
Soccer league ranking

Runs a script which calculates league rankings based on match results

## Running the script
The script can be run either directly with ruby or by using docke compose. Either way it takes an input file and output file as arguments.
These default to `input.txt` and `output.txt`.

### Running with ruby
In the root folder of the app run
```
gem install bundler
bundle install
```
to run the app run
```
ruby run.rb {input.txt} {output.txt}
```
### Running with docker-compose
In the root folder of the app run
```
docker-compose build
```
to run the app run
```
docker-compose run soccer_league_run {input.txt} {output.txt}
```
## Running the specs
### Running with bundler
In the root folder of the app run
```
gem install bundler
bundle install
```
to run the specs run
```
bundle exec rspec -fd spec
```
### Running with docker-compose
In the root folder of the app run
```
docker-compose build
```
to run the specs
```
docker-compose run soccer_league_spec
```