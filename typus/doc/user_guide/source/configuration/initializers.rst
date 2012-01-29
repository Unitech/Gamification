Initializers
============

You can configure the admin panel using the initializer the generator created.
You can find it at ``config/initializers/typus.rb``.


Admin Title
-----------

The ``admin_title`` is what is shown on the login page and as a header of
the admin panel. When the generator is run the application will use the folder
name of the Rails application.

.. code-block:: ruby

  Typus.setup do |config|
    config.admin_title = "Application Name"
  end


Admin Sub Title
---------------

The ``admin_sub_title`` is shown at the login page and at the admin panel
footer.

.. code-block:: ruby

  Typus.setup do |config|
    config.admin_sub_title = "Developed by ..."
  end


Authentication
--------------

There are 3 authentication methods: ``none``, ``basic``, ``session`` and ``devise``.

By default the application uses the ``none``. To use the ``session`` method,
you'll need to run the ``typus:migration`` generator as a users table is
needed.

.. code-block:: ruby

  Typus.config.setup do |config|
    config.authentication = :none|:http_basic|:session
  end

With the ``session`` authentication you'll be able to use roles.


Mailer Sender
-------------

Recover password is disabled by default. To enable it you should provide an
email address which will be shown as the sender.

.. code-block:: ruby

    Typus.setup do |config|
      config.mailer_sender = "blackhole@core.typuscmf.com"
    end


Master Role
-----------

This is the value of the master role of the application. By default we use
the role admin as the default value.

.. code-block:: ruby

  Typus.setup do |config|
    config.master_role = "admin"
  end


User Class Name
---------------

.. code-block:: ruby

  Typus.setup do |config|
    config.user_class_name = "TypusUser"
  end


User Foreign Key
----------------

.. code-block:: ruby

  Typus.setup do |config|
    config.user_foreign_key = "typus_user_id"
  end


Subdomain
---------

If you need your application to be served from a subdomain you need to set the
``subdomain`` setting.

.. code-block:: ruby

  Typus.setup do |config|
    config.subdomain = "admin" # Default is nil
  end
