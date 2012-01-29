Devise Authentication
=====================

Add **Typus** and **Devise** to your ``Gemfile``:

.. code-block:: ruby

  gem "devise", "~> 1.5.2"
  gem "typus", "~> 3.1.5"

Generate **Devise** required stuff:

.. code-block:: bash

  rails generate devise:install
  rails generate devise AdminUser
  rake db:migrate

Run the **Typus** generator:

.. code-block:: bash

  rails generate typus

Configure the initializer:

.. code-block:: ruby

    # config/initializers/typus.rb
    Typus.setup do |config|
      config.authentication = :devise
    end

There are some changes you need to do to your ``AdminUser``.

.. code-block:: ruby

  require 'typus/orm/active_record/user/instance_methods'
  require 'typus/orm/active_record/user/instance_methods_more'

  class DeviseUser < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :registerable, :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

    # Setup accessible (or protected) attributes for your model
    attr_accessible :email, :password, :password_confirmation, :remember_me
    attr_accessible :email, :password, :password_confirmation, :remember_me, :as => :admin

    include Typus::Orm::ActiveRecord::User::InstanceMethods
    include Typus::Orm::ActiveRecord::User::InstanceMethodsMore
  end

Finally start your application and go to http://localhost:3000/admin, you should
be redirected to the sign in form provided by devise.
