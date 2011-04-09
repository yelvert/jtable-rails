[jTable](http://www.jtable.net/) - jQuery Datagrid done right
=============================================================

[jTable JS project](https://github.com/yelvert/jtable)

[jtable-rails RubyGem](https://github.com/yelvert/jtable-rails)

[jTable.net source](https://github.com/yelvert/jtable-site)


Usage
=====

Basic
-----
    class Person < ActiveRecord::Base
      jtable :basic, :first_name, :last_name
    end

This creates a jTable called *basic* with the attributes *first_name* and *last_name*.

One-to-One Association
----------------------
    class Person < ActiveRecord::Base
      has_one :place
      
      jtable :one_to_one, :first_name, :last_name, {:place => [:city, :state]}
    end

This creates a jTable called *one_to_one* with the *person* attributes *first_name* and *last_name*, and the *place_attributes* *city* and *state*