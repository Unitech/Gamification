Using Typus' export features on Heroku (fixes the 0 byte export issue)
======================================================================

This pertains to any environment where the web server is a separate process
from the one that runs the Ruby/Rails application, such as Heroku. The primary
symptom would be that all exports result in 0 byte files in production, though
they work as expected in development.

In ``config/environments/production.rb``, comment out the line that reads:

.. code-block:: ruby

  config.action_dispatch.x_sendfile_header = "X-Sendfile"

Then commit your change and push to Heroku. That's it.

See `this thread on the Heroku mailing list`_ for background info.

.. _this thread on the Heroku mailing list: http://groups.google.com/group/heroku/msg/a6c50309e924dbb4
