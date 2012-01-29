Selectors
=========

Form selectors are using the instance method ``to_label`` to show instantiated
models.

Having the following model definition:

.. code-block:: ruby

  class Entry < ActiveRecord::Base
    # Attributes: title, author, content
  end

Selectors will look like this: ``Entry#1`` (Model and Id of the item).

Override the method ``to_label`` to show the information you want to:

.. code-block:: ruby

  class Entry < ActiveRecord::Base
    # Attributes: title, author, content

    def to_label
      "#{title} (#{author})"
    end
  end
