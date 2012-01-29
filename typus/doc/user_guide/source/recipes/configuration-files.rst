Configuration Files
===================

You can split your configuration files in several files so it can be easier to
mantain.

.. code-block:: bash

  config/typus/admin.yml
  config/typus/admin_roles.yml
  config/typus/content.yml
  config/typus/content_roles.yml
  config/typus/presentation.yml
  config/typus/presentation_roles.yml

.. note::

  Remember files are loaded alphabetically and last loaded files override
  previous settings.
