Resources
=========

All application models, including the ones on the engines/plugins, can be
configured using the ``yaml`` files placed on ``config/typus``. Files under this
folder are created using the generator detecting the models localed under ``app/models``.

There are two kind of files, the ``*.yml`` and the ``*_roles.yml``. Look at the
generated files to see the available options.

Some resources options can be configured using the initializer the generator
created. You can find it at ``config/initializers/typus_resources.rb``.


Fields
------
Define the collection of fields which you want to display on different parts
of the site. List is for lists, form is for forms.

.. code-block:: yaml

  Photo:
    fields:
      default: name
      list: name, created_at, category, status
      form: name, body, created_at, status
      csv: name, body
      xml: name, created_at, status


File Fields
^^^^^^^^^^^

File upload works for ``Paperclip`` and ``Dragonfly``.

.. code-block:: ruby

  class Attachment < ActiveRecord::Base

    ##
    # Dragonfly
    #
    #     create_table :attachments do |t|
    #       t.string :file_uid
    #     end
    #

    image_accessor :file
    validates :file, :presence => true

    ##
    # Paperclip:
    #
    #     create_table :attachments do |t|
    #       t.string :file_file_name
    #       t.string :file_content_type
    #       t.integer :file_file_size
    #       t.datetime :file_updated_at
    #     end
    #

    has_attached_file :file

  end

If you want to upload files to your application you only need to define the
attached file name which in this case is ``file``.

.. code-block:: yaml

    Photo:
      fields:
        default: asset
        list: asset
        form: asset


Read Only Fields
^^^^^^^^^^^^^^^^

Use ``attr_protected`` to mark fields as read only. Rails 3.1 accepts the option
``:as`` to specify a role.

.. code-block:: ruby

    class Photo < ActiveRecord::Base
      attr_protected :name, :as => :editor # Editor will see the attribute as read only.
    end


Auto Generated Fields
^^^^^^^^^^^^^^^^^^^^^

Define ``auto generated`` fields.

.. code-block:: yaml

  Order:
    fields:
      ...
      options:
        auto_generated: tracking_number

You can then initialize it from the model.

.. code-block:: ruby

  # app/models/order.rb
  class Order < ActiveRecord::Base

    def initialize_with_defaults(attributes = nil, &block)
      initialize_without_defaults(attributes) do
        self.tracking_number = Random.tracking_number
        yield self if block_given?
      end
    end

    alias_method_chain :initialize, :defaults

  end


Virtual attribute fields
^^^^^^^^^^^^^^^^^^^^^^^^

Define a ``virtual attributes``. (i.e. model which has an slug attribute
which is generated from the title)

.. code-block:: ruby

  # app/models/post.rb
  class Post < ActiveRecord::Base

    validates :title, :presence => true

    def slug
      title.parameterize
    end

  end

Add ``slug`` as field and it'll be shown on the listings.

.. code-block:: yaml

  # config/typus/application.yml
  Post:
    fields:
      list: title, slug

.. note::

  When using a virtual attribute you won't be able to search, filter or order
  by that attribute.


Relationships
-------------

The generator will detect which kind of relationships has the model and will
appear on the listings.

.. code-block:: yaml

    Post:
      ...
      relationships: users, projects


Filters
-------

To add filters to a model you need to add the following configuration option
to the yaml file:

.. code-block:: yaml

  Post:
    ...
    filters: ...

Example: Show status, author and created_at filters on posts.

.. code-block:: yaml

  Post:
    ...
    filters: status, author, created_at

Attributes with ``boolean``, ``date``, ``datetime`` and ``timestamp`` data types and
associations will work by default. If you want to have custom filters there's
a little more of work involved.

Example: Show available locales for posts.

.. code-block:: yaml

  # config/typus/posts.yml
  Post:
    ...
    filters: locale

.. code-block:: ruby

  # app/models/post.rb
  class Post < ActiveRecord::Base
    def self.locales
      Typus::I18n.available_locales
    end
  end


Order
-----

If **order_by** is not set, the default scope will be used.

Set the default display order of the items on a model.

.. code-block:: yaml

  Post:
    ...
    order_by: name, -created_at

.. note::

  Adding minus (-) sign before the attribute will make the order DESC.

Searches
--------

Define which fields will be used when performing a search on the model.

.. code-block:: yaml

  Post:
    ...
    search: name, body

Default search performs a full-text match. For faster searches you can use the
following operators:

* ^: Matches the beginning of the field
* =: Matches exactly.
* @: Performs a full-text search match. This is the default behavior.

Example:

.. code-block:: yaml

  Post:
    ...
    search: =name, body


Selectors
---------

Need a selector, to select gender, size, status, the encoding status of a
video or whatever in the model?

.. code-block:: yaml

  Person:
    fields:
      ...
      options:
        selectors: gender, size, status

From now on the form, if you have enabled them on the list/form you'll see a
selector with the options that you define in your model.

.. code-block:: ruby

  # app/models/video.rb
  class Video < ActiveRecord::Base
    STATUS = %w(pending encoding encoded error published)
    validates_inclusion_of :status, :in => STATUS
  end

.. note::

  If the selector is not defined, you'll see a ``text field`` instead of a
  ``select field``.


Booleans
--------

Boolean text shows ``true`` and ``false``, but you can personalize it by
attribute to match your application requirements.

.. code-block:: yaml

  # config/typus/application.yml
  TypusUser:
    fields:
      default: email, status
      options:
        booleans:
          # attribute: true, false
          default: publicado, no_publicado
          status: ["It's active", "It's inactive"]


Date Formats
------------

Date formats allows to define the format of the datetime field.

.. code-block:: yaml

  # config/typus/application.yml
  Post:
    fields:
      ...
      options:
        date_formats:
          published_at: post_short

.. code-block:: ruby

  # config/initializers/dates.rb
  Date::DATE_FORMATS[:post_short] = '%m/%Y'
  Time::DATE_FORMATS[:post_short] = '%m/%y'


Actions
-------

Define more actions which will be shown on the requested action.

.. code-block:: yaml

  Post:
    ...
    actions:
      index: notify_all
      edit: notify

Add those actions to your admin controllers.

.. code-block:: ruby

  class Admin::NewslettersController < AdminController

    # Action to deliver emails ...
    def deliver
      ...
      redirect_to :back
    end

  end

For feedback you can use the following flash methods.

* ``flash[:notice]`` to deliver feedback.
* ``flash[:alert]`` when there's something wrong.


Exporting Data
--------------

**Typus** allows to export data. Only XML and CSV exporting methods are
implemented but you can easily add your own. You will see the export links on
the sidebar of your resource.

.. code-block:: yaml

  Order:
    ...
    export: csv, xml

And the actions for those export options are:

.. code-block:: ruby
  
  def export_csv
    # Already implemented but you can override it.
  end

  def export_xml
    # Already implemented but you can override it.
  end


Applications
------------

To group resources into an application use ``application``.

.. code-block:: yaml

  Model:
    ...
    application: CMS

Models will now appear in the dashboard grouped. When you're updating data on
a model, you'll see on the sidebar the models of the same group. This will
make navigation easier between these grouped models.


Options
-------

End Year
^^^^^^^^

.. code-block:: ruby

  Typus::Resources.setup do |config|
    config.end_year = 2015
  end

You can also define this option by model.

.. code-block:: yaml

  Post:
    ...
    options:
      end_year: 2015


Form Rows
^^^^^^^^^

.. code-block:: ruby

  Typus::Resources.setup do |config|
    config.form_rows = 25
  end

You can also define this option by model.

.. code-block:: yaml

  Post:
    ...
    options:
      form_rows: 25


Minute Step
^^^^^^^^^^^

.. code-block:: ruby

  Typus::Resources.setup do |config|
    config.minute_step = 15
  end

You can also define this option by model.

.. code-block:: yaml

  Post:
    ...
    options:
      minute_step: 15


Per Page
^^^^^^^^

.. code-block:: ruby

  Typus::Resources.setup do |config|
    config.per_page = 15
  end

You can also define this option by model.

.. code-block:: yaml

  Post:
    ...
    options:
      per_page: 15


Start Year
^^^^^^^^^^

.. code-block:: ruby

  Typus::Resources.setup do |config|
    config.start_year = 1990
  end

You can also define this option by model.

.. code-block:: yaml

  Post:
    ...
    options:
      start_year: 1990
