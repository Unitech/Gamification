Installation Instructions
=========================

To install **Typus**, edit the application ``Gemfile`` and add:

.. code-block:: ruby

  gem 'typus'

  # Bundle edge Typus instead:
  # gem 'typus', :git => 'https://github.com/typus/typus.git'

Install the **RubyGem** using ``bundler``:

.. code-block:: bash

  bundle install

**Typus** expects to have models to manage, so run the generator in order to
generate the required configuration files:

.. code-block:: bash

  rails g typus

Start the application server, go to http://0.0.0.0:3000/admin and follow the
instructions.
