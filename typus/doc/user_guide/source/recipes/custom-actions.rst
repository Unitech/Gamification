Custom Actions
==============

You can override and extend Admin::ResourcesController with your methods.
Actions are defined in ``config/typus/application.yml``:

.. code-block:: yaml

  Post:
    ...
    actions:
      index: custom_action
      edit: custom_action_for_an_item

Remember to define permissions on ``config/typus/application_roles.yml`` to
have access to the new actions.

.. code-block:: yaml

  admin:
    Post: all

  editor:
    Post: create, read, update, custom_action_for_an_item

Your controller will look like this ...

.. code-block:: ruby

  class Admin::PostsController < Admin::ResourcesController

    def custom_action
      ...
    end

    def custom_action_for_an_item
      ...
    end

  end
