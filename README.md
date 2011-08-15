#Active Embed


## Installation

In Rails, add it to your Gemfile:

``` ruby
gem 'active_embed', :git => 'git://github.com/TeWu/ActiveEmbed.git'
```

## Getting Started

First generate model and run migration:

	rails g model Post content:text author_name:string author_age:integer
	rake db:migrate
  
Then create `Author` class, with will be embedded in `Post` model:

``` ruby
class Author
  include ActiveEmbed::CanBeEmbedded

  def say_hello
    puts "Hi, my name is #{name}"
  end
end
```
Make sure that this class is loaded with your app eg. put it in the `lib` directory and change `config/application.rb` file like this:

``` ruby
...

module MyApp
  class Application < Rails::Application

...
    
    config.autoload_paths += %W(#{config.root}/lib)

...

  end
end
```

Finally embed `Author` class in `Post` model so Author can use Post's `author_*` attributes:

``` ruby
class Post < ActiveRecord::Base
  embeds :author
end
```
Now you can run `rails console` and do fallowing:

	ruby-1.9.2-p180 :001 > p = Post.new :author_name => "Tom"
	 => #<Post id: nil, content: nil, author_name: "Tom", author_age: nil, created_at: nil, updated_at: nil> 
	 
	ruby-1.9.2-p180 :002 > p.author_name
	 => "Tom" 
	 
	ruby-1.9.2-p180 :003 > p.author.name
	 => "Tom" 
	 
	ruby-1.9.2-p180 :004 > p.author
	 => #<Author:0xadfbccc @embeding_record=#<Post id: nil, content: nil, author_name: "Tom", author_age: nil, created_at: nil, updated_at: nil>, @prefix="author"> 
	 
	ruby-1.9.2-p180 :005 > p.author.name = "Alice"
	 => "Alice" 
	 
	ruby-1.9.2-p180 :006 > p.author_name
	 => "Alice" 
	 
	ruby-1.9.2-p180 :007 > p.author.name
	 => "Alice" 
	 
	ruby-1.9.2-p180 :008 > p.author_age
	 => nil 
	 
	ruby-1.9.2-p180 :009 > p.author.age = 22
	 => 22 
	 
	ruby-1.9.2-p180 :010 > p.author_age
	 => 22 
	 
	ruby-1.9.2-p180 :011 > p.author.age
	 => 22
	 
	ruby-1.9.2-p180 :012 > p.author.say_hello
	Hi, my name is Alice
	 => nil 



	ruby-1.9.2-p180 :014 >   p2 = Post.new :content => "This is post's content", :author => {:name => "Fred", :age => 32}
	 => #<Post id: nil, content: "This is post's content", author_name: "Fred", author_age: 32, created_at: nil, updated_at: nil> 

	ruby-1.9.2-p180 :015 > p2.author.name
	 => "Fred"
 
 
