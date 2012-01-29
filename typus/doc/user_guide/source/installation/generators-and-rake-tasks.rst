Generators and Rake Tasks
=========================

Once the gem is installed you need to run a generator to copy **Typus**
stylesheets, images and other required files into your application.

.. code-block:: bash

  rails generate typus

By default **Typus** will not enable any authentication mechanism. If you want
to add ``session`` authentication you need to run a generator and migrate your
application database:

.. code-block:: bash

  rails generate typus:migration
  rake db:migrate

This generator creates a new model, ``AdminUser`` and adds some settings which
will be stored under ``config/typus`` folder. You can see some options of this
generator running the following command:

.. code-block:: bash

  rails generate typus:migration -h

If you want to customize views you can copy default views to your application:

.. code-block:: bash

  rails generate typus:views

To see a list of **Typus** related tasks run:

.. code-block:: bash

  rake -T typus
