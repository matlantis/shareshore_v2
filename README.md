# Shareship #

## Setup ##

### Installing rails ###

following https://gorails.com/setup/ubuntu/16.04, using rbenv method, and postgresql

### Start the server ###

    rails server

## Admin Guide ##

Shareship wird momentan ausschliesslich via rails console administriert.

### Entering Rails Console ###

Lokal:

    rails console
    
Heroku:

    heroku run rails console
    
### User loeschen ###

    User.where({nickname: "roberto"}).first.destroy

## Development Notes ##

### Publish on Heroku ###

    git push heroku
    
    # if db schema has changed
    heroku run rake db:migrate
    heroku restart

### Database inspection ###

    ActiveRecord::Base.connection.tables
    Article.column_names

look into db/schema.rb

### Rake tasks ###

    rake db:create
    rake db:reset, equals: rake db:drop db:setup
    rake db:rollback
    rake db:migrate
    rake db:seed
    rake routes
    rake doc:guides => doc/guides/index.html
    rake doc:rails => doc/api/index.html

### Convert html to haml (autogenerated files) ###

convert

    for file in `find . -name "*.html.erb"`; do html2haml --unix-newlines "$file" "$(dirname "$file")/$(basename "$file" ".html.erb").html.haml"; done

remove old files

    for file in `find . -name "*.html.erb"`; do rm "$file"; done