Single Table Inheritance
========================

Single Table Inheritance in **Typus** is relatively simple. For each model you
have inheriting from a base table you need to have an entry  in the
``application.yml`` file.

Because all models carry the same attributes its possible to create an
anchored node ``(&NAME)`` in the YAML file and then merge that into the inheriting
nodes with the hash merges ``(<<)`` and node reference ``(*NAME)``, as per the
following example:

.. code-block:: yaml

  Property: &PROP_BASE
    fields:
      list: address, suburb, ...(chopped)... is_active, visits, is_featured, agency, user
      form: street_number, ...(chopped)... is_under_offer
      show: id, street_number, ...(chopped)... agency, user
      options:
        selectors: property_type, type
    relationships: agency, user
    application: Property Guide

  SaleProperty:
    <<: *PROP_BASE

  RentalProperty:
    <<: *PROP_BASE

This will setup the parameters which typus will look for when making the
resources available. In order to make the resources accessible you will need
to add the following entries into the ``application_roles.yml``:

.. code-block:: yaml

  admin:
    # Property not listed which means that it isn't shown.
    SaleProperty: all
    RentalProperty: all
    HolidayRentalProperty: all
    ShareRentalProperty: all

In addition to this the controller class files also need to be created in the
``app/controllers/admin`` directory (e.g. ``sale_property_controller.rb``, which
is class ``class Admin::SalePropertiesController < Admin::ResourcesController``)

Once this is done, restart your Rails application and visit the admin route -
the new STI tables should now be available.

.. note::

  Written by `Matthew Savage`_.

.. _Matthew Savage: http://amasses.net/.
