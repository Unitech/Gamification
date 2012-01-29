User Interface
==============

You can customize the admin panel interface overwriting the default templates
included with the plugin.

It's recommended to run the ``typus:views`` generator to copy the default
templates into your application.

.. code-block:: bash

    $ rails generate typus:views


Dashboard
---------

To override dashboard's sidebar:

.. code-block:: none

  views/admin/dashboard/_sidebar.html.erb


Resource views and partials
---------------------------

You can override views and partials for all resources or by resource.

For all ``resources``:

.. code-block:: none

  views/admin/resources/index.html.erb
  views/admin/resources/_index.html.erb
  views/admin/resources/new.html.erb
  views/admin/resources/_new.html.erb
  views/admin/resources/edit.html.erb
  views/admin/resources/_edit.html.erb
  views/admin/resources/show.html.erb
  views/admin/resources/_show.html.erb

For ``articles``:

.. code-block:: none

  views/admin/articles/index.html.erb
  views/admin/articles/_index.html.erb
  ...
  views/admin/resources/show.html.erb
  views/admin/resources/_show.html.erb
