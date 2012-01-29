Roles
=====

**Typus** roles are stored on ``yaml`` files.

On the ``config/typus`` folder you'll find ``yaml`` files which ending
with ``_roles.yml``, there is where the setup is done.


Anatomy of a Role
-----------------

You can add as many roles as you want and the access control allows you to
give access to users from a role to the ``CRUD`` methods of a model and to
custom actions you define per model.

.. code-block:: ruby

  # Role
  admin:
    # Model which has access to all actions
    Category: all
    # Model which has acces to default methods.
    Post: create, read, update, delete
    # Model can't delete but can deliver.
    Newsletter: create, read, update, deliver
    # Resource (which is tableless)
    Redis: all

As an example for a real application:

.. code-block:: ruby

  admin:
    AdminUser: all
    Category: all
    Post: all
    Redis: all

  editor:
    Category: create, read, update
    Post: create, read, update
    Redis: index
