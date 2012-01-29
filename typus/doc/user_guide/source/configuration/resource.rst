Resource
========

Sometimes your need to manage some services, view log files or do any other
task which is not related to a model.

Let's say for example you want to see the `memcached` status of your application
and also want to be able to flush all the keys.

First of all we will create a controller:

.. code-block:: ruby

  class Admin::MemcachedController < Admin::ResourceController

    # Here we return the status of the service.
    def index
      ...
    end

    # Here we flush all the keys and redirect to the index.
    def flush_all
      ...
      redirect_to :back, :notice => Typus::I18n.t("Memcached has been flushed.")
    end

  end

We will need some views for the new controller. We will create them on the
application: `app/views/admin/memcached/index.html.erb`

**Remember:** In order to have access to the "tableless resources" you need to
add them to the roles.
